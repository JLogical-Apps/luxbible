import { zColor } from "@remotion/zod-types";
import { z } from "zod";

const highlightRectSchema = z.object({
  x: z.number().min(0).max(1),
  y: z.number().min(0).max(1),
  width: z.number().min(0).max(1),
  height: z.number().min(0).max(1),
});

export const questionShowcaseSchema = z.object({
  question: z.string().min(1),
  callToAction: z.string().min(1),
  mediaMaskSrc: z.string().optional(),
  mediaClipPath: z.string().optional(),
  mediaSrc: z.string().min(1),
  recordingSrc: z.string().optional(),
  recordingEndSrc: z.string().optional(),
  recordingDurationInFrames: z.number().int().nonnegative().optional(),
  backgroundSrc: z.string(),
  musicSrc: z.string().default(""),
  musicSource: z.string().default(""),
  musicVolume: z.number().min(0).max(1).default(1),
  durationInSeconds: z.number().min(3).max(60).step(0.1),
  mediaScale: z.number().min(0.7).max(1.3).step(0.05),
  mediaVolume: z.number().min(0).max(1).step(0.05),
  backgroundDarkness: z.number().min(0).max(0.85).step(0.05),
  backgroundSaturation: z.number().min(0).max(1).step(0.05).default(0.18),
  backgroundBrightness: z.number().min(0).max(1).step(0.05).default(0.42),
  verseHighlightRects: z.array(highlightRectSchema).default([]),
  highlightCues: z
    .array(
      z.object({
        rects: z.array(highlightRectSchema),
        startFrame: z.number().int().nonnegative(),
        endFrame: z.number().int().positive().optional(),
      }),
    )
    .optional(),
  studyHighlightRects: z.array(highlightRectSchema).default([]),
  shaderColor1: zColor(),
  shaderColor2: zColor(),
  shaderColor3: zColor(),
  shaderColor4: zColor(),
});

export type QuestionShowcaseProps = z.infer<typeof questionShowcaseSchema>;
