import { Rise } from "../../core/motion/Rise";
import { Accent } from "../../core/text/Accent";
import type { LuxVideoProps } from "./schema";

export const SAFE_X = 82;

export const StepHeading: React.FC<
  Pick<LuxVideoProps, "accentColor" | "textColor" | "fontScale"> & {
    letter: string;
    title: string;
  }
> = ({ letter, title, accentColor, textColor, fontScale }) => (
  <Rise
    name="Step heading"
    style={{
      position: "absolute",
      top: 250,
      left: SAFE_X,
      right: SAFE_X,
      color: textColor,
      fontSize: 88 * fontScale,
      fontWeight: 900,
      lineHeight: 1.02,
    }}
  >
    <Accent color={accentColor}>{letter}:</Accent> {title}
  </Rise>
);
