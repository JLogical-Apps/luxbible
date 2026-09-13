import { Audio, Video } from "@remotion/media";
import {
  AbsoluteFill,
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
  const time = frame / fps;
  const framing = getFacecamFraming(props, frame, fps);
  return (
    <AbsoluteFill style={{ backgroundColor: "#151515", overflow: "hidden" }}>
      {props.facecamSrc ? (
        <Video
          src={staticFile(props.facecamSrc)}
          objectFit="cover"
          muted={Boolean(props.narrationSrc)}
          style={{
            width: "100%",
            height: "100%",
            scale: framing.zoom,
            translate: `${framing.translateX * 100}% ${framing.translateY * 100}%`,
            transformOrigin: "center top",
          }}
        />
      ) : null}
      {props.narrationSrc ? (
        <Audio src={staticFile(props.narrationSrc)} volume={() => props.narrationVolume} />
      ) : null}
      {props.musicSrc ? (
        <Audio src={staticFile(props.musicSrc)} volume={() => props.musicVolume} />
      ) : null}
      {time < props.titleSeconds ? (
        <div
          style={{
            position: "absolute",
            top: "25%",
            left: 82,
            right: 82,
            translate: "0 -50%",
            borderRadius: 18,
            padding: "18px 26px 22px",
            backgroundColor: "#f7f7f5",
            color: "#090909",
            fontFamily,
            fontSize: 60,
            fontWeight: 900,
            textAlign: "center",
            lineHeight: 1.05,
          }}
        >
          {props.title}
        </div>
      ) : null}
      {props.overlays.map((overlay, index) =>
        time >= overlay.start && time < overlay.end + props.fadeSeconds ? (
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
