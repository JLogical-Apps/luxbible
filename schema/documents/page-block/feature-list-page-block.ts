import { IconStar } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { convertToShared } from '@/sanity/plugins/convert-to-shared';
import {
  ColorPalette,
  colorPaletteRecord,
} from '@/schema/documents/design/color-palette';
import { PageBlockBase } from '@/schema/documents/page-block/page-block';
import { isElementMixin } from '@/schema/mixins/is-element';
import { Feature, featureRecord } from '@/schema/objects/feature';
import { record } from '@/schema/sanity-type';

export interface FeatureListPageBlock extends PageBlockBase {
  _type: 'featureListPageBlock';
  features: Feature[];
  iconColorPalette?: ColorPalette;
}

export const featureListPageBlockRecord = record({
  mixins: [isElementMixin],
  sanitySchema: () =>
    defineType({
      name: 'featureListPageBlock',
      title: 'Feature List',
      type: 'object',
      icon: IconStar,
      fields: [
        convertToShared({
          type: 'sharedPageBlock',
          innerField: 'pageBlock',
        }),
        {
          name: 'features',
          title: 'Features',
          type: 'array',
          of: [
            {
              type: 'feature',
            },
          ],
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
            title: 'Feature List',
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      features[]{${featureRecord.getGroqQueryPart()}},
      iconColorPalette->{${colorPaletteRecord.getGroqQueryPart()}},
    `;
  },
});
