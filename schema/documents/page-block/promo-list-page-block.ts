import { IconLayoutDashboard } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { convertToShared } from '@/sanity/plugins/convert-to-shared';
import { PageBlockBase } from '@/schema/documents/page-block/page-block';
import { isElementMixin } from '@/schema/mixins/is-element';
import { record } from '@/schema/sanity-type';

export interface PromoListPageBlock extends PageBlockBase {
  _type: 'promoListPageBlock';
}

export const promoListPageBlockRecord = record({
  mixins: [isElementMixin],
  sanitySchema: () =>
    defineType({
      name: 'promoListPageBlock',
      title: 'Promo List',
      type: 'object',
      icon: IconLayoutDashboard,
      fields: [
        convertToShared({
          type: 'sharedPageBlock',
          innerField: 'pageBlock',
        }),
      ],
      preview: {
        prepare() {
          return {
            title: 'Promo List',
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
    `;
  },
});
