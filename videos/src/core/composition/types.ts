import type { ComponentType } from "react";

export type TransitionDirection = "left" | "right" | "up" | "down";

export type SceneTimingContext<Props> = {
  fps: number;
  props: Props;
};

export type SceneTransition = {
  direction: TransitionDirection;
  frames: number;
};

export type VideoSceneDefinition<Props> = {
  id: string;
  name: string;
  component: ComponentType<Props>;
  getDurationInFrames: (context: SceneTimingContext<Props>) => number;
  transition?: SceneTransition;
};

export type CompiledScene<Props> = {
  definition: VideoSceneDefinition<Props>;
  durationInFrames: number;
  startFrame: number;
  endFrame: number;
};

export type CompiledTransition = {
  direction: TransitionDirection;
  durationInFrames: number;
  fromSceneId: string;
  peakFrame: number;
};

export type CompiledTimeline<Props> = {
  scenes: CompiledScene<Props>[];
  transitions: CompiledTransition[];
  durationInFrames: number;
};

export type VideoBackgroundProps<Props> = {
  timeline: CompiledTimeline<Props>;
  videoProps: Props;
};

export type VideoDefinition<Props> = {
  id: string;
  backgroundColor: string;
  fontFamily: string;
  scenes: readonly VideoSceneDefinition<Props>[];
  background?: ComponentType<VideoBackgroundProps<Props>>;
  getMotionSpeed?: (props: Props) => number;
  getTransitionBlur?: (props: Props) => number;
};
