import { Easing, Interactive, interpolate, useCurrentFrame } from "remotion";
import type { ReactNode } from "react";
import { useMotionSpeed } from "./MotionProvider";

export const Rise: React.FC<{
  children: ReactNode;
  delay?: number;
  distance?: number;
  durationFrames?: number;
  name: string;
  style?: React.CSSProperties;
}> = ({
  children,
  delay = 0,
  distance = 60,
  durationFrames = 30,
  name,
  style,
}) => {
  const frame = useCurrentFrame();
  const speed = useMotionSpeed();
  const revealFrames = durationFrames / speed;

  return (
    <Interactive.Div
      name={name}
      style={{
        ...style,
        opacity: interpolate(frame, [delay, delay + revealFrames], [0, 1], {
          extrapolateLeft: "clamp",
          extrapolateRight: "clamp",
          easing: Easing.bezier(0.16, 1, 0.3, 1),
        }),
        translate: interpolate(
          frame,
          [delay, delay + revealFrames],
          [`0px ${distance}px`, "0px 0px"],
          {
            extrapolateLeft: "clamp",
            extrapolateRight: "clamp",
            easing: Easing.bezier(0.16, 1, 0.3, 1),
          },
        ),
      }}
    >
      {children}
    </Interactive.Div>
  );
};
