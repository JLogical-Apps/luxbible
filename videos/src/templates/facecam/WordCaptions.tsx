import { useCurrentFrame, useVideoConfig } from "remotion";
import { fontFamily } from "../../design/lux/fonts";
import type { Caption } from "./schema";

export const getCaptionPages = (captions: Caption[], maxCharacters: number) =>
  captions.reduce<Caption[][]>((pages, caption) => {
    const current = pages[pages.length - 1];
    const last = current?.[current.length - 1];
    const fits =
      current &&
      last &&
      current.length < 4 &&
      !/[.!?]$/.test(last.text) &&
      caption.startMs - last.endMs < 600 &&
      [...current, caption].map((word) => word.text.trim()).join(" ").length <=
        maxCharacters;
    return fits
      ? [...pages.slice(0, -1), [...current, caption]]
      : [...pages, [caption]];
  }, []);

export const WordCaptions = ({
  captions,
  fontSize,
  strokeWidth,
  maxCharacters,
  top,
}: {
  captions: Caption[];
  fontSize: number;
  strokeWidth: number;
  maxCharacters: number;
  top: number;
}) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const time = (frame / fps) * 1000;
  const pages = getCaptionPages(captions, maxCharacters);
  const page = pages.find(
    (words, index) =>
      time >= words[0].startMs &&
      time <
        Math.min(
          pages[index + 1]?.[0].startMs ?? Infinity,
          words[words.length - 1].endMs + 400,
        ),
  );
  return page ? (
    <div
      style={{
        position: "absolute",
        top: `${top * 100}%`,
        left: 70,
        right: 70,
        translate: "0 -50%",
        textAlign: "center",
        fontFamily,
        fontSize,
        strokeWidth,
        fontWeight: 900,
        lineHeight: 1.2,
        whiteSpace: "nowrap",
      }}
    >
      {page.map((word, index) => {
        const isActive =
          time >= word.startMs &&
          time < (page[index + 1]?.startMs ?? word.endMs);
        return (
          <span
            key={word.startMs}
            style={{
              color: isActive ? "#101010" : "white",
              WebkitTextStroke: `${strokeWidth}px ${isActive ? "white" : "#101010"}`,
              paintOrder: "stroke fill",
            }}
          >
            {index ? " " : ""}
            {word.text.trim().toUpperCase()}
          </span>
        );
      })}
    </div>
  ) : null;
};
