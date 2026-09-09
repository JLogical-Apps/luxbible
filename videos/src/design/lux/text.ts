import type { LuxVideoProps } from "./schema";

export const getLuxTextStyle = (
  props: Pick<LuxVideoProps, "textColor" | "fontScale">,
): React.CSSProperties => ({
  color: props.textColor,
  fontSize: 66 * props.fontScale,
  fontWeight: 800,
  lineHeight: 1.18,
});
