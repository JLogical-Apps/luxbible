import { PortableTextBlock } from '@portabletext/types';
import { groq } from 'next-sanity';
import { defineType } from 'sanity';

import { Media, mediaRecord } from '@/schema/documents/media/media';
import { mediaField } from '@/schema/fields/media-field';
import { Cta, ctaRecord } from '@/schema/objects/cta';
import {
  inlineRichText,
  inlineRichTextQueryPart,
} from '@/schema/richtext/inline-rich-text';
import { record } from '@/schema/sanity-type';

export type Item = {
  name: PortableTextBlock[] | string;
  body: PortableTextBlock[] | string;
  media: Media;
  cta: Cta;
};

export const itemRecord = record<Item>({
  sanitySchema: () =>
    defineType({
      name: 'item',
      type: 'object',
      title: 'Item',
      fields: [
        {
          name: 'name',
          title: 'Name',
          ...inlineRichText,
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'body',
          title: 'Body',
          ...inlineRichText,
          validation: (Rule) => Rule.required(),
        },
        {
          ...mediaField,
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'cta',
          title: 'CTA',
          type: 'cta',
        },
      ],
      preview: {
        select: {
          title: 'name',
          description: 'body',
          media: 'media.image.asset',
        },
      },
    }),
  groqQueryPart: () => groq`
      name[]{${inlineRichTextQueryPart}},
      body[]{${inlineRichTextQueryPart}},
      media->{${mediaRecord.getGroqQueryPart()}},
      cta{${ctaRecord.getGroqQueryPart()}},
  `,
});
