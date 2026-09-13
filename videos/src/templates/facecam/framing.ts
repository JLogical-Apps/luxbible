import { Easing, interpolate } from "remotion";
import type { FacecamProps } from "./schema";

export const getFacecamFraming = (
  props: FacecamProps,
  frame: number,
  fps: number,
) => {
  const time = frame / fps;
  const framing = [...props.facecamFraming].reverse().find(
    (item) => Math.round(item.at * fps) <= frame,
  );
  const fade = {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
    easing: Easing.inOut(Easing.cubic),
  } as const;
  const visibility = Math.min(
    1,
    props.overlays
      .map(({ start, end }) =>
        interpolate(time, [start, start + props.fadeSeconds], [0, 1], fade) *
        interpolate(time, [end, end + props.fadeSeconds], [1, 0], fade),
      )
      .reduce((sum, opacity) => sum + opacity, 0),
  );
  const amount = props.facecamZoomOnlyWithSimulator ? visibility : 1;
  const zoom = 1 + ((framing?.zoom ?? props.facecamZoom) - 1) * amount;
  return {
    zoom,
    translateX: (0.5 - (framing?.centerX ?? 0.5)) * zoom * amount,
    translateY: (framing?.offsetY ?? 0) * amount,
  };
};
