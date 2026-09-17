#!/usr/bin/env node
import { execFile } from "node:child_process";
import {
  access,
  copyFile,
  mkdir,
  rename,
  readFile,
  writeFile,
} from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { promisify } from "node:util";
import { getOcrData, getHighlightRects } from "./image-highlights.mjs";
import { getVideoMetadata, getVideoFilters } from "./video-preparation.mjs";
import {
  prepareFacecamNarrationSource,
  prepareFacecamTakes,
} from "./facecam-takes.mjs";
import { prepareQuestionMusic } from "./question-music.mjs";
import { prepareNarration } from "./narration-audio.mjs";
import { transcribeFacecam } from "./facecam-captions.mjs";

const runFile = promisify(execFile);
const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const manifestPath = process.argv[2];
if (!manifestPath)
  throw new Error(
    "Usage: node scripts/create-facecam.mjs <manifest.json> [--reuse-media]",
  );
const manifest = JSON.parse(await readFile(manifestPath, "utf8"));
if (!/^[a-z0-9]+(?:-[a-z0-9]+)*$/.test(manifest.slug))
  throw new Error("Use a lowercase hyphenated slug.");
const reuseMedia = process.argv.includes("--reuse-media");
const assets = path.join(root, "public/videos/facecam", manifest.slug);
const jobs = path.join(root, "src/videos/facecam/jobs");
const publicRoot = `videos/facecam/${manifest.slug}`;
await mkdir(assets, { recursive: true });
await mkdir(jobs, { recursive: true });
const propsFile = path.join(jobs, `${manifest.slug}.json`);
if (
  !process.argv.includes("--force") &&
  (await access(propsFile)
    .then(() => true)
    .catch(() => false))
)
  throw new Error("This job exists. Pass --force for an intentional revision.");
const prepareVideo = async (source, destination, isFacecam = false) => {
  if (
    reuseMedia &&
    (await access(destination)
      .then(() => true)
      .catch(() => false))
  )
    return;
  const metadata = await getVideoMetadata(source);
  const filters = getVideoFilters(metadata, isFacecam);
  const temporary = destination.replace(/\.mp4$/, "-preparing.mp4");
  await runFile(
    "ffmpeg",
    [
      "-v",
      "error",
      "-y",
      "-i",
      source,
      "-map",
      "0:v:0",
      "-an",
      "-vf",
      filters.join(","),
      "-c:v",
      "libx264",
      "-preset",
      "fast",
      "-crf",
      "18",
      "-color_primaries",
      "bt709",
      "-color_trc",
      "bt709",
      "-colorspace",
      "bt709",
      "-movflags",
      "+faststart",
      temporary,
    ],
    { maxBuffer: 10 * 1024 * 1024 },
  );
  await rename(temporary, destination);
};
const overlays = [];
for (const item of manifest.overlays) {
  const isImage = [".png", ".jpg", ".jpeg", ".webp"].includes(
    path.extname(item.source).toLowerCase(),
  );
  const destination = path.join(
    assets,
    `${item.id}${isImage ? path.extname(item.source) : ".mp4"}`,
  );
  if (isImage) await copyFile(item.source, destination);
  else await prepareVideo(item.source, destination);
  const media = await getVideoMetadata(destination);
  const lastFrame = isImage ? 0 : (Math.round(media.duration * 30) - 1) / 30;
  const getStill = async (seconds) => {
    if (isImage) return `${publicRoot}/${path.basename(destination)}`;
    const time = Math.min(lastFrame, seconds);
    const filename = `${item.id}-${Math.round(time * 30)}.png`;
    await runFile("ffmpeg", [
      "-v",
      "error",
      "-y",
      "-ss",
      String(time),
      "-i",
      destination,
      "-frames:v",
      "1",
      path.join(assets, filename),
    ]);
    return `${publicRoot}/${filename}`;
  };
  const segments = [];
  for (const [index, segment] of item.segments.entries()) {
    const sourceTime = segment.sourceTime;
    const until =
      segment.playUntil === "end"
        ? lastFrame
        : (segment.playUntil ?? sourceTime);
    const playbackRate = segment.playbackRate ?? 1;
    const playSeconds = (until - sourceTime) / playbackRate;
    if (playSeconds < 0 || sourceTime > lastFrame)
      throw new Error(`Invalid source times in ${item.id}.`);
    if (
      segment.at + playSeconds >
      (item.segments[index + 1]?.at ?? item.end) + 1 / 30
    )
      throw new Error(`Playback overlaps the next cue in ${item.id}.`);
    segments.push({
      at: segment.at,
      sourceTime,
      playSeconds,
      playbackRate,
    });
  }
  const highlights = [];
  for (const highlight of item.highlights ?? []) {
    const still = await getStill(
      highlight.sourceTime === "end" ? lastFrame : highlight.sourceTime,
    );
    const ocr = await getOcrData(
      path.join(root, "public", still),
      highlight.ocr,
    );
    if (highlight.region)
      ocr.words = ocr.words.filter(
        (word) =>
          word.top / ocr.height >= highlight.region.top &&
          word.top / ocr.height < highlight.region.bottom,
      );
    highlights.push({
      text: highlight.text,
      start: highlight.start,
      ...(highlight.end === undefined ? {} : { end: highlight.end }),
      ...(highlight.fadeAt === undefined ? {} : { fadeAt: highlight.fadeAt }),
      fadeSeconds: highlight.fadeSeconds ?? 0.35,
      lineDelay: highlight.lineDelay ?? 8 / 30,
      duration: highlight.duration ?? 0.4,
      color: highlight.color ?? "rgba(255, 206, 45, 0.42)",
      rects: getHighlightRects(ocr, highlight.text),
    });
  }
  overlays.push({
    id: item.id,
    src: `${publicRoot}/${path.basename(destination)}`,
    aspectRatio: media.width / media.height,
    start: item.start,
    end: item.end,
    segments,
    highlights,
    ...(item.focus ? { focus: item.focus } : {}),
    ...(item.layout ? { layout: item.layout } : {}),
    ...(item.pixelate ? { pixelate: item.pixelate } : {}),
    circles: item.circles ?? [],
    callouts: item.callouts ?? [],
    sourceScaleX: item.sourceScaleX ?? 1,
    sourceScaleY: item.sourceScaleY ?? 1,
    fadeEdges: item.fadeEdges ?? manifest.defaultFadeEdges ?? true,
    seamlessEdges: item.seamlessEdges ?? false,
  });
}
const facecam = path.join(assets, "facecam.mp4");
let facecamClips = [];
if (manifest.facecamTakes?.length && !reuseMedia)
  facecamClips = await prepareFacecamTakes({
    takes: manifest.facecamTakes,
    destination: facecam,
  });
