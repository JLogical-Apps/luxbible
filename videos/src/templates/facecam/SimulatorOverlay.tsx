import { Video } from "@remotion/media";
import { pixelate as pixelateEffect } from "@remotion/effects/pixelate";
import { radialProgressivePixelate } from "@remotion/effects/radial-progressive-pixelate";
import { makeCallout } from "@remotion/shapes";
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
import { fontFamily } from "../../design/lux/fonts";
import type { Overlay } from "./schema";

const ImageAnnotations = ({ overlay }: { overlay: Overlay }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  return (
    <>
      {overlay.circles.map((circle, index) => (
        <svg
          key={`${circle.rect.x}-${circle.rect.y}`}
          viewBox="0 0 100 100"
          preserveAspectRatio="none"
          style={{
            position: "absolute",
            left: `${(circle.rect.x - circle.paddingX) * 100}%`,
            top: `${(circle.rect.y - circle.paddingTop) * 100}%`,
            width: `${(circle.rect.width + circle.paddingX * 2) * 100}%`,
            height: `${(circle.rect.height + circle.paddingTop + circle.paddingBottom) * 100}%`,
            overflow: "visible",
          }}
        >
          <ellipse
            cx="50"
            cy="50"
            rx="48"
            ry="43"
            fill="none"
            stroke={circle.color}
            strokeWidth={circle.strokeWidth}
            strokeLinecap="round"
            pathLength="1"
            strokeDasharray="1"
            strokeDashoffset={
              1 -
              interpolate(
                frame,
                [circle.start * fps, (circle.start + circle.duration) * fps],
                [0, 1],
                {
                  extrapolateLeft: "clamp",
                  extrapolateRight: "clamp",
                  easing: Easing.inOut(Easing.cubic),
                },
              )
            }
          />
          <ellipse
            cx="50"
            cy="50"
            rx="46"
            ry="47"
            fill="none"
            stroke={circle.color}
            strokeWidth={circle.strokeWidth * 0.45}
            strokeLinecap="round"
            opacity="0.72"
            pathLength="1"
            strokeDasharray="1"
            strokeDashoffset={
              1 -
              interpolate(
                frame,
                [
                  (circle.start + 0.08) * fps,
                  (circle.start + circle.duration) * fps,
                ],
                [0, 1],
                {
                  extrapolateLeft: "clamp",
                  extrapolateRight: "clamp",
                  easing: Easing.inOut(Easing.cubic),
                },
              )
            }
            transform={`rotate(${index % 2 === 0 ? 2 : -2} 50 50)`}
          />
        </svg>
      ))}
      {overlay.callouts.map((callout) => {
        const shape = makeCallout({
          width: 600,
          height: 260,
          pointerLength: 70,
          pointerBaseWidth: 110,
          pointerPosition: callout.pointerPosition,
          pointerDirection: "down",
          cornerRadius: 42,
        });
        return (
          <div
            key={`${callout.text}-${callout.start}`}
            style={{
              position: "absolute",
              left: `${callout.x * 100}%`,
              top: `${callout.y * 100}%`,
              width: `${callout.width * 100}%`,
              height: `${callout.height * 100}%`,
              opacity: interpolate(
                frame,
                [callout.start * fps, (callout.start + 0.3) * fps],
                [0, 1],
                {
                  extrapolateLeft: "clamp",
                  extrapolateRight: "clamp",
                  easing: Easing.out(Easing.cubic),
                },
              ),
              scale: interpolate(
                frame,
                [callout.start * fps, (callout.start + 0.3) * fps],
                [0.88, 1],
                {
                  extrapolateLeft: "clamp",
                  extrapolateRight: "clamp",
                  easing: Easing.out(Easing.back(1.4)),
                },
              ),
              rotate: interpolate(
                frame,
                [
                  callout.start * fps,
                  (callout.start + 0.16) * fps,
                  (callout.start + 0.3) * fps,
                ],
                ["-4deg", "2deg", "0deg"],
                {
                  extrapolateLeft: "clamp",
                  extrapolateRight: "clamp",
                  easing: Easing.inOut(Easing.quad),
                },
              ),
              transformOrigin: `${callout.pointerPosition * 100}% 100%`,
            }}
          >
            <svg
              viewBox={`0 0 ${shape.width} ${shape.height}`}
              style={{ position: "absolute", width: "100%", height: "100%" }}
            >
              <path d={shape.path} fill={callout.backgroundColor} />
            </svg>
            <div
              style={{
                position: "absolute",
                left: "10%",
                right: "10%",
                top: 0,
                height: `${(260 / shape.height) * 100}%`,
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                color: callout.color,
                fontFamily,
                fontSize: 30,
                fontWeight: 900,
                lineHeight: 1.05,
                textAlign: "center",
                whiteSpace: "nowrap",
              }}
            >
              {callout.text}
            </div>
          </div>
        );
      })}
    </>
  );
};

