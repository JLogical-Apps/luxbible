import { execFile } from "node:child_process";
import { readFile, writeFile } from "node:fs/promises";
import { promisify } from "node:util";

const runFile = promisify(execFile);
export const getCaptions = (transcript, replacements = {}) => {
  const tokens = transcript.transcription
    .flatMap((segment) => segment.tokens)
    .filter((token) => !token.text.startsWith("[_"));
  const words = tokens
    .reduce((words, token) => {
      const timestamp =
        token.t_dtw >= 0 ? token.t_dtw * 10 : token.offsets.from;
      return token.text.startsWith(" ") || words.length === 0
        ? [...words, { text: token.text.trim(), timestamp }]
        : [
            ...words.slice(0, -1),
            { ...words.at(-1), text: words.at(-1).text + token.text },
          ];
    }, [])
    .filter((word) => /[a-z0-9]/i.test(word.text));
  return words.map((word, index) => {
    const startMs = Math.max(0, word.timestamp - 130);
    return {
      text: " " + (replacements[word.text] ?? word.text),
      startMs,
      endMs: Math.max(
        startMs + 100,
        Math.min(
          (words[index + 1]?.timestamp ?? word.timestamp + 600) - 130,
          startMs + 1000,
        ),
      ),
      timestampMs: word.timestamp,
      confidence: null,
    };
  });
};

export const transcribeFacecam = async ({
  source,
  directory,
  model,
  transcriptPath,
  replacements,
}) => {
  if (!transcriptPath) {
    const audio = `${directory}/transcribe.wav`;
    await runFile("ffmpeg", [
      "-v",
      "error",
      "-y",
      "-i",
      source,
      "-vn",
      "-ar",
      "16000",
      "-ac",
      "1",
      audio,
    ]);
    const preset = model.match(/ggml-(.+)\.bin$/)?.[1];
    if (!preset)
      throw new Error(
        "Use a ggml Whisper model filename to identify its DTW preset.",
      );
    await runFile(
      "whisper-cli",
      [
        "-m",
        model,
        "-f",
        audio,
        "--dtw",
        preset,
        "-nfa",
        "-ng",
        "-ojf",
        "-np",
        "-of",
        `${directory}/transcript`,
      ],
      { maxBuffer: 20 * 1024 * 1024 },
    );
    transcriptPath = `${directory}/transcript.json`;
  }
  const transcript = await readFile(transcriptPath, "utf8");
  await writeFile(`${directory}/transcript.json`, transcript);
  const captions = getCaptions(JSON.parse(transcript), replacements);
  await writeFile(
    `${directory}/captions.json`,
    JSON.stringify(captions, null, 2) + "\n",
  );
  return captions;
};
