import { Video } from "@remotion/media";
import {
  Freeze,
  interpolate,
  Sequence,
  staticFile,
  useCurrentFrame,
} from "remotion";
import type { TimedMediaClip } from "./types";

export const SequencedVideo = <Id extends string>({
  clips,
  fadeFrames = 0,
}: {
  clips: readonly TimedMediaClip<Id>[];
  fadeFrames?: number;
}) => {
  const frame = useCurrentFrame();
  const firstClip = clips[0];
  const lastClip = clips[clips.length - 1];
  const start = firstClip.from;
  const end = lastClip.from + lastClip.durationInFrames - 1;

  return (
    <Freeze
      frame={Math.min(Math.max(frame, start), end)}
      active={frame < start || frame > end}
    >
      {clips.map(({ id, src, from, durationInFrames }, index) => (
        <Sequence
          key={id}
          name={id}
          from={from}
          durationInFrames={durationInFrames}
          layout="none"
        >
          <ClipVideo
            src={src}
            fadeFrames={index === 0 ? 0 : fadeFrames}
          />
        </Sequence>
      ))}
    </Freeze>
  );
};

const ClipVideo: React.FC<{ src: string; fadeFrames: number }> = ({
  src,
  fadeFrames,
}) => {
  const frame = useCurrentFrame();

  return (
    <Video
      src={staticFile(src)}
      muted
      objectFit="contain"
      style={{
        position: "absolute",
        inset: 0,
        width: "100%",
        height: "100%",
        opacity:
          fadeFrames === 0
            ? 1
            : interpolate(frame, [0, fadeFrames], [0, 1], {
                extrapolateLeft: "clamp",
                extrapolateRight: "clamp",
              }),
      }}
    />
  );
};
