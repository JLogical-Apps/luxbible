import { IconDeviceIpadShare } from '@tabler/icons-react';
import { defineType } from 'sanity';

import {
  getPageBlockRecord,
  PageBlock,
  PageBlockBase,
} from '@/schema/documents/page-block/page-block';
import { isElementMixin } from '@/schema/mixins/is-element';
import { record } from '@/schema/sanity-type';

export interface SharedPageBlockWrapper extends PageBlockBase {
  _type: 'sharedPageBlockWrapper';
  pageBlock: PageBlock;
}

export const sharedPageBlockWrapperRecord = record({
  mixins: [isElementMixin],
  sanitySchema: () =>
    defineType({
      name: 'sharedPageBlockWrapper',
      title: 'Shared Page Block',
      type: 'object',
      icon: IconDeviceIpadShare,
      fields: [
        {
          name: 'sharedPageBlock',
          type: 'reference',
          to: [
            {
              type: 'sharedPageBlock',
            },
          ],
          title: 'Shared Page Block',
        },
      ],
      preview: {
        select: {
          title: 'sharedPageBlock.pageBlock.0.title',
        },
      },
    }),
  groqQueryPart(): string {
    return `
      "pageBlock": sharedPageBlock->pageBlock[0]{${getPageBlockRecord({
        includeShared: false,
      }).getGroqQueryPart()}},
    `;
  },
});
