import { Audio, Video } from "@remotion/media";
import {
  AbsoluteFill,
  Easing,
  Freeze,
  Img,
  interpolate,
  Sequence,
  staticFile,
  useCurrentFrame,
  useVideoConfig,
} from "remotion";
import { PerCharacterRise } from "../../core/remocn/per-character-rise";
import { ShaderMeshGradient } from "../../core/remocn/shader-mesh-gradient";
import { fontFamily } from "../../design/lux/fonts";
import {
  ImageMarkerHighlights,
  getHighlightEndFrame,
} from "./ImageMarkerHighlights";
import type { QuestionShowcaseProps } from "./schema";

const videoExtensions = new Set(["mp4", "mov", "m4v", "webm"]);
const verseHighlightStartFrame = 108;
const finalStageStartFrame = 190;
const finalStageEndFrame = 240;
const studyHighlightStartFrame = 257;
const callToActionTextStartFrame = 407;

const getExtension = (src: string) =>
  src.split(/[?#]/)[0]?.split(".").slice(-1)[0]?.toLowerCase() ?? "";

const getAssetSrc = (src: string) =>
  /^https?:\/\//.test(src) ? src : staticFile(src);

const getQuestionLines = (question: string) => {
  const words = question.trim().split(/\s+/);
  const lineCount = question.length > 72 ? 3 : question.length > 34 ? 2 : 1;
  const targetLength = Math.ceil(question.length / lineCount);

  return words.reduce<string[]>((lines, word) => {
    const currentLine = lines[lines.length - 1];
    const shouldStartLine =
      currentLine &&
      lines.length < lineCount &&
      `${currentLine} ${word}`.length > targetLength;

    return shouldStartLine
      ? [...lines, word]
      : [...lines.slice(0, -1), [currentLine, word].filter(Boolean).join(" ")];
  }, []);
};

const VisualMedia: React.FC<{
  src: string;
  style: React.CSSProperties;
  volume?: number;
  loop?: boolean;
  from?: number;
  objectFit: "cover" | "contain" | "fill";
}> = ({ src, style, volume = 0, loop = false, from, objectFit }) =>
  videoExtensions.has(getExtension(src)) ? (
    <Video
      src={getAssetSrc(src)}
      style={style}
      objectFit={objectFit}
      volume={volume}
      loop={loop}
      from={from}
    />
  ) : (
    <Img src={getAssetSrc(src)} style={{ ...style, objectFit }} from={from} />
  );

const QuestionContent: React.FC<{
  question: string;
  callToAction: string;
  ctaTextFrame?: number;
}> = ({
  question,
  callToAction,
  ctaTextFrame = callToActionTextStartFrame,
}) => {
  const frame = useCurrentFrame();
  const lines = getQuestionLines(question);
  const longestLine = Math.max(...lines.map((line) => line.length));
  const fontSize = longestLine > 44 ? 43 : longestLine > 34 ? 48 : 54;

  return (
    <div
      style={{
        position: "absolute",
        top: 240,
        left: 90,
        right: 90,
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        translate: interpolate(frame, [42, 78], ["0px 600px", "0px 0px"], {
          extrapolateLeft: "clamp",
          extrapolateRight: "clamp",
          easing: Easing.bezier(0.16, 1, 0.3, 1),
        }),
        scale: interpolate(frame, [42, 78], [1.08, 1], {
          extrapolateLeft: "clamp",
          extrapolateRight: "clamp",
          easing: Easing.bezier(0.16, 1, 0.3, 1),
          output: "perceptual-scale",
        }),
        zIndex: 2,
      }}
    >
      <div
        style={{
          maxWidth: 900,
          padding: "16px 26px 18px",
          borderRadius: 18,
          backgroundColor: "#f7f7f5",
          color: "#090909",
          fontFamily,
          fontSize,
          fontWeight: 800,
          lineHeight: 1,
          textAlign: "center",
          whiteSpace: "nowrap",
        }}
      >
        {lines.map((line, index) => (
          <div
            key={`${line}-${index}`}
            style={{ marginTop: index === 0 ? 0 : 4 }}
          >
            {line}
          </div>
        ))}
      </div>
      <div
        style={{
          marginTop: -12,
          padding: "22px 28px 24px",
          position: "relative",
          borderRadius: 14,
          backgroundColor: "#050505",
          color: "#f8f8f5",
          fontFamily,
          fontSize: 46,
          fontWeight: 800,
          lineHeight: 1,
          whiteSpace: "nowrap",
          opacity: interpolate(
            frame,
            [ctaTextFrame - 12, ctaTextFrame],
            [0, 1],
            {
              extrapolateLeft: "clamp",
              extrapolateRight: "clamp",
              easing: Easing.out(Easing.cubic),
            },
          ),
          translate: interpolate(
            frame,
            [ctaTextFrame - 12, ctaTextFrame + 8],
            ["0px 18px", "0px 0px"],
            {
              extrapolateLeft: "clamp",
              extrapolateRight: "clamp",
              easing: Easing.bezier(0.16, 1, 0.3, 1),
            },
          ),
          boxShadow: "0 16px 34px rgba(0, 0, 0, 0.28)",
        }}
      >
        <span style={{ visibility: "hidden", letterSpacing: "-0.05em" }}>
          {callToAction}
        </span>
        <Sequence from={ctaTextFrame} layout="none">
          <PerCharacterRise
            text={callToAction}
            distance={18}
            fontSize={46}
            color="#f8f8f5"
            fontWeight={800}
            speed={1.15}
          />
        </Sequence>
      </div>
    </div>
  );
};

const Background: React.FC<
  Pick<
    QuestionShowcaseProps,
    | "backgroundSrc"
    | "backgroundDarkness"
    | "backgroundSaturation"
    | "backgroundBrightness"
    | "shaderColor1"
    | "shaderColor2"
    | "shaderColor3"
    | "shaderColor4"
  >
> = ({
  backgroundSrc,
  backgroundDarkness,
  backgroundSaturation,
  backgroundBrightness,
  shaderColor1,
  shaderColor2,
  shaderColor3,
  shaderColor4,
}) => {
  const frame = useCurrentFrame();
  const { durationInFrames, fps } = useVideoConfig();

  return (
    <AbsoluteFill style={{ backgroundColor: "#080b0a" }}>
      {backgroundSrc ? (
        <VisualMedia
          src={backgroundSrc}
          loop
          objectFit="cover"
          style={{
            width: "100%",
            height: "100%",
            scale: interpolate(frame, [0, durationInFrames], [1.04, 1.1], {
              extrapolateLeft: "clamp",
              extrapolateRight: "clamp",
            }),
            filter: `saturate(${backgroundSaturation}) brightness(${backgroundBrightness}) contrast(1.08)`,
          }}
        />
      ) : (
        <ShaderMeshGradient
          colors={[shaderColor1, shaderColor2, shaderColor3, shaderColor4]}
          distortion={0.46}
          swirl={0.18}
          timelineFrame={(frame / fps) * 380}
        />
      )}
      <AbsoluteFill
        style={{
          background: `linear-gradient(180deg, rgba(3, 5, 4, ${backgroundDarkness * 0.72}), rgba(3, 5, 4, ${backgroundDarkness}))`,
        }}
      />
    </AbsoluteFill>
  );
};

export const QuestionShowcase: React.FC<QuestionShowcaseProps> = ({
  question,
  callToAction,
  mediaSrc,
  mediaClipPath,
  mediaMaskSrc,
  recordingSrc = "",
  recordingDurationInFrames = 0,
  backgroundSrc,
  mediaScale,
  mediaVolume,
  musicSrc = "",
  musicVolume = 1,
  backgroundDarkness,
  backgroundSaturation,
  backgroundBrightness,
  shaderColor1,
  shaderColor2,
  shaderColor3,
  shaderColor4,
  verseHighlightRects = [],
  studyHighlightRects = [],
  highlightCues = [],
}) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const recordingEndFrame = finalStageEndFrame + recordingDurationInFrames;
  const finalStudyStartFrame =
    (recordingSrc ? recordingEndFrame : studyHighlightStartFrame) + fps;
  const finalHighlightEndFrame = Math.max(
    getHighlightEndFrame(
      studyHighlightRects.length ? finalStudyStartFrame : recordingEndFrame,
      studyHighlightRects.length,
    ),
    ...highlightCues.map((cue) =>
      getHighlightEndFrame(cue.startFrame, cue.rects.length),
    ),
  );
  const verseBottom =
    verseHighlightRects.length === 0
      ? 0.24
      : Math.max(
          ...verseHighlightRects.map((rect) =>
            Math.min(rect.y + rect.height, 1),
          ),
        );

  return (
    <AbsoluteFill style={{ overflow: "hidden", backgroundColor: "#080b0a" }}>
      {musicSrc ? (
        <Audio src={getAssetSrc(musicSrc)} volume={musicVolume} />
      ) : null}
      <Background
        backgroundSrc={backgroundSrc}
        backgroundDarkness={backgroundDarkness}
        backgroundSaturation={backgroundSaturation}
        backgroundBrightness={backgroundBrightness}
        shaderColor1={shaderColor1}
        shaderColor2={shaderColor2}
        shaderColor3={shaderColor3}
        shaderColor4={shaderColor4}
      />
      <div
        style={{
          position: "absolute",
          top: 485,
          left: 200,
          width: 680,
          height: 1370,
          opacity: interpolate(frame, [58, 78], [0, 1], {
            extrapolateLeft: "clamp",
            extrapolateRight: "clamp",
          }),
          translate: interpolate(
            frame,
            [58, 102, finalStageStartFrame, finalStageEndFrame],
            ["0px 1435px", "0px 40px", "0px 40px", "0px 0px"],
            {
              extrapolateLeft: "clamp",
              extrapolateRight: "clamp",
              easing: Easing.bezier(0.16, 1, 0.3, 1),
            },
          ),
          scale: interpolate(
            frame,
            [58, finalStageStartFrame, finalStageEndFrame],
            [mediaScale * (972 / 680), mediaScale * (972 / 680), mediaScale],
            {
              extrapolateLeft: "clamp",
              extrapolateRight: "clamp",
              easing: Easing.bezier(0.16, 1, 0.3, 1),
              output: "perceptual-scale",
            },
          ),
          transformOrigin: "top center",
          filter: "drop-shadow(0 28px 55px rgba(0, 0, 0, 0.52))",
          borderRadius: 72,
          clipPath: mediaClipPath,
          maskImage: mediaMaskSrc
            ? `url(${getAssetSrc(mediaMaskSrc)})`
            : undefined,
          maskSize: "100% 100%",
          maskMode: "luminance",
          overflow: "hidden",
        }}
      >
        {recordingSrc ? (
          <Freeze
            frame={Math.max(
              0,
              Math.min(
                frame - finalStageEndFrame,
                recordingDurationInFrames - 1,
              ),
            )}
          >
            <Video
              src={getAssetSrc(recordingSrc)}
              muted
              style={{
                position: "absolute",
                inset: 0,
                width: "100%",
                height: "100%",
              }}
              objectFit="fill"
            />
          </Freeze>
        ) : (
          <VisualMedia
            src={mediaSrc}
            volume={mediaVolume}
            from={58}
            objectFit="fill"
            style={{ width: "100%", height: "100%", borderRadius: 72 }}
          />
        )}
        <div
          style={{
            position: "absolute",
            top: `${verseBottom * 100}%`,
            right: 0,
            bottom: 0,
            left: 0,
            background:
              "linear-gradient(180deg, rgba(4, 7, 12, 0) 0%, rgba(4, 7, 12, 0.68) 36%, rgba(4, 7, 12, 0.96) 100%)",
            opacity: interpolate(
              frame,
              [finalStageStartFrame, finalStageEndFrame - 10],
              [1, 0],
              {
                extrapolateLeft: "clamp",
                extrapolateRight: "clamp",
                easing: Easing.out(Easing.cubic),
              },
            ),
          }}
        />
        <ImageMarkerHighlights
          rects={verseHighlightRects}
          startFrame={verseHighlightStartFrame}
          dimFrame={recordingSrc ? finalStageEndFrame : finalStageStartFrame}
          dimOpacity={recordingSrc ? 0 : 0.34}
          dimDurationInFrames={recordingSrc ? 10 : 50}
        />
        <ImageMarkerHighlights
          rects={studyHighlightRects}
          startFrame={finalStudyStartFrame}
        />
        {highlightCues.map((cue, index) => (
          <ImageMarkerHighlights
            key={index}
            rects={cue.rects}
            startFrame={cue.startFrame}
            dimFrame={cue.endFrame}
            dimOpacity={0}
            dimDurationInFrames={10}
          />
        ))}
      </div>
      <QuestionContent
        question={question}
        callToAction={callToAction}
        ctaTextFrame={
          recordingSrc
            ? finalHighlightEndFrame + fps
            : callToActionTextStartFrame + fps
        }
      />
    </AbsoluteFill>
  );
};
