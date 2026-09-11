"use client";

import {
  interpolate,
  interpolateColors,
  spring,
  useCurrentFrame,
  useVideoConfig,
} from "remotion";

export interface MarkerHighlightProps {
  before?: string;
  highlight: string;
  after?: string;
  markerColor?: string;
  baseColor?: string;
  highlightedTextColor?: string;
  fontSize?: number;
  fontWeight?: number;
  speed?: number;
  delayFrames?: number;
  anticipationFrames?: number;
  className?: string;
}

export interface MarkerHighlightSpanProps {
  highlight: string;
  markerColor?: string;
  baseColor?: string;
  highlightedTextColor?: string;
  speed?: number;
  delayFrames?: number;
  anticipationFrames?: number;
}

export function MarkerHighlightSpan({
  highlight,
  markerColor = "#facc15",
  baseColor = "#171717",
  highlightedTextColor = "#171717",
  speed = 1,
  delayFrames = 15,
  anticipationFrames = 0,
}: MarkerHighlightSpanProps) {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const markerScale = spring({
    frame: (frame - delayFrames + anticipationFrames) * speed,
    fps,
    config: { damping: 14 },
  });
  const textColor = interpolateColors(
    interpolate(markerScale, [0.5, 0.8], [0, 1], {
      extrapolateLeft: "clamp",
      extrapolateRight: "clamp",
    }),
    [0, 1],
    [baseColor, highlightedTextColor],
  );

  return (
    <span style={{ position: "relative", display: "inline-block" }}>
      <span
        aria-hidden
        style={{
          position: "absolute",
          inset: "0 -0.1em",
          background: markerColor,
          transformOrigin: "left center",
          scale: `${markerScale} 1`,
          zIndex: 0,
        }}
      />
      <span style={{ position: "relative", zIndex: 1, color: textColor }}>
        {highlight}
      </span>
    </span>
  );
}

export function MarkerHighlight({
  before = "",
  highlight,
  after = "",
  markerColor = "#facc15",
  baseColor = "#171717",
  highlightedTextColor = "#171717",
  fontSize = 72,
  fontWeight = 600,
  speed = 1,
  delayFrames = 15,
  anticipationFrames = 0,
  className,
}: MarkerHighlightProps) {
  return (
    <div
      style={{
        position: "absolute",
        inset: 0,
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        background: "transparent",
      }}
    >
      <span
        className={className}
        style={{
          fontSize,
          fontWeight,
          color: baseColor,
          letterSpacing: "-0.03em",
          fontFamily: "inherit",
        }}
      >
        {before}
        <MarkerHighlightSpan
          highlight={highlight}
          markerColor={markerColor}
          baseColor={baseColor}
          highlightedTextColor={highlightedTextColor}
          speed={speed}
          delayFrames={delayFrames}
          anticipationFrames={anticipationFrames}
        />
        {after}
      </span>
    </div>
  );
}
