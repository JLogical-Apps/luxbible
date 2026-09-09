import { useVideoConfig } from "remotion";
import { getSequenceClips } from "../../core/media/getSequenceClips";
import { SequencedVideo } from "../../core/media/SequencedVideo";
import type { MediaAsset, MediaDurations } from "../../core/media/types";
import { Rise } from "../../core/motion/Rise";

export const PhoneDemo = <Id extends string>({
  media,
  durations,
  name,
  style,
  imageScale,
  fadeFrames = 0,
  delay,
}: {
  media: readonly MediaAsset<Id>[];
  durations: MediaDurations<Id>;
  name: string;
  style: React.CSSProperties;
  imageScale: number;
  fadeFrames?: number;
  delay: number;
}) => {
  const { fps } = useVideoConfig();
  const clips = getSequenceClips(media, durations, fps, delay, fadeFrames);

  return (
    <Rise
      name={name}
      delay={delay}
      distance={1200}
      style={{ ...style, position: "absolute", scale: imageScale }}
    >
      <SequencedVideo clips={clips} fadeFrames={fadeFrames} />
    </Rise>
  );
};
