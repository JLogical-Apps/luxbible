import { PortableTextBlock } from '@portabletext/types';
import { groq } from 'next-sanity';
import { defineType } from 'sanity';

import {
  inlineRichText,
  inlineRichTextQueryPart,
} from '@/schema/richtext/inline-rich-text';
import { record } from '@/schema/sanity-type';

export type Faq = {
  question: PortableTextBlock[];
  answer: PortableTextBlock[];
};

export const faqRecord = record<Faq>({
  sanitySchema: () =>
    defineType({
      name: 'faq',
      type: 'object',
      title: 'FAQ',
      fields: [
        {
          name: 'question',
          title: 'Question',
          ...inlineRichText,
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'answer',
          title: 'Answer',
          ...inlineRichText,
          validation: (Rule) => Rule.required(),
        },
      ],
      preview: {
        select: {
          title: 'question',
          subtitle: 'answer',
        },
      },
    }),
  groqQueryPart: () => groq`
      question[]{${inlineRichTextQueryPart}},
      answer[]{${inlineRichTextQueryPart}},
  `,
});
