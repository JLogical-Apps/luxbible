import { toPlainText } from '@portabletext/react';
import { PortableTextBlock } from '@portabletext/types';
import { groq } from 'next-sanity';
import { defineType } from 'sanity';

import { Media, mediaRecord } from '@/schema/documents/media/media';
import { mediaField } from '@/schema/fields/media-field';
import { bodyRichTextQueryPart } from '@/schema/richtext/body-rich-text';
import {
  inlineRichText,
  inlineRichTextQueryPart,
} from '@/schema/richtext/inline-rich-text';
import { record } from '@/schema/sanity-type';

export type Description = {
  title: PortableTextBlock[];
  subtitle: PortableTextBlock[];
  media: Media;
};

export const descriptionRecord = record<Description>({
  sanitySchema: () =>
    defineType({
      name: 'description',
      type: 'object',
      title: 'Description',
      fields: [
        {
          name: 'title',
          title: 'Title',
          ...inlineRichText,
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'subtitle',
          title: 'Subtitle',
          ...inlineRichText,
          validation: (Rule) => Rule.required(),
        },
        {
          ...mediaField,
          validation: (Rule) => Rule.required(),
        },
      ],
      preview: {
        select: {
          title: 'title',
          subtitle: 'subtitle',
        },
        prepare({ title, subtitle }) {
          return {
            title: toPlainText(title),
            subtitle: toPlainText(subtitle),
          };
        },
      },
    }),
  groqQueryPart: () => groq`
      title[]{${inlineRichTextQueryPart}},
      subtitle[]{${bodyRichTextQueryPart}},
      media->{${mediaRecord.getGroqQueryPart()}},
  `,
});
