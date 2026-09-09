import type { MediaAsset, MediaDurations, TimedMediaClip } from "./types";

export const getMediaFrames = <Id extends string>(
  id: Id,
  durations: MediaDurations<Id>,
  fps: number,
) => Math.ceil(durations[id] * fps);

export const getSequenceClips = <Id extends string>(
  media: readonly MediaAsset<Id>[],
  durations: MediaDurations<Id>,
  fps: number,
  delay: number,
  fadeFrames = 0,
) => {
  let from = delay;

  return media.map<TimedMediaClip<Id>>(({ id, src }) => {
    const durationInFrames = getMediaFrames(id, durations, fps);
    const clip = { id, src, from, durationInFrames };
    from += durationInFrames - fadeFrames;
    return clip;
  });
};
