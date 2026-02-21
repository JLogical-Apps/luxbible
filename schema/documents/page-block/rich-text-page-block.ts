import { toPlainText } from '@portabletext/react';
import { PortableTextBlock } from '@portabletext/types';
import { IconTextSize } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { convertToShared } from '@/sanity/plugins/convert-to-shared';
import { PageBlockBase } from '@/schema/documents/page-block/page-block';
import { isElementMixin } from '@/schema/mixins/is-element';
import {
  bodyRichText,
  bodyRichTextQueryPart,
} from '@/schema/richtext/body-rich-text';
import { record } from '@/schema/sanity-type';

export interface RichTextPageBlock extends PageBlockBase {
  _type: 'richTextPageBlock';
  body: PortableTextBlock[];
}

export const richTextPageBlockRecord = record({
  mixins: [isElementMixin],
  sanitySchema: () =>
    defineType({
      name: 'richTextPageBlock',
      title: 'Rich Text',
      type: 'object',
      icon: IconTextSize,
      fields: [
        convertToShared({
          type: 'sharedPageBlock',
          innerField: 'pageBlock',
        }),
        {
          name: 'body',
          ...bodyRichText,
        },
      ],
      preview: {
        select: {
          body: 'body',
        },
        prepare({ body }) {
          return {
            title: 'Rich Text',
            subtitle: toPlainText(body),
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      body{${bodyRichTextQueryPart}},
    `;
  },
});
