import { Fragment } from "react";
import { TransitionSeries, linearTiming } from "@remotion/transitions";
import { AbsoluteFill, useVideoConfig } from "remotion";
import { MotionProvider } from "../motion/MotionProvider";
import { whipPan } from "../remocn/whip-pan";
import { compileTimeline } from "./compileTimeline";
import type { VideoDefinition } from "./types";

export const VideoComposition = <Props extends object>({
  definition,
  videoProps,
}: {
  definition: VideoDefinition<Props>;
  videoProps: Props;
}) => {
  const { fps } = useVideoConfig();
  const timeline = compileTimeline(definition, fps, videoProps);
  const Background = definition.background;

  return (
    <AbsoluteFill
      style={{
        backgroundColor: definition.backgroundColor,
        fontFamily: definition.fontFamily,
      }}
    >
      {Background ? (
        <Background timeline={timeline} videoProps={videoProps} />
      ) : null}
      <MotionProvider speed={definition.getMotionSpeed?.(videoProps) ?? 1}>
        <TransitionSeries>
          {timeline.scenes.map(({ definition: scene, durationInFrames }) => {
            const SceneComponent = scene.component;

            return (
              <Fragment key={scene.id}>
                <TransitionSeries.Sequence
                  durationInFrames={durationInFrames}
                  name={scene.name}
                  premountFor={fps}
                >
                  <SceneComponent {...videoProps} />
                </TransitionSeries.Sequence>
                {scene.transition ? (
                  <TransitionSeries.Transition
                    presentation={whipPan({
                      direction: scene.transition.direction,
                      blur: definition.getTransitionBlur?.(videoProps) ?? 24,
                    })}
                    timing={linearTiming({
                      durationInFrames: scene.transition.frames,
                    })}
                  />
                ) : null}
              </Fragment>
            );
          })}
        </TransitionSeries>
      </MotionProvider>
    </AbsoluteFill>
  );
};
