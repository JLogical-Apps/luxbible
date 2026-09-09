import type { CompiledTimeline, VideoDefinition } from "./types";

export const compileTimeline = <Props,>(
  definition: VideoDefinition<Props>,
  fps: number,
  props: Props,
): CompiledTimeline<Props> => {
  let nextStartFrame = 0;

  const scenes = definition.scenes.map((scene) => {
    const durationInFrames = scene.getDurationInFrames({ fps, props });
    const startFrame = nextStartFrame;
    const endFrame = startFrame + durationInFrames;
    nextStartFrame = endFrame - (scene.transition?.frames ?? 0);

    return { definition: scene, durationInFrames, startFrame, endFrame };
  });

  return {
    scenes,
    transitions: scenes.flatMap(({ definition: scene, endFrame }) =>
      scene.transition
        ? [
            {
              direction: scene.transition.direction,
              durationInFrames: scene.transition.frames,
              fromSceneId: scene.id,
              peakFrame: endFrame - scene.transition.frames / 2,
            },
          ]
        : [],
    ),
    durationInFrames: scenes[scenes.length - 1]?.endFrame ?? 1,
  };
};
