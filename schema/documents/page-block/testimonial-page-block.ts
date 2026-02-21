import { IconQuote } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { convertToShared } from '@/sanity/plugins/convert-to-shared';
import { PageBlockBase } from '@/schema/documents/page-block/page-block';
import { Testimonial, testimonialRecord } from '@/schema/documents/testimonial';
import { isElementMixin } from '@/schema/mixins/is-element';
import { record } from '@/schema/sanity-type';

export interface TestimonialPageBlock extends PageBlockBase {
  _type: 'testimonialPageBlock';
  testimonials: Testimonial[];
}

export const testimonialPageBlockRecord = record({
  mixins: [isElementMixin],
  sanitySchema: () =>
    defineType({
      name: 'testimonialPageBlock',
      title: 'Testimonials',
      type: 'object',
      icon: IconQuote,
      fields: [
        convertToShared({
          type: 'sharedPageBlock',
          innerField: 'pageBlock',
        }),
        {
          name: 'testimonials',
          title: 'Testimonials',
          type: 'array',
          of: testimonialRecord.referenceTypeOption,
          validation: (Rule) => Rule.min(1),
        },
      ],
      preview: {
        prepare() {
          return {
            title: 'Testimonials',
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      testimonials[]->{${testimonialRecord.getGroqQueryPart()}},
    `;
  },
});
