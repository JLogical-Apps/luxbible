import { execFile } from "node:child_process";
import { promisify } from "node:util";

const runFile = promisify(execFile);

const getNormalizedWord = (value) =>
  value
    .normalize("NFKD")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "");

export const getOcrData = async (file, { psm = 6, minConfidence = 0 } = {}) => {
  const { stdout } = await runFile(
    "tesseract",
    [file, "stdout", "--psm", String(psm), "tsv"],
    {
      maxBuffer: 10 * 1024 * 1024,
    },
  );
  const [header, ...lines] = stdout.trim().split("\n");
  const keys = header.split("\t");
  const rows = lines.map((line) =>
    Object.fromEntries(
      keys.map((key, index) => [key, line.split("\t")[index] ?? ""]),
    ),
  );
  const page = rows.find((row) => row.level === "1");

  if (!page)
    throw new Error("Tesseract did not return the screenshot dimensions.");

  return {
    width: Number(page.width),
    height: Number(page.height),
    words: rows
      .filter(
        (row) =>
          row.level === "5" &&
          row.text.trim() &&
          Number(row.conf) >= minConfidence,
      )
      .map((row) => ({
        text: row.text,
        line: `${row.block_num}-${row.par_num}-${row.line_num}`,
        left: Number(row.left),
        top: Number(row.top),
        width: Number(row.width),
        height: Number(row.height),
      })),
  };
};

export const getHighlightRects = ({ width, height, words }, phrase) => {
  const targetWords = phrase
    .split(/\s+/)
    .map(getNormalizedWord)
    .filter(Boolean);
  const start = words.findIndex((_, index) =>
    targetWords.every(
      (targetWord, offset) =>
        getNormalizedWord(words[index + offset]?.text ?? "") === targetWord,
    ),
  );

  if (start < 0) {
    throw new Error(
      `Could not find the exact highlight text in the screenshot: ${phrase}`,
    );
  }

  const matchedWords = words.slice(start, start + targetWords.length);
  const lines = matchedWords.reduce(
    (groups, word) =>
      groups.at(-1)?.[0].line === word.line
        ? [...groups.slice(0, -1), [...groups.at(-1), word]]
        : [...groups, [word]],
    [],
  );

  return lines.map((lineWords) => {
    const left = Math.max(
      0,
      Math.min(...lineWords.map((word) => word.left)) - 14,
    );
    const top = Math.max(
      0,
      Math.min(...lineWords.map((word) => word.top)) - 10,
    );
    const right = Math.min(
      width,
      Math.max(...lineWords.map((word) => word.left + word.width)) + 14,
    );
    const bottom = Math.min(
      height,
      Math.max(...lineWords.map((word) => word.top + word.height)) + 10,
    );

    return {
      x: left / width,
      y: top / height,
      width: (right - left) / width,
      height: (bottom - top) / height,
    };
  });
};
