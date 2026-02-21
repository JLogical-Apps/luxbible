import { IconGridDots } from '@tabler/icons-react';
import { defineType } from 'sanity';

import {
  ColorPalette,
  colorPaletteRecord,
} from '@/schema/documents/design/color-palette';
import { Brightness, brightnessField } from '@/schema/fields/brightness-field';
import { BackgroundBase } from '@/schema/objects/background/background-record';
import { record } from '@/schema/sanity-type';

export interface DotsBackground extends BackgroundBase {
  _type: 'dotsBackground';
  colorPalette?: ColorPalette;
  brightness: Brightness;
}

export const dotsBackgroundRecord = record({
  sanitySchema: () =>
    defineType({
      type: 'object',
      name: 'dotsBackground',
      title: 'Dots',
      description: 'A background with a faint grid of dots.',
      icon: IconGridDots,
      fields: [
        {
          type: 'reference',
          name: 'colorPalette',
          title: 'Color Palette',
          to: colorPaletteRecord.typeOption,
        },
        {
          ...brightnessField,
          name: 'brightness',
          title: 'Brightness',
          description:
            'Whether the background is light or dark. Used to determine the dots color.',
          validation: (Rule) => Rule.required(),
        },
      ],
      preview: {
        prepare() {
          return {
            title: 'Dots',
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      colorPalette->{${colorPaletteRecord.getGroqQueryPart()}},
      brightness,
    `;
  },
});
