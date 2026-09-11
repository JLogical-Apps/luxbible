import { interpolateColors, useCurrentFrame } from "remotion";

export const TimedAccent: React.FC<{
  children: string;
  baseColor: string;
  color: string;
  delayFrames: number;
  durationFrames: number;
  anticipationFrames?: number;
  wordDelayFrames?: readonly number[];
}> = ({
  children,
  baseColor,
  color,
  delayFrames,
  durationFrames,
  anticipationFrames = 5,
  wordDelayFrames,
}) => {
  const frame = useCurrentFrame();
  let wordIndex = 0;

  if (wordDelayFrames) {
    return children.split(/(\s+)/).map((part, index) => {
      if (/^\s+$/.test(part)) return part;

      const wordDelay =
        (wordDelayFrames[wordIndex] ?? delayFrames) - anticipationFrames;
      wordIndex += 1;

      return (
        <span
          key={`${part}-${index}`}
          style={{
            color: interpolateColors(
              frame,
              [wordDelay, wordDelay + durationFrames],
              [baseColor, color],
            ),
          }}
        >
          {part}
        </span>
      );
    });
  }

  return (
    <span
      style={{
        color: interpolateColors(
          frame,
          [
            delayFrames - anticipationFrames,
            delayFrames - anticipationFrames + durationFrames,
          ],
          [baseColor, color],
        ),
      }}
    >
      {children}
    </span>
  );
};
