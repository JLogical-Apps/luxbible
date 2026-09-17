import { execFile } from "node:child_process";
import { mkdir, rename, writeFile } from "node:fs/promises";
import path from "node:path";
import { promisify } from "node:util";

import { getVideoMetadata, getVideoFilters } from "./video-preparation.mjs";

const runFile = promisify(execFile);

export const prepareFacecamTakes = async ({ takes, destination }) => {
  const directory = path.join(path.dirname(destination), "takes");
  await mkdir(directory, { recursive: true });
  let cursor = 0;
  const clips = [];
  for (const source of takes) {
    const metadata = await getVideoMetadata(source);
    const duration = metadata.duration;
    const firstFrame = Math.round(cursor * 30);
    cursor += duration;
    clips.push({
      source,
      metadata,
      start: firstFrame / 30,
      frames: Math.round(cursor * 30) - firstFrame,
    });
  }
  const parts = [];
  for (const [index, clip] of clips.entries()) {
    const output = path.join(
      directory,
      `${String(index + 1).padStart(3, "0")}.mp4`,
    );
    await runFile(
      "ffmpeg",
      [
        "-v",
        "error",
        "-y",
        "-i",
        clip.source,
        "-an",
        "-vf",
        [
          ...getVideoFilters(clip.metadata, true),
          "tpad=stop_mode=clone:stop_duration=1",
        ].join(","),
        "-frames:v",
        String(clip.frames),
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
        output,
      ],
      { maxBuffer: 10 * 1024 * 1024 },
    );
    parts.push(output);
    console.log(`Prepared facecam take ${index + 1}/${clips.length}`);
  }
  const list = path.join(directory, "concat.txt");
  await writeFile(
    list,
    parts.map((part) => `file '${part.replaceAll("'", "'\\''")}'`).join("\n") +
      "\n",
  );
  const temporary = destination.replace(/\.mp4$/, "-preparing.mp4");
  await runFile(
    "ffmpeg",
    [
      "-v",
      "error",
      "-y",
      "-f",
      "concat",
      "-safe",
      "0",
      "-i",
      list,
      "-map",
      "0:v:0",
      "-an",
      "-c:v",
      "copy",
      "-t",
      String(Math.round(cursor * 30) / 30),
      "-movflags",
      "+faststart",
      temporary,
    ],
    { maxBuffer: 10 * 1024 * 1024 },
  );
  await rename(temporary, destination);
  return clips.map((clip, index) => ({
    id: String(index + 1).padStart(3, "0"),
    path: parts[index],
    start: clip.start,
    duration: clip.frames / 30,
  }));
};

export const prepareFacecamNarrationSource = async ({ takes, destination }) => {
  const list = destination.replace(/\.wav$/, "-concat.txt");
  await writeFile(
    list,
    takes
      .map((take) => `file '${take.replaceAll("'", "'\\''")}'`)
      .join("\n") + "\n",
  );
  await runFile(
    "ffmpeg",
    [
      "-v",
      "error",
      "-y",
      "-f",
      "concat",
      "-safe",
      "0",
      "-i",
      list,
      "-map",
      "0:a:0",
      "-vn",
      "-ar",
      "48000",
      "-ac",
      "1",
      "-c:a",
      "pcm_s24le",
      destination,
    ],
    { maxBuffer: 10 * 1024 * 1024 },
  );
  return destination;
};
