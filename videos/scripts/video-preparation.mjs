import { execFile } from "node:child_process";
import { promisify } from "node:util";

const runFile = promisify(execFile);

export const getVideoMetadata = async (source) => {
  const { stdout } = await runFile("ffprobe", [
    "-v",
    "error",
    "-show_streams",
    "-show_format",
    "-of",
    "json",
    source,
  ]);
  const data = JSON.parse(stdout);
  return {
    ...data.streams.find((stream) => stream.codec_type === "video"),
    duration: Number(data.format.duration ?? 0),
  };
};
export const getVideoFilters = (metadata, isFacecam = false) => [
  ...(isFacecam ? ["scale=1080:1920"] : []),
  ...(["arib-std-b67", "smpte2084"].includes(metadata.color_transfer)
    ? [
        "zscale=t=linear:npl=100",
        "format=gbrpf32le",
        "tonemap=hable:desat=0:peak=10",
        "zscale=p=bt709:t=bt709:m=bt709:r=tv",
      ]
    : []),
  "format=yuv420p",
  "fps=30",
];
