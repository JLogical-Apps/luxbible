import { zColor } from "@remotion/zod-types";
import { z } from "zod";

export const luxVideoSchema = z.object({
  accentColor: zColor(),
  redColor: zColor(),
  textColor: zColor(),
  shaderColor1: zColor(),
  shaderColor2: zColor(),
  shaderColor3: zColor(),
  shaderColor4: zColor(),
  motionSpeed: z.number().min(0.5).max(2).step(0.05),
  shaderSpeed: z.number().min(0).max(1.5).step(0.05),
  shaderTransitionSpeed: z.number().min(0).max(2.5).step(0.05),
  shaderTransitionLeadSeconds: z.number().min(0).max(1).step(0.05),
  shaderTransitionTrailSeconds: z.number().min(0).max(1).step(0.05),
  shaderTransitionEaseSeconds: z.number().min(0).max(1).step(0.05),
  shaderDistortion: z.number().min(0).max(1).step(0.05),
  shaderSwirl: z.number().min(0).max(1).step(0.05),
  shaderDarkness: z.number().min(0).max(0.9).step(0.05),
  fontScale: z.number().min(0.75).max(1.25).step(0.05),
  imageScale: z.number().min(0.75).max(1.25).step(0.05),
  whipBlur: z.number().min(0).max(50).step(1),
});

export type LuxVideoProps = z.infer<typeof luxVideoSchema>;
