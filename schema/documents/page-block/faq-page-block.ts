import { IconUserQuestion } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { convertToShared } from '@/sanity/plugins/convert-to-shared';
import { PageBlockBase } from '@/schema/documents/page-block/page-block';
import { isElementMixin } from '@/schema/mixins/is-element';
import { Faq, faqRecord } from '@/schema/objects/faq';
import { record } from '@/schema/sanity-type';

export interface FaqPageBlock extends PageBlockBase {
  _type: 'faqPageBlock';
  faqs: Faq[];
}

export const faqPageBlockRecord = record({
  mixins: [isElementMixin],
  sanitySchema: () =>
    defineType({
      name: 'faqPageBlock',
      title: 'FAQs',
      type: 'object',
      icon: IconUserQuestion,
      fields: [
        convertToShared({
          type: 'sharedPageBlock',
          innerField: 'pageBlock',
        }),
        {
          name: 'faqs',
          title: 'FAQs',
          type: 'array',
          of: faqRecord.typeOption,
          validation: (Rule) => Rule.min(1),
        },
      ],
      preview: {
        prepare() {
          return {
            title: 'FAQs',
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      faqs[]{${faqRecord.getGroqQueryPart()}},
    `;
  },
});
