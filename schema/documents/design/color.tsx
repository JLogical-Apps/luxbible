import { IconCircleFilled, IconColorFilter } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { HslColor } from '@/lib/types/hsl-color';
import { record } from '@/schema/sanity-type';

export type Color = {
  color: HslColor;
};

export const colorRecord = record({
  sanitySchema: () =>
    defineType({
      type: 'document',
      name: 'colorPreset',
      title: 'Color',
      icon: IconColorFilter,
      fields: [
        {
          name: 'name',
          type: 'string',
          title: 'Name',
        },
        {
          name: 'color',
          type: 'color',
          title: 'Color',
          options: {
            disableAlpha: true,
          },
        },
      ],
      preview: {
        select: {
          name: 'name',
          color: 'color.hex',
        },
        prepare({ name, color }) {
          return {
            title: name,
            media: <IconCircleFilled style={{ color: color }} />,
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      color{
        "h": hsl.h,
        "s": hsl.s,
        "l": hsl.l,
      },
    `;
  },
});
