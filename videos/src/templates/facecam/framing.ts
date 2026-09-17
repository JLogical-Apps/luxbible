import { Easing, interpolate } from "remotion";
import type { FacecamProps } from "./schema";

export const getFacecamFraming = (
  props: FacecamProps,
  frame: number,
  fps: number,
) => {
  const time = frame / fps;
  const framingIndex = props.facecamFraming.reduce(
    (last, item, index) => (Math.round(item.at * fps) <= frame ? index : last),
    -1,
  );
  const framing = props.facecamFraming[framingIndex];
  const previous = props.facecamFraming[framingIndex - 1];
  const fade = {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
    easing: Easing.inOut(Easing.cubic),
  } as const;
  const visibility = Math.min(
    1,
    props.overlays
      .map(
        ({ start, end }) =>
          interpolate(time, [start, start + props.fadeSeconds], [0, 1], fade) *
          interpolate(time, [end, end + props.fadeSeconds], [1, 0], fade),
      )
      .reduce((sum, opacity) => sum + opacity, 0),
  );
  const amount = props.facecamZoomOnlyWithSimulator ? visibility : 1;
  const transition = framing?.transitionSeconds
    ? interpolate(
        time,
        [framing.at, framing.at + framing.transitionSeconds],
        [0, 1],
        {
          extrapolateLeft: "clamp",
          extrapolateRight: "clamp",
          easing: Easing.inOut(
            framing.easing === "quartic" ? Easing.poly(4) : Easing.cubic,
          ),
        },
      )
    : 1;
  const getValue = (
    key: "zoom" | "centerX" | "offsetY" | "transformOriginY",
  ) =>
    interpolate(
      transition,
      [0, 1],
      [
        previous?.[key] ??
          framing?.[key] ??
          (key === "centerX"
            ? 0.5
            : key === "zoom"
              ? props.facecamZoom
              : key === "transformOriginY"
                ? 0.75
                : 0),
        framing?.[key] ??
          (key === "centerX"
            ? 0.5
            : key === "zoom"
              ? props.facecamZoom
              : key === "transformOriginY"
                ? 0.75
                : 0),
      ],
    );
  const targetZoom = getValue("zoom");
  const targetCenterX = getValue("centerX");
  const targetOffsetY = getValue("offsetY");
  const zoom = 1 + (targetZoom - 1) * amount;
  const transformOriginY = getValue("transformOriginY");
  const zoomOverflow = zoom === 1 ? 0 : (zoom - 1) / zoom;
  const minOffset = -(1 - transformOriginY) * zoomOverflow;
  const maxOffset = transformOriginY * zoomOverflow;
  const titleTop = interpolate(
    transition,
    [0, 1],
    [
      previous?.titleTop ?? framing?.titleTop ?? 0.25,
      framing?.titleTop ?? 0.25,
    ],
  );
  return {
    zoom,
    translateX: (0.5 - targetCenterX) * zoom * amount,
    translateY: Math.max(
      minOffset,
      Math.min(maxOffset, targetOffsetY * amount),
    ),
    transformOriginY,
    titleTop,
  };
};
