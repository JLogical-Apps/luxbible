import { IconTable } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { convertToShared } from '@/sanity/plugins/convert-to-shared';
import { PageBlockBase } from '@/schema/documents/page-block/page-block';
import { isElementMixin } from '@/schema/mixins/is-element';
import { Item, itemRecord } from '@/schema/objects/item';
import { record } from '@/schema/sanity-type';

export interface ItemsListPageBlock extends PageBlockBase {
  _type: 'itemsListPageBlock';
  items: Item[];
}

export const itemsListPageBlockRecord = record({
  mixins: [isElementMixin],
  sanitySchema: () =>
    defineType({
      name: 'itemsListPageBlock',
      title: 'Items List',
      type: 'object',
      icon: IconTable,
      fields: [
        convertToShared({
          type: 'sharedPageBlock',
          innerField: 'pageBlock',
        }),
        {
          name: 'items',
          title: 'Items',
          type: 'array',
          of: itemRecord.typeOption,
          validation: (Rule) => Rule.min(1),
        },
      ],
      preview: {
        prepare() {
          return {
            title: 'Items List',
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      items[]{${itemRecord.getGroqQueryPart()}},
    `;
  },
});