const getLayout = ({
  overlay,
  time,
  compositionWidth,
  compositionHeight,
  top,
  bottom,
}: {
  overlay: Overlay;
  time: number;
  compositionWidth: number;
  compositionHeight: number;
  top: number;
  bottom: number;
}) => {
  const defaultHeight = (bottom - top) * compositionHeight;
  if (!overlay.layout)
    return {
      width: defaultHeight * overlay.aspectRatio,
      height: defaultHeight,
      centerY: ((top + bottom) / 2) * compositionHeight,
      sourceScaleX: overlay.sourceScaleX,
      sourceScaleY: overlay.sourceScaleY,
      sourceCenterX: 0.5,
      sourceCenterY: 0.5,
    };
  const base = overlay.layout;
  const index = base.keyframes.reduce(
    (last, keyframe, keyframeIndex) =>
      keyframe.at <= time ? keyframeIndex : last,
    -1,
  );
  const keyframe = base.keyframes[index];
  const previous = base.keyframes[index - 1] ?? base;
  const progress = keyframe
    ? interpolate(
        time,
        [keyframe.at, keyframe.at + keyframe.transitionSeconds],
        [0, 1],
        {
          extrapolateLeft: "clamp",
          extrapolateRight: "clamp",
          easing: Easing.inOut(Easing.cubic),
        },
      )
    : 0;
  const getValue = (
    key:
      | "width"
      | "height"
      | "centerY"
      | "sourceScale"
      | "sourceCenterX"
      | "sourceCenterY",
  ) =>
    interpolate(
      progress,
      [0, 1],
      [previous[key], keyframe?.[key] ?? previous[key]],
    );
  return {
    width: getValue("width") * compositionWidth,
    height: getValue("height") * compositionHeight,
    centerY: getValue("centerY") * compositionHeight,
    sourceScaleX: getValue("sourceScale"),
    sourceScaleY: getValue("sourceScale"),
    sourceCenterX: getValue("sourceCenterX"),
    sourceCenterY: getValue("sourceCenterY"),
  };
};

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
  const {
    fps,
    width: compositionWidth,
    height: compositionHeight,
  } = useVideoConfig();
  const time = frame / fps;
  const { start, end, segments, focus } = overlay;
  const fade = {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
    easing: Easing.inOut(Easing.cubic),
  } as const;
  const entrance = overlay.fadeEdges
    ? interpolate(time, [start, start + fadeSeconds], [0, 1], fade)
    : 1;
  const exit = overlay.fadeEdges
    ? interpolate(time, [end, end + fadeSeconds], [0, 1], fade)
    : 0;
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
  const layout = getLayout({
    overlay,
    time,
    compositionWidth,
    compositionHeight,
    top,
    bottom,
  });
  const mediaWidth = layout.width * layout.sourceScaleX;
  const mediaHeight =
    (layout.width / overlay.aspectRatio) * layout.sourceScaleY;
  const mediaLeft = -(mediaWidth - layout.width) * layout.sourceCenterX;
  const mediaTop = -(mediaHeight - layout.height) * layout.sourceCenterY;
  const pixelate = overlay.pixelate;
  const pixelLeft = (pixelate?.x ?? 0) * mediaWidth;
  const pixelTop = (pixelate?.y ?? 0) * mediaHeight;
  const pixelWidth = (pixelate?.width ?? 0) * mediaWidth;
  const pixelHeight = (pixelate?.height ?? 0) * mediaHeight;
  const pixelDrift = pixelate?.drift ?? 0;
  const pixelCenterX =
    (pixelate?.x ?? 0) +
    (pixelate?.width ?? 0) / 2 +
    Math.sin(frame / 4) * pixelDrift +
    Math.sin(frame / 11) * pixelDrift * 0.3;
  const pixelCenterY =
    (pixelate?.y ?? 0) +
    (pixelate?.height ?? 0) / 2 +
    Math.cos(frame / 5) * pixelDrift * 0.8 +
    Math.sin(frame / 13) * pixelDrift * 0.25;
  const pixelPulse = (Math.sin(frame / 3) + 1) / 2;
  const entranceOpacity = hasPrevious && overlay.seamlessEdges ? 1 : entrance;
  const exitOpacity = hasNext && overlay.seamlessEdges ? 1 : 1 - exit;
  return (
    <div
      style={{
        position: "absolute",
        top: layout.centerY - layout.height / 2,
        left: "50%",
        width: layout.width,
        height: layout.height,
        translate: `-50% ${(hasPrevious ? 0 : (1 - entrance) * 24) + (hasNext ? 0 : exit * 24)}px`,
        opacity: entranceOpacity * exitOpacity,
        boxShadow:
          isImage || overlay.layout
            ? "0 22px 56px rgba(0, 0, 0, 0.28)"
            : "none",
        borderRadius: layout.height * 0.1,
        overflow: "hidden",
      }}
    >
      <div
        style={{
          position: "absolute",
          left: mediaLeft,
          top: mediaTop,
          width: mediaWidth,
          height: mediaHeight,
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
            {pixelate ? (
              <div
                style={{
                  position: "absolute",
                  left: pixelLeft,
                  top: pixelTop,
                  width: pixelWidth,
                  height: pixelHeight,
                  overflow: "hidden",
                }}
              >
                <Video
                  src={staticFile(overlay.src)}
                  muted
                  effects={[
                    pixelateEffect({
                      blockSize: pixelate.endBlockSize,
                    }),
                    radialProgressivePixelate({
                      center: [pixelCenterX, pixelCenterY],
                      width: pixelate.width * (1.9 + pixelPulse * 0.35),
                      height: pixelate.height * (1.9 + pixelPulse * 0.35),
                      rotation: Math.sin(frame / 6) * 28,
                      startBlockSize:
                        pixelate.startBlockSize * (0.88 + pixelPulse * 0.12),
                      endBlockSize:
                        pixelate.endBlockSize * (0.88 + pixelPulse * 0.12),
                    }),
                  ]}
                  style={{
                    position: "absolute",
                    left: -pixelLeft,
                    top: -pixelTop,
                    width: mediaWidth,
                    height: mediaHeight,
                  }}
                />
              </div>
            ) : null}
          </Freeze>
        )}
        <ImageAnnotations overlay={overlay} />
      </div>
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
