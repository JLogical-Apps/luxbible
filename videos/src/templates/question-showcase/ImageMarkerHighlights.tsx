import { interpolate, spring, useCurrentFrame, useVideoConfig } from "remotion";

type HighlightRect = {
  x: number;
  y: number;
  width: number;
  height: number;
};

export const ImageMarkerHighlights = ({
  rects,
  color = "rgba(255, 206, 45, 0.42)",
  startFrame,
  dimFrame,
  dimOpacity = 0.34,
  durationInFrames = 24,
  lineDelayInFrames = 10,
  dimDurationInFrames = 50,
}: {
  rects: HighlightRect[];
  color?: string;
  startFrame: number;
  dimFrame?: number;
  dimOpacity?: number;
  durationInFrames?: number;
  lineDelayInFrames?: number;
  dimDurationInFrames?: number;
}) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  return rects.map((rect, index) => {
    const progress = spring({
      frame: frame - startFrame - index * lineDelayInFrames,
      fps,
      durationInFrames,
      config: { damping: 18, mass: 0.6, stiffness: 120 },
    });
    const opacity =
      dimFrame === undefined
        ? 1
        : interpolate(
            frame,
            [dimFrame, dimFrame + dimDurationInFrames],
            [1, dimOpacity],
            {
              extrapolateLeft: "clamp",
              extrapolateRight: "clamp",
            },
          );

    return (
      <div
        key={`${rect.x}-${rect.y}`}
        style={{
          position: "absolute",
          left: `${rect.x * 100}%`,
          top: `${rect.y * 100}%`,
          width: `${rect.width * 100}%`,
          height: `${rect.height * 100}%`,
          borderRadius: 10,
          backgroundColor: color,
          boxShadow: "0 0 14px rgba(255, 206, 45, 0.14)",
          opacity,
          scale: `${progress} 1`,
          transformOrigin: "left center",
        }}
      />
    );
  });
};
