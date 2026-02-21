import { IconRainbow } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { Color, colorRecord } from '@/schema/documents/design/color';
import {
  ColorPalette,
  colorPaletteRecord,
} from '@/schema/documents/design/color-palette';
import { BackgroundBase } from '@/schema/objects/background/background-record';
import { record } from '@/schema/sanity-type';

export interface GradientBackground extends BackgroundBase {
  _type: 'gradientBackground';
  colorPalette?: ColorPalette;
  startColor: Color;
  endColor: Color;
}

export const gradientBackgroundRecord = record({
  sanitySchema: () =>
    defineType({
      type: 'object',
      name: 'gradientBackground',
      title: 'Gradient',
      description: 'A gradient background.',
      icon: IconRainbow,
      fields: [
        {
          type: 'reference',
          name: 'colorPalette',
          title: 'Color Palette',
          to: colorPaletteRecord.typeOption,
        },
        {
          ...colorRecord.sharedOrOneOff,
          name: 'startColor',
          title: 'Start Color',
          validation: (Rule) => Rule.required(),
        },
        {
          ...colorRecord.sharedOrOneOff,
          name: 'endColor',
          title: 'End Color',
          validation: (Rule) => Rule.required(),
        },
      ],
      preview: {
        prepare() {
          return {
            title: 'Gradient',
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      colorPalette->{${colorPaletteRecord.getGroqQueryPart()}},
      "startColor": {${colorRecord.getSharedOrOneOffGroqQueryPart(
        'startColor',
      )}},
      "endColor": {${colorRecord.getSharedOrOneOffGroqQueryPart('endColor')}},
    `;
  },
});
