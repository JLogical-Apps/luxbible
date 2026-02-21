import { IconListDetails } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { convertToShared } from '@/sanity/plugins/convert-to-shared';
import {
  ColorPalette,
  colorPaletteRecord,
} from '@/schema/documents/design/color-palette';
import { PageBlockBase } from '@/schema/documents/page-block/page-block';
import { isElementMixin } from '@/schema/mixins/is-element';
import { Description, descriptionRecord } from '@/schema/objects/description';
import { record } from '@/schema/sanity-type';

export interface DescriptionListPageBlock extends PageBlockBase {
  _type: 'descriptionListPageBlock';
  descriptions: Description[];
  iconColorPalette?: ColorPalette;
}

export const descriptionListPageBlockRecord = record({
  mixins: [isElementMixin],
  sanitySchema: () =>
    defineType({
      name: 'descriptionListPageBlock',
      title: 'Description List',
      type: 'object',
      icon: IconListDetails,
      fields: [
        convertToShared({
          type: 'sharedPageBlock',
          innerField: 'pageBlock',
        }),
        {
          name: 'descriptions',
          title: 'Descriptions',
          type: 'array',
          of: descriptionRecord.typeOption,
          validation: (Rule) => Rule.min(1),
        },
        {
          name: 'iconColorPalette',
          title: 'Icon Color Palette',
          type: 'reference',
          to: colorPaletteRecord.typeOption,
        },
      ],
      preview: {
        prepare() {
          return {
            title: 'Description List',
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      descriptions[]{${descriptionRecord.getGroqQueryPart()}},
      iconColorPalette->{${colorPaletteRecord.getGroqQueryPart()}},
    `;
  },
});
