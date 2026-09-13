import { z } from "zod";

const rectSchema = z.object({
  x: z.number(),
  y: z.number(),
  width: z.number(),
  height: z.number(),
});
const captionSchema = z.object({
  text: z.string(),
  startMs: z.number(),
  endMs: z.number(),
  timestampMs: z.number().nullable(),
  confidence: z.number().nullable(),
});
const segmentSchema = z.object({
  at: z.number(),
  sourceTime: z.number(),
  playSeconds: z.number(),
  playbackRate: z.number(),
});
export const overlaySchema = z.object({
  id: z.string(),
  src: z.string(),
  aspectRatio: z.number(),
  start: z.number(),
  end: z.number(),
  segments: z.array(segmentSchema),
  highlights: z.array(
    z.object({
      text: z.string(),
      start: z.number(),
      end: z.number().optional(),
      fadeAt: z.number().optional(),
      fadeSeconds: z.number().default(0.35),
      duration: z.number().default(0.4),
      lineDelay: z.number().default(8 / 30),
      color: z.string().default("rgba(255, 206, 45, 0.42)"),
      rects: z.array(rectSchema),
    }),
  ),
  focus: z
    .object({
      bottom: z.number(),
      fadeAt: z.number(),
      fadeSeconds: z.number().default(0.65),
    })
    .optional(),
});
export const facecamSchema = z.object({
  title: z.string(),
  titleSeconds: z.number().default(3),
  facecamSrc: z.string(),
  facecamZoom: z.number().min(1).default(1),
  facecamZoomOnlyWithSimulator: z.boolean().default(true),
  facecamFraming: z.array(z.object({
    at: z.number().min(0),
    zoom: z.number().min(1),
    centerX: z.number().min(0).max(1),
    offsetY: z.number().default(0),
  })).default([]),
  narrationSrc: z.string().default(""),
  narrationVolume: z.number().min(0).default(Math.SQRT1_2),
  musicSrc: z.string().default(""),
  musicSource: z.string().default(""),
  musicVolume: z.number().min(0).default(1),
  durationInSeconds: z.number(),
  captions: z.array(captionSchema),
  overlays: z.array(overlaySchema),
  captionFontSize: z.number().default(72),
  captionStrokeWidth: z.number().default(7),
  captionMaxCharacters: z.number().default(22),
  captionTop: z.number().default(0.75),
  overlayTop: z.number().default(0.02),
  overlayBottom: z.number().default(0.5),
  fadeSeconds: z.number().default(0.4),
});
export type FacecamProps = z.infer<typeof facecamSchema>;
export type Overlay = z.infer<typeof overlaySchema>;
export type { Caption } from "@remotion/captions";
