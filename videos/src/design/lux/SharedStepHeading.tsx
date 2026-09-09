import { Interactive } from "remotion";
import { SharedAxisZ } from "../../core/remocn/shared-axis-z";
import type { LuxVideoProps } from "./schema";
import { SAFE_X } from "./StepHeading";

export const SharedStepHeading: React.FC<
  Pick<
    LuxVideoProps,
    "accentColor" | "textColor" | "fontScale" | "motionSpeed"
  > & {
    letter: string;
    fromTitle: string;
    title: string;
  }
> = ({
  letter,
  fromTitle,
  title,
  accentColor,
  textColor,
  fontScale,
  motionSpeed,
}) => (
  <Interactive.Div
    name="Shared step heading"
    style={{
      position: "absolute",
      top: 250,
      left: SAFE_X,
      right: SAFE_X,
      height: 100,
      fontSize: 88 * fontScale,
      fontWeight: 900,
      lineHeight: 1.02,
    }}
  >
    <span style={{ color: accentColor }}>{letter}:</span>
    <div
      style={{
        position: "absolute",
        top: 0,
        left: 112 * fontScale,
        right: 0,
        height: 100,
      }}
    >
      <SharedAxisZ
        fromText={fromTitle}
        toText={title}
        color={textColor}
        fontSize={88 * fontScale}
        fontWeight={900}
        speed={motionSpeed}
      />
    </div>
  </Interactive.Div>
);
