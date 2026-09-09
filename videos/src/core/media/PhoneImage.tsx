import { Easing, Img, interpolate, staticFile, useCurrentFrame } from "remotion";
import { useMotionSpeed } from "../motion/MotionProvider";

export const PhoneImage: React.FC<{
  src: string;
  name: string;
  style: React.CSSProperties;
  imageScale: number;
  delay?: number;
  entrance?: "scale" | "from-bottom";
}> = ({ src, name, style, imageScale, delay = 12, entrance = "scale" }) => {
  const frame = useCurrentFrame();
  const speed = useMotionSpeed();
  const revealFrames = 30 / speed;

  return (
    <Img
      name={name}
      src={staticFile(src)}
      style={{
        ...style,
        position: "absolute",
        objectFit: "contain",
        opacity: interpolate(frame, [delay, delay + revealFrames], [0, 1], {
          extrapolateLeft: "clamp",
          extrapolateRight: "clamp",
        }),
        translate:
          entrance === "from-bottom"
            ? interpolate(
                frame,
                [delay, delay + revealFrames],
                ["0px 1200px", "0px 0px"],
                {
                  extrapolateLeft: "clamp",
                  extrapolateRight: "clamp",
                  easing: Easing.bezier(0.16, 1, 0.3, 1),
                },
              )
            : undefined,
        scale: interpolate(
          frame,
          [delay, delay + revealFrames],
          entrance === "scale"
            ? [imageScale * 0.94, imageScale]
            : [imageScale, imageScale],
          {
            extrapolateLeft: "clamp",
            extrapolateRight: "clamp",
            easing: Easing.spring({ damping: 18 }),
            output: "perceptual-scale",
          },
        ),
      }}
    />
  );
};
