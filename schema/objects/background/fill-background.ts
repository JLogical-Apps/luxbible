import { IconRectangleFilled } from '@tabler/icons-react';
import { defineType } from 'sanity';

import {
  ColorPalette,
  colorPaletteRecord,
} from '@/schema/documents/design/color-palette';
import { BackgroundBase } from '@/schema/objects/background/background-record';
import { record } from '@/schema/sanity-type';

export interface FillBackground extends BackgroundBase {
  _type: 'fillBackground';
  colorPalette?: ColorPalette;
}

export const fillBackgroundRecord = record({
  sanitySchema: () =>
    defineType({
      type: 'object',
      name: 'fillBackground',
      title: 'Fill',
      description: 'A single color background.',
      icon: IconRectangleFilled,
      fields: [
        {
          type: 'reference',
          name: 'colorPalette',
          title: 'Color Palette',
          to: colorPaletteRecord.typeOption,
        },
      ],
      preview: {
        prepare() {
          return {
            title: 'Fill',
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      colorPalette->{${colorPaletteRecord.getGroqQueryPart()}},
    `;
  },
});