else await prepareVideo(manifest.facecam, facecam, true);
if (manifest.facecamTakes?.length && reuseMedia) {
  let start = 0;
  for (const [index] of manifest.facecamTakes.entries()) {
    const id = String(index + 1).padStart(3, "0");
    const prepared = path.join(assets, "takes", `${id}.mp4`);
    const clipMetadata = await getVideoMetadata(prepared);
    facecamClips.push({
      id,
      path: prepared,
      start,
      duration: clipMetadata.duration,
    });
    start += clipMetadata.duration;
  }
}
const metadata = await getVideoMetadata(facecam);
const narration = path.join(assets, "narration.wav");
if (
  !reuseMedia ||
  !(await access(narration)
    .then(() => true)
    .catch(() => false))
) {
  const narrationSource = manifest.facecamTakes?.length
    ? await prepareFacecamNarrationSource({
        takes: manifest.facecamTakes,
        destination: path.join(assets, "narration-source.wav"),
      })
    : manifest.facecam;
  await prepareNarration({ source: narrationSource, destination: narration });
}
const captions = await transcribeFacecam({
  source: narration,
  directory: assets,
  model:
    manifest.whisperModel ??
    path.join(process.env.HOME, ".cache/whisper/ggml-base.en.bin"),
  transcriptPath: manifest.transcriptPath,
  replacements: manifest.captionReplacements ?? {
    Luxe: "Lux",
    "4031,": "40:31,",
  },
  phraseReplacements: manifest.captionPhraseReplacements ?? {},
});
const props = {
  title: manifest.title,
  titleSeconds: 3,
  facecamSrc: `${publicRoot}/facecam.mp4`,
  facecamClips: facecamClips.map((clip) => ({
    id: clip.id,
    src: `${publicRoot}/takes/${path.basename(clip.path)}`,
    start: clip.start,
    duration: clip.duration,
  })),
  durationInSeconds: metadata.duration,
  captions,
  overlays,
  facecamZoom: 1,
  facecamZoomOnlyWithSimulator: true,
  facecamFraming: [],
  titleCues: [],
  narrationSrc: `${publicRoot}/narration.wav`,
  narrationVolume: Math.SQRT1_2,
  musicSrc: "",
  musicSource: "",
  musicVolume: 1,
  captionFontSize: 72,
  captionStrokeWidth: 7,
  captionMaxCharacters: 22,
  captionTop: 0.75,
  overlayTop: 0.02,
  overlayBottom: 0.5,
  fadeSeconds: 0.4,
  ...manifest.style,
};
if (manifest.music) {
  const existing = await readFile(propsFile, "utf8")
    .then(JSON.parse)
    .catch(() => ({}));
  Object.assign(
    props,
    await prepareQuestionMusic({
      videosDirectory: root,
      assetDirectory: assets,
      props: {
        ...props,
        mediaVolume: props.narrationVolume,
        musicSource: manifest.musicSource ?? existing.musicSource,
      },
    }),
  );
}
await writeFile(propsFile, JSON.stringify(props, null, 2) + "\n");
console.log(
  `Prepared ${propsFile}\nPreview: npx remotion studio --props=${path.relative(root, propsFile)}\nRender: npx remotion render Facecam out/${manifest.slug}.mp4 --props=${path.relative(root, propsFile)}`,
);
