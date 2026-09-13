import { Video } from "@remotion/media";
import {
  Easing,
  Img,
  Freeze,
  interpolate,
  staticFile,
  useCurrentFrame,
  useVideoConfig,
} from "remotion";
import { ImageMarkerHighlights } from "../question-showcase/ImageMarkerHighlights";
import type { Overlay } from "./schema";

export const SimulatorOverlay = ({
  overlay,
  top,
  bottom,
  fadeSeconds,
  hasPrevious,
  hasNext,
}: {
  overlay: Overlay;
  top: number;
  bottom: number;
  fadeSeconds: number;
  hasPrevious: boolean;
  hasNext: boolean;
}) => {
  const frame = useCurrentFrame();
  const { fps, height } = useVideoConfig();
  const time = frame / fps;
  const { start, end, segments, focus } = overlay;
  const fade = {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
    easing: Easing.inOut(Easing.cubic),
  } as const;
  const entrance = interpolate(
    time,
    [start, start + fadeSeconds],
    [0, 1],
    fade,
  );
  const exit = interpolate(time, [end, end + fadeSeconds], [0, 1], fade);
  const segment =
    [...segments].reverse().find((item) => item.at <= time) ?? segments[0];
  const playEnd = segment.at + segment.playSeconds;
  const sourceFrame = Math.round(
    (segment.sourceTime +
      Math.max(0, Math.min(time, playEnd) - segment.at) *
        segment.playbackRate) *
      fps,
  );
  const isImage = /\.(png|jpe?g|webp)$/i.test(overlay.src);
  const size = (bottom - top) * height;
  return (
    <div
      style={{
        position: "absolute",
        top: `${top * 100}%`,
        left: "50%",
        width: size * overlay.aspectRatio,
        height: size,
        translate: `-50% ${(hasPrevious ? 0 : (1 - entrance) * 24) + (hasNext ? 0 : exit * 24)}px`,
        opacity: entrance * (1 - exit),
        borderRadius: size * 0.1,
        overflow: "hidden",
      }}
    >
      {isImage ? (
        <Img
          src={staticFile(overlay.src)}
          style={{ width: "100%", height: "100%" }}
        />
      ) : (
        <Freeze frame={sourceFrame}>
          <Video
            src={staticFile(overlay.src)}
            muted
            style={{ width: "100%", height: "100%" }}
          />
        </Freeze>
      )}
      {focus ? (
        <div
          style={{
            position: "absolute",
            top: 0,
            left: 0,
            right: 0,
            height: `${focus.bottom * 100}%`,
            background:
              "linear-gradient(180deg, rgba(0,0,0,0.55) 0%, rgba(0,0,0,0.4) 72%, rgba(0,0,0,0) 100%)",
            opacity: interpolate(
              time,
              [focus.fadeAt, focus.fadeAt + focus.fadeSeconds],
              [1, 0],
              fade,
            ),
          }}
        />
      ) : null}
      {overlay.highlights.map((highlight, index) =>
        highlight.end !== undefined && time >= highlight.end ? null : (
          <ImageMarkerHighlights
            key={index}
            rects={highlight.rects}
            color={highlight.color}
            startFrame={Math.round(highlight.start * fps)}
            durationInFrames={Math.round(highlight.duration * fps)}
            lineDelayInFrames={Math.round(highlight.lineDelay * fps)}
            dimFrame={
              highlight.fadeAt === undefined
                ? undefined
                : Math.round(highlight.fadeAt * fps)
            }
            dimOpacity={0}
            dimDurationInFrames={Math.round(highlight.fadeSeconds * fps)}
          />
        ),
      )}
    </div>
  );
};
