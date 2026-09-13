import { execFile } from "node:child_process";
import { promisify } from "node:util";

const runFile = promisify(execFile);

export const prepareNarration = async ({ source, destination }) => {
  const treatment =
    "highpass=f=75:p=2,acompressor=threshold=0.1:ratio=2.2:attack=8:release=100:knee=2.82843:makeup=1";
  const normalization = "loudnorm=I=-16:TP=-1.5:LRA=7";
  const input = ["-i", source, "-map", "0:a:0", "-ac", "1"];
  const { stderr } = await runFile("ffmpeg", [
    "-hide_banner", "-nostdin", ...input,
    "-af", `aformat=channel_layouts=mono,${treatment},${normalization}:print_format=json`,
    "-f", "null", "-",
  ], { maxBuffer: 10 * 1024 * 1024 });
  const measured = JSON.parse(
    stderr.slice(stderr.lastIndexOf("{"), stderr.lastIndexOf("}") + 1),
  );
  const keys = ["input_i", "input_tp", "input_lra", "input_thresh", "target_offset"];
  if (!keys.every((key) => Number.isFinite(Number(measured[key]))))
    throw new Error(`Cannot normalize narration with invalid loudness measurements: ${source}`);
  const secondPass = `${normalization}:measured_I=${measured.input_i}:measured_TP=${measured.input_tp}:measured_LRA=${measured.input_lra}:measured_thresh=${measured.input_thresh}:offset=${measured.target_offset}:linear=true`;
  await runFile("ffmpeg", [
    "-hide_banner", "-loglevel", "error", "-nostdin", "-y", ...input,
    "-af", `aformat=channel_layouts=mono,${treatment},${secondPass}`,
    "-ar", "48000", "-c:a", "pcm_s24le", destination,
  ], { maxBuffer: 10 * 1024 * 1024 });
  return measured;
};
