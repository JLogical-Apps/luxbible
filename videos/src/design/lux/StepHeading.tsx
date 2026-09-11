import { Interactive } from "remotion";
import { Rise } from "../../core/motion/Rise";
import { Accent } from "../../core/text/Accent";
import type { LuxVideoProps } from "./schema";

export const SAFE_X = 82;

export const StepHeading: React.FC<
  Pick<LuxVideoProps, "accentColor" | "textColor" | "fontScale"> & {
    letter: string;
    title: string;
    isAnimated?: boolean;
  }
> = ({
  letter,
  title,
  accentColor,
  textColor,
  fontScale,
  isAnimated = true,
}) => {
  const style = {
    position: "absolute" as const,
    top: 250,
    left: SAFE_X,
    right: SAFE_X,
    color: textColor,
    fontSize: 88 * fontScale,
    fontWeight: 900,
    lineHeight: 1.02,
  };
  const content = (
    <>
      <Accent color={accentColor}>{letter}:</Accent> {title}
    </>
  );

  return isAnimated ? (
    <Rise name="Step heading" style={style}>
      {content}
    </Rise>
  ) : (
    <Interactive.Div name="Step heading" style={style}>
      {content}
    </Interactive.Div>
  );
};
