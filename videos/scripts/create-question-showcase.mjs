#!/usr/bin/env node

import { access, copyFile, mkdir, readFile, writeFile } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { getOcrData, getHighlightRects } from "./image-highlights.mjs";
import { prepareQuestionMusic } from "./question-music.mjs";

const imageExtensions = new Set([".jpg", ".jpeg", ".png", ".webp"]);

const getOptions = (args) =>
  args.reduce(
    (options, value, index) =>
      value.startsWith("--")
        ? { ...options, [value.slice(2)]: args[index + 1] ?? true }
        : options,
    {},
  );

const getSlug = (value) =>
  value
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "")
    .slice(0, 48) || "question";

const getNumber = (value, fallback) =>
  value === undefined ? fallback : Number(value);

const getExtension = (file) => path.extname(file).toLowerCase();

const options = getOptions(process.argv.slice(2));
const question = options.question;
const media = options.media;
const verseHighlight = options["verse-highlight"];
const studyHighlight = options["study-highlight"];

if (
  typeof question !== "string" ||
  typeof media !== "string" ||
  typeof verseHighlight !== "string" ||
  typeof studyHighlight !== "string"
) {
  throw new Error(
    'Usage: node scripts/create-question-showcase.mjs --question "..." --media /path/to/screenshot.png --verse-highlight "..." --study-highlight "..." [--background /path/to/background] [--slug name]',
  );
}

if (!imageExtensions.has(getExtension(media))) {
  throw new Error(
    "Guided question showcases require a PNG, JPG, JPEG, or WebP screenshot.",
  );
}

const durationInSeconds = getNumber(options.duration, 16.5);
const mediaScale = getNumber(options["media-scale"], 1);
const mediaVolume = getNumber(options["media-volume"], 0);
const backgroundDarkness = getNumber(options["background-darkness"], 0.48);
const backgroundSaturation = getNumber(options["background-saturation"], 0.18);
const backgroundBrightness = getNumber(options["background-brightness"], 0.42);
const colors =
  typeof options.colors === "string"
    ? options.colors.split(",").map((color) => color.trim())
    : ["#09130f", "#14261d", "#2c4336", "#0b1712"];

if (
  [
    durationInSeconds,
    mediaScale,
    mediaVolume,
    backgroundDarkness,
    backgroundSaturation,
    backgroundBrightness,
  ].some((value) => !Number.isFinite(value))
) {
  throw new Error("Duration, media scale, and media volume must be numbers.");
}

if (colors.length !== 4) {
  throw new Error("--colors must contain exactly four comma-separated colors.");
}

await access(media);
if (typeof options.background === "string") await access(options.background);
const ocrData = await getOcrData(media);
const verseHighlightRects = getHighlightRects(ocrData, verseHighlight);
const studyHighlightRects = getHighlightRects(ocrData, studyHighlight);

const videosDirectory = path.resolve(
  path.dirname(fileURLToPath(import.meta.url)),
  "..",
);
const slug =
  typeof options.slug === "string" ? getSlug(options.slug) : getSlug(question);
const assetDirectory = path.join(
  videosDirectory,
  "public",
  "videos",
  "question-showcase",
  slug,
);
const jobsDirectory = path.join(
  videosDirectory,
  "src",
  "videos",
  "question-showcase",
  "jobs",
);
const propsPath = path.join(jobsDirectory, `${slug}.json`);
const mediaFileName = `media${getExtension(media)}`;
const backgroundFileName =
  typeof options.background === "string"
    ? `background${getExtension(options.background)}`
    : "";

if (options.force !== "true") {
  await access(propsPath)
    .then(() => {
      throw new Error(
        `A question showcase named ${slug} already exists. Choose another --slug or pass --force true to replace it.`,
      );
    })
    .catch((error) => {
      if (error.code !== "ENOENT") throw error;
    });
}

await mkdir(assetDirectory, { recursive: true });
await mkdir(jobsDirectory, { recursive: true });
await copyFile(media, path.join(assetDirectory, mediaFileName));
if (typeof options.background === "string") {
  await copyFile(
    options.background,
    path.join(assetDirectory, backgroundFileName),
  );
}

const publicAssetRoot = `videos/question-showcase/${slug}`;
const existingProps =
  options.force === "true"
    ? await readFile(propsPath, "utf8")
        .then(JSON.parse)
        .catch((error) => {
          if (error.code === "ENOENT") return {};
          throw error;
        })
    : {};
const props = {
  question,
  callToAction:
    typeof options.cta === "string" ? options.cta : "See More Below ↓",
  mediaSrc: `${publicAssetRoot}/${mediaFileName}`,
  backgroundSrc: backgroundFileName
    ? `${publicAssetRoot}/${backgroundFileName}`
    : "",
  durationInSeconds,
  mediaScale,
  mediaVolume,
  backgroundDarkness,
  backgroundSaturation,
  backgroundBrightness,
  verseHighlightRects,
  studyHighlightRects,
  shaderColor1: colors[0],
  shaderColor2: colors[1],
  shaderColor3: colors[2],
  shaderColor4: colors[3],
};

Object.assign(
  props,
  await prepareQuestionMusic({
    videosDirectory,
    assetDirectory,
    props: {
      ...props,
      musicSource: existingProps.musicSource,
      musicVolume: existingProps.musicVolume,
    },
  }),
);

await writeFile(propsPath, `${JSON.stringify(props, null, 2)}\n`);

console.log(propsPath);
console.log(
  `npx remotion render QuestionShowcase out/${slug}.mp4 --props=${path.relative(videosDirectory, propsPath)}`,
);
