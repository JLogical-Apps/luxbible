import { execFile } from "node:child_process";
import { unlink } from "node:fs/promises";
import { promisify } from "node:util";
import path from "node:path";

const runFile = promisify(execFile);
const videoExtensions = new Set([".mp4", ".mov", ".m4v", ".webm"]);

export const prepareQuestionMedia = async ({ media, assetDirectory, plan }) => {
  const entries = plan ?? [{ file: media }];
  if (
    !entries.some((entry) =>
      videoExtensions.has(path.extname(entry.file).toLowerCase()),
    )
  )
    return null;
  const segments = await Promise.all(
    entries.map(async (entry, index) => {
      const isVideo = videoExtensions.has(
        path.extname(entry.file).toLowerCase(),
      );
      const { stdout } = await runFile("ffprobe", [
        "-v",
        "error",
        "-show_entries",
        "format=duration:stream=width,height",
        "-of",
        "json",
        entry.file,
      ]);
      const info = JSON.parse(stdout);
      const start = entry.trimStart ?? 0;
      const duration = isVideo
        ? (entry.trimEnd ?? Number(info.format.duration)) - start
        : (entry.duration ?? 2);
      const hold = entry.holdAfter ?? 0;
      if (
        ![start, duration, hold].every(Number.isFinite) ||
        start < 0 ||
        duration <= 0 ||
        hold < 0
      )
        throw new Error("Invalid media timing");
      const output = path.join(assetDirectory, `segment-${index}.mp4`);
      const raw = path.join(assetDirectory, `raw-${index}.mp4`);
      await runFile("ffmpeg", [
        "-v",
        "error",
        "-y",
        ...(isVideo ? ["-ss", String(start)] : ["-loop", "1"]),
        "-i",
        entry.file,
        "-an",
        "-vf",
        `scale=1368:2730:force_original_aspect_ratio=decrease,pad=1368:2730:(ow-iw)/2:(oh-ih)/2,setsar=1,fps=30,setpts=PTS-STARTPTS`,
        "-t",
        String(duration),
        "-c:v",
        "libx264",
        "-preset",
        "fast",
        "-crf",
        "18",
        "-r",
        "30",
        "-pix_fmt",
        "yuv420p",
        raw,
      ]);
      await runFile("ffmpeg", [
        "-v",
        "error",
        "-y",
        "-i",
        raw,
        "-vf",
        `tpad=stop_mode=clone:stop_duration=${hold}`,
        "-t",
        String(duration + hold),
        "-r",
        "30",
        "-c:v",
        "libx264",
        "-preset",
        "fast",
        "-crf",
        "18",
        output,
      ]);
      await unlink(raw);
      return { output };
    }),
  );
  const output = path.join(assetDirectory, "recording.mp4");
  await runFile("ffmpeg", [
    "-v",
    "error",
    "-y",
    ...segments.flatMap(({ output }) => ["-i", output]),
    "-filter_complex",
    `${segments.map((_, i) => `[${i}:v]`).join("")}concat=n=${segments.length}:v=1:a=0[out]`,
    "-map",
    "[out]",
    "-c:v",
    "libx264",
    "-preset",
    "fast",
    "-crf",
    "18",
    "-r",
    "30",
    output,
  ]);
  await Promise.all(segments.map(({ output }) => unlink(output)));
  const { stdout } = await runFile("ffprobe", [
    "-v",
    "error",
    "-select_streams",
    "v:0",
    "-show_entries",
    "stream=nb_frames",
    "-of",
    "json",
    output,
  ]);
  const frames = Number(JSON.parse(stdout).streams[0].nb_frames);
  const first = path.join(assetDirectory, "first-frame.png");
  const last = path.join(assetDirectory, "last-frame.png");
  await runFile("ffmpeg", [
    "-v",
    "error",
    "-y",
    "-i",
    output,
    "-frames:v",
    "1",
    first,
  ]);
  await runFile("ffmpeg", [
    "-v",
    "error",
    "-y",
    "-i",
    output,
    "-vf",
    `select=eq(n\\,${frames - 1})`,
    "-frames:v",
    "1",
    last,
  ]);
  return { output, first, last, frames };
};
