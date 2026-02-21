import SVG from 'react-inlinesvg';
import { defineField, defineType } from 'sanity';

import { Icon, iconQueryPart } from '@/lib/types/icon';
import {
  ColorPalette,
  colorPaletteRecord,
} from '@/schema/documents/design/color-palette';
import { iconField } from '@/schema/fields/icon-field';
import { Action, actionRecord } from '@/schema/objects/action/action';
import { record } from '@/schema/sanity-type';

export const CTA_TYPES = [
  { title: 'Filled', value: 'filled' },
  { title: 'Outline', value: 'outline' },
  { title: 'Ghost', value: 'ghost' },
  { title: 'Link', value: 'link' },
] as const;

type CtaTypeValue = (typeof CTA_TYPES)[number]['value'];

export type Cta = {
  text: string;
  icon?: Icon;
  type: CtaTypeValue;
  colorPalette?: ColorPalette;
  action: Action;
};

export const ctaRecord = record<Cta>({
  sanitySchema: () =>
    defineType({
      name: 'cta',
      type: 'object',
      title: 'CTA',
      fields: [
        defineField({
          name: 'text',
          title: 'Text',
          type: 'string',
        }),
        defineField({
          ...iconField,
          name: 'icon',
          title: 'Icon',
        }),
        defineField({
          type: 'string',
          name: 'type',
          title: 'Type',
          description: 'How the CTA will be displayed.',
          validation: (Rule) => Rule.required(),
          options: {
            list: [...CTA_TYPES],
          },
        }),
        {
          type: 'reference',
          name: 'colorPalette',
          title: 'Color Palette Override',
          to: colorPaletteRecord.typeOption,
        },
        {
          type: 'array',
          name: 'action',
          title: 'Action',
          of: actionRecord.typeOption,
          options: {
            single: true,
          },
        },
      ],
      preview: {
        select: {
          text: 'text',
          icon: 'icon.svg',
        },
        prepare({ text, icon }) {
          return {
            title: text,
            media: icon && (
              <SVG
                src={icon}
                style={{
                  width: '1em',
                  height: '1em',
                }}
              />
            ),
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
        text,
        icon{${iconQueryPart}},
        type,
        "action": action[0]{${actionRecord.getGroqQueryPart()}},
        colorPalette->{${colorPaletteRecord.getGroqQueryPart()}},
    `;
  },
});
