import { execFile } from "node:child_process";
import { randomInt } from "node:crypto";
import { copyFile, readdir, stat } from "node:fs/promises";
import path from "node:path";
import { promisify } from "node:util";

const runFile = promisify(execFile);
const audioExtensions = new Set([
  ".mp3",
  ".wav",
  ".m4a",
  ".aac",
  ".flac",
  ".ogg",
]);
export const getLeastRecentlyUsedMusic = async (directory) => {
  const entries = await readdir(directory, { withFileTypes: true });
  const tracks = await Promise.all(
    entries
      .filter(
        (entry) =>
          entry.isFile() &&
          !entry.name.startsWith(".") &&
          audioExtensions.has(path.extname(entry.name).toLowerCase()),
      )
      .map(async (entry) => {
        const source = path.join(directory, entry.name);
        const info = await stat(source, { bigint: true });
        return { source, modified: info.mtimeNs };
      }),
  );
  if (tracks.length === 0)
    throw new Error(`No music tracks found in ${directory}`);
  const oldest = tracks.reduce((a, b) =>
    a.modified < b.modified ? a : b,
  ).modified;
  const candidates = tracks.filter((track) => track.modified === oldest);
  return candidates[randomInt(candidates.length)].source;
};

export const prepareQuestionMusic = async ({
  videosDirectory,
  assetDirectory,
  props,
}) => {
  const source = props.musicSource
    ? path.resolve(videosDirectory, "..", props.musicSource)
    : await getLeastRecentlyUsedMusic(
        path.join(videosDirectory, "music", "chill"),
      );
  const { stdout } = await runFile("ffprobe", [
    "-v",
    "error",
    "-select_streams",
    "a:0",
    "-show_entries",
    "stream=codec_type:format=duration",
    "-of",
    "json",
    source,
  ]);
  const info = JSON.parse(stdout);
  const trackDuration = Number(info.format?.duration);
  if (
    info.streams.length === 0 ||
    !Number.isFinite(trackDuration) ||
    trackDuration <= 0
  ) {
    throw new Error(`Not a playable music track: ${source}`);
  }
  const duration = props.durationInSeconds;
  const overlap = Math.min(0.25, trackDuration / 4);
  const repetitions = Math.max(
    1,
    Math.ceil((duration - overlap) / (trackDuration - overlap)),
  );
  const inputArgs = Array.from({ length: repetitions }, () => [
    "-i",
    source,
  ]).flat();
  const joins = Array.from(
    { length: repetitions - 1 },
    (_, index) =>
      `${index === 0 ? "[audio0]" : `[join${index}]`}[audio${index + 1}]acrossfade=d=${overlap}[join${index + 1}]`,
  );
  const resampling = Array.from(
    { length: repetitions },
    (_, index) => `[${index}:a]aresample=48000[audio${index}]`,
  );
  const input = repetitions === 1 ? "[audio0]" : `[join${repetitions - 1}]`;
  const fade = Math.min(0.6, duration / 4);
  const treatment = `${input}atrim=duration=${duration},asetpts=PTS-STARTPTS,afade=t=in:d=${fade},afade=t=out:st=${duration - fade}:d=${fade},aresample=48000`;
  const target = props.mediaVolume > 0 ? -36 : -17;
  const normalization = `loudnorm=I=${target}:TP=-2:LRA=7`;
  const { stderr } = await runFile(
    "ffmpeg",
    [
      "-hide_banner",
      "-nostdin",
      ...inputArgs,
      "-filter_complex",
      [
        ...resampling,
        ...joins,
        `${treatment},${normalization}:print_format=json[out]`,
      ].join(";"),
      "-map",
      "[out]",
      "-f",
      "null",
      "-",
    ],
    { maxBuffer: 10 * 1024 * 1024 },
  );
  const measured = JSON.parse(
    stderr.slice(stderr.lastIndexOf("{"), stderr.lastIndexOf("}") + 1),
  );
  const secondPass = `${normalization}:measured_I=${measured.input_i}:measured_TP=${measured.input_tp}:measured_LRA=${measured.input_lra}:measured_thresh=${measured.input_thresh}:offset=${measured.target_offset}:linear=true`;
  await runFile("ffmpeg", [
    "-hide_banner",
    "-loglevel",
    "error",
    "-nostdin",
    "-y",
    ...inputArgs,
    "-filter_complex",
    [...resampling, ...joins, `${treatment},${secondPass}[out]`].join(";"),
    "-map",
    "[out]",
    "-ar",
    "48000",
    "-ac",
    "2",
    "-c:a",
    "pcm_s24le",
    path.join(assetDirectory, "music.wav"),
  ]);
  await copyFile(
    source,
    path.join(assetDirectory, `music-source${path.extname(source)}`),
  );
  return {
    musicSource: path.relative(path.dirname(videosDirectory), source),
    musicSrc: path.relative(
      path.join(videosDirectory, "public"),
      path.join(assetDirectory, "music.wav"),
    ),
    musicVolume: props.musicVolume ?? 1,
  };
};
