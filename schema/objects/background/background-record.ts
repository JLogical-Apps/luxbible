import {
  DotsBackground,
  dotsBackgroundRecord,
} from '@/schema/objects/background/dots-background';
import {
  FillBackground,
  fillBackgroundRecord,
} from '@/schema/objects/background/fill-background';
import {
  GradientBackground,
  gradientBackgroundRecord,
} from '@/schema/objects/background/gradient-background';
import {
  GridBackground,
  gridBackgroundRecord,
} from '@/schema/objects/background/grid-background';
import { abstractRecord } from '@/schema/sanity-type';

export type Background =
  | FillBackground
  | GradientBackground
  | GridBackground
  | DotsBackground;
export type BackgroundBase = {};

export const backgroundRecord = abstractRecord({
  records: [
    fillBackgroundRecord,
    gradientBackgroundRecord,
    gridBackgroundRecord,
    dotsBackgroundRecord,
  ],
});
