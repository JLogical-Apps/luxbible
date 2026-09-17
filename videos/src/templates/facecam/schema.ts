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
const animatedLayoutSchema = z.object({
  at: z.number(),
  transitionSeconds: z.number().min(0).default(0.3),
  width: z.number().positive(),
  height: z.number().positive(),
  centerY: z.number(),
  sourceScale: z.number().min(1).default(1),
  sourceCenterX: z.number().min(0).max(1).default(0.5),
  sourceCenterY: z.number().min(0).max(1).default(0.5),
});
const overlayLayoutSchema = animatedLayoutSchema
  .omit({
    at: true,
    transitionSeconds: true,
  })
  .extend({
    keyframes: z.array(animatedLayoutSchema).default([]),
  });
const circleSchema = z.object({
  rect: rectSchema,
  start: z.number(),
  duration: z.number().positive().default(0.6),
  color: z.string().default("#ff3b30"),
  strokeWidth: z.number().positive().default(8),
  roughness: z.number().positive().default(1.8),
  paddingX: z.number().min(0).default(0.02),
  paddingTop: z.number().min(0).default(0.02),
  paddingBottom: z.number().min(0).default(0.02),
});
const calloutSchema = z.object({
  text: z.string(),
  start: z.number(),
  x: z.number(),
  y: z.number(),
  width: z.number().positive(),
  height: z.number().positive(),
  pointerPosition: z.number().min(0).max(1).default(0.5),
  backgroundColor: z.string().default("#f7f7f5"),
  color: z.string().default("#090909"),
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
  layout: overlayLayoutSchema.optional(),
  pixelate: z
    .object({
      x: z.number().min(0).max(1),
      y: z.number().min(0).max(1),
      width: z.number().positive(),
      height: z.number().positive(),
      startBlockSize: z.number().min(1).default(42),
      endBlockSize: z.number().min(1).default(8),
      drift: z.number().min(0).default(0.018),
    })
    .optional(),
  circles: z.array(circleSchema).default([]),
  callouts: z.array(calloutSchema).default([]),
  sourceScaleX: z.number().min(1).default(1),
  sourceScaleY: z.number().min(1).default(1),
  fadeEdges: z.boolean().default(true),
  seamlessEdges: z.boolean().default(false),
});
export const facecamSchema = z.object({
  title: z.string(),
  titleSeconds: z.number().default(3),
  facecamSrc: z.string(),
  facecamClips: z
    .array(
      z.object({
        id: z.string(),
        src: z.string(),
        start: z.number().min(0),
        duration: z.number().positive(),
      }),
    )
    .default([]),
  facecamZoom: z.number().min(1).default(1),
  facecamZoomOnlyWithSimulator: z.boolean().default(true),
  facecamFraming: z
    .array(
      z.object({
        at: z.number().min(0),
        transitionSeconds: z.number().min(0).default(0),
        easing: z.enum(["cubic", "quartic"]).default("cubic"),
        zoom: z.number().min(1),
        centerX: z.number().min(0).max(1),
        offsetY: z.number().default(0),
        transformOriginY: z.number().min(0).max(1).default(0.75),
        titleTop: z.number().min(0).max(1).optional(),
      }),
    )
    .default([]),
  titleCues: z
    .array(
      z.object({
        text: z.string(),
        start: z.number().min(0),
        end: z.number().positive(),
        top: z.number().min(0).max(1).optional(),
        fontSize: z.number().positive().default(60),
      }),
    )
    .default([]),
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
