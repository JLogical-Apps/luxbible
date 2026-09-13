import type { VideoBackgroundProps } from "../../core/composition/types";
import { ShaderMeshGradient } from "../../core/remocn/shader-mesh-gradient";
import {
  AbsoluteFill,
  Easing,
  interpolate,
  useCurrentFrame,
  useVideoConfig,
} from "remotion";
import type { LuxVideoProps } from "./schema";

const getTransitionRange = ({
  peakFrame,
  durationInFrames,
}: {
  peakFrame: number;
  durationInFrames: number;
}) => [peakFrame - durationInFrames / 2, peakFrame + durationInFrames / 2];

export const LuxBackground = <Props extends LuxVideoProps>({
  timeline,
  videoProps: {
    shaderColor1,
    shaderColor2,
    shaderColor3,
    shaderColor4,
    shaderSpeed,
    shaderTransitionSpeed,
    shaderTransitionLeadSeconds,
    shaderTransitionTrailSeconds,
    shaderTransitionEaseSeconds,
    shaderDistortion,
    shaderSwirl,
    shaderDarkness,
  },
}: VideoBackgroundProps<Props>) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const getCubicEaseIntegral = (progress: number) =>
    progress ** 3 - progress ** 4 / 2;
  const getTransitionArea = (peak: number, frames: number) => {
    const transitionStart = peak - frames / 2;
    const transitionEnd = peak + frames / 2;
    const leadStart = transitionStart - shaderTransitionLeadSeconds * fps;
    const trailEnd = transitionEnd + shaderTransitionTrailSeconds * fps;
    const leadEaseEnd = Math.min(
      transitionStart,
      leadStart + shaderTransitionEaseSeconds * fps,
    );
    const trailEaseStart = Math.max(
      transitionEnd,
      trailEnd - shaderTransitionEaseSeconds * fps,
    );
    const leadFrames = leadEaseEnd - leadStart;
    const trailFrames = trailEnd - trailEaseStart;
    const fullEffectFrames = trailEaseStart - leadEaseEnd;

    if (frame <= leadStart) return 0;
    if (frame < leadEaseEnd) {
      return (
        leadFrames * getCubicEaseIntegral((frame - leadStart) / leadFrames)
      );
    }
    if (frame <= trailEaseStart) {
      return leadFrames / 2 + frame - leadEaseEnd;
    }
    if (frame < trailEnd) {
      const progress = (frame - trailEaseStart) / trailFrames;
      return (
        leadFrames / 2 +
        fullEffectFrames +
        trailFrames * (progress - getCubicEaseIntegral(progress))
      );
    }
    return leadFrames / 2 + fullEffectFrames + trailFrames / 2;
  };
  const transitionTime = timeline.transitions.reduce(
    (sum, { peakFrame, durationInFrames }) =>
      sum + getTransitionArea(peakFrame, durationInFrames),
    0,
  );
  const firstTransition = timeline.transitions[0];
  const lastTransition = timeline.transitions[timeline.transitions.length - 1];
  const bookendDarkness =
    firstTransition && lastTransition
      ? Math.max(
          interpolate(frame, getTransitionRange(firstTransition), [0.5, 0], {
            extrapolateLeft: "clamp",
            extrapolateRight: "clamp",
            easing: Easing.inOut(Easing.cubic),
          }),
          interpolate(frame, getTransitionRange(lastTransition), [0, 0.5], {
            extrapolateLeft: "clamp",
            extrapolateRight: "clamp",
            easing: Easing.inOut(Easing.cubic),
          }),
        )
      : 0.5;

  return (
    <AbsoluteFill>
      <ShaderMeshGradient
        colors={[shaderColor1, shaderColor2, shaderColor3, shaderColor4]}
        timelineFrame={
          ((frame * shaderSpeed + transitionTime * shaderTransitionSpeed) /
            fps) *
          1000
        }
        distortion={shaderDistortion}
        swirl={shaderSwirl}
      />
      <AbsoluteFill
        style={{
          background: `linear-gradient(180deg, rgba(7, 8, 8, ${shaderDarkness}), rgba(7, 8, 8, ${Math.min(shaderDarkness + 0.12, 0.96)}))`,
        }}
      />
      <AbsoluteFill
        style={{ backgroundColor: "black", opacity: bookendDarkness }}
      />
    </AbsoluteFill>
  );
};
