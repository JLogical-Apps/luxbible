import { IconGrid4x4 } from '@tabler/icons-react';
import { defineType } from 'sanity';

import {
  ColorPalette,
  colorPaletteRecord,
} from '@/schema/documents/design/color-palette';
import { Brightness, brightnessField } from '@/schema/fields/brightness-field';
import { Size, sizeField } from '@/schema/fields/size-field';
import { BackgroundBase } from '@/schema/objects/background/background-record';
import { record } from '@/schema/sanity-type';

export interface GridBackground extends BackgroundBase {
  _type: 'gridBackground';
  colorPalette?: ColorPalette;
  brightness: Brightness;
  size: Size;
}

export const gridBackgroundRecord = record({
  sanitySchema: () =>
    defineType({
      type: 'object',
      name: 'gridBackground',
      title: 'Grid',
      description: 'A background with a faint grid.',
      icon: IconGrid4x4,
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
            'Whether the background is light or dark. Used to determine the grid color.',
          validation: (Rule) => Rule.required(),
        },
        {
          ...sizeField,
          name: 'size',
          title: 'Size',
          description: 'Size of the grid.',
        },
      ],
      preview: {
        prepare() {
          return {
            title: 'Grid',
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      colorPalette->{${colorPaletteRecord.getGroqQueryPart()}},
      brightness,
      size,
    `;
  },
});
