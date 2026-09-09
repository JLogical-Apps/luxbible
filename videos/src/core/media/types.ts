export type MediaDurations<Id extends string = string> = Record<Id, number>;

export type MediaAsset<Id extends string = string> = {
  id: Id;
  src: string;
};

export type TimedMediaClip<Id extends string = string> = MediaAsset<Id> & {
  from: number;
  durationInFrames: number;
};
