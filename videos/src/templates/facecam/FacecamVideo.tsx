import { Audio, Video } from "@remotion/media";
import {
  AbsoluteFill,
  Sequence,
  staticFile,
  useCurrentFrame,
  useVideoConfig,
} from "remotion";
import { fontFamily } from "../../design/lux/fonts";
import { getFacecamFraming } from "./framing";
import { WordCaptions } from "./WordCaptions";
import { SimulatorOverlay } from "./SimulatorOverlay";
import type { FacecamProps } from "./schema";

export const FacecamVideo = (props: FacecamProps) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const framing = getFacecamFraming(props, frame, fps);
  const titleCues = props.titleCues.length
    ? props.titleCues
    : [
        {
          text: props.title,
          start: 0,
          end: props.titleSeconds,
          top: framing.titleTop,
          fontSize: 60,
        },
      ];
  return (
    <AbsoluteFill style={{ backgroundColor: "#151515", overflow: "hidden" }}>
      {props.facecamClips.length ? (
        props.facecamClips.map((clip) => (
          <Sequence
            key={clip.id}
            name={`Clip ${clip.id}`}
            from={Math.round(clip.start * fps)}
            durationInFrames={Math.round(clip.duration * fps)}
          >
            <Video
              src={staticFile(clip.src)}
              objectFit="cover"
              muted={Boolean(props.narrationSrc)}
              style={{
                width: "100%",
                height: "100%",
                scale: framing.zoom,
                translate: `${framing.translateX * 100}% ${framing.translateY * 100}%`,
                transformOrigin: `center ${framing.transformOriginY * 100}%`,
              }}
            />
          </Sequence>
        ))
      ) : props.facecamSrc ? (
        <Video
          src={staticFile(props.facecamSrc)}
          objectFit="cover"
          muted={Boolean(props.narrationSrc)}
          style={{
            width: "100%",
            height: "100%",
            scale: framing.zoom,
            translate: `${framing.translateX * 100}% ${framing.translateY * 100}%`,
            transformOrigin: `center ${framing.transformOriginY * 100}%`,
          }}
        />
      ) : null}
      {props.narrationSrc ? (
        <Audio
          src={staticFile(props.narrationSrc)}
          volume={() => props.narrationVolume}
        />
      ) : null}
      {props.musicSrc ? (
        <Audio
          src={staticFile(props.musicSrc)}
          volume={() => props.musicVolume}
        />
      ) : null}
      {titleCues.map((title) =>
        frame >= Math.round(title.start * fps) &&
        frame < Math.round(title.end * fps) ? (
          <div
            key={`${title.start}-${title.text}`}
            style={{
              position: "absolute",
              top: `${(title.top ?? framing.titleTop) * 100}%`,
              left: 82,
              right: 82,
              translate: "0 -50%",
              borderRadius: 18,
              padding: "18px 26px 22px",
              backgroundColor: "#f7f7f5",
              color: "#090909",
              fontFamily,
              fontSize: title.fontSize,
              fontWeight: 900,
              textAlign: "center",
              whiteSpace: "pre-line",
              lineHeight: 1.1,
            }}
          >
            {title.text}
          </div>
        ) : null,
      )}
      {props.overlays.map((overlay, index) =>
        frame >= Math.round(overlay.start * fps) &&
        frame <
          Math.round(
            (overlay.end + (overlay.fadeEdges ? props.fadeSeconds : 0)) * fps,
          ) ? (
          <SimulatorOverlay
            key={overlay.id}
            overlay={overlay}
            top={props.overlayTop}
            bottom={props.overlayBottom}
            fadeSeconds={props.fadeSeconds}
            hasPrevious={props.overlays[index - 1]?.end === overlay.start}
            hasNext={props.overlays[index + 1]?.start === overlay.end}
          />
        ) : null,
      )}
      <WordCaptions
        captions={props.captions}
        fontSize={props.captionFontSize}
        strokeWidth={props.captionStrokeWidth}
        maxCharacters={props.captionMaxCharacters}
        top={props.captionTop}
      />
    </AbsoluteFill>
  );
};
