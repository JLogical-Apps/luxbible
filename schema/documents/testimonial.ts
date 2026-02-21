import { PortableTextBlock } from '@portabletext/types';
import { IconQuote } from '@tabler/icons-react';
import { groq } from 'next-sanity';
import { defineType } from 'sanity';

import { Media, mediaRecord } from '@/schema/documents/media/media';
import { mediaField } from '@/schema/fields/media-field';
import {
  inlineRichText,
  inlineRichTextQueryPart,
} from '@/schema/richtext/inline-rich-text';
import { record } from '@/schema/sanity-type';

export type Testimonial = {
  name: string;
  title: PortableTextBlock[];
  profilePicture: Media;
  quote: PortableTextBlock[];
};

export const testimonialRecord = record<Testimonial>({
  sanitySchema: () =>
    defineType({
      name: 'testimonial',
      type: 'document',
      title: 'Testimonial',
      icon: IconQuote,
      fields: [
        {
          name: 'name',
          title: 'Name',
          type: 'string',
          validation: (Rule) => Rule.required(),
        },
        {
          ...inlineRichText,
          name: 'title',
          title: 'Title',
        },
        {
          name: 'quote',
          title: 'Quote',
          ...inlineRichText,
          validation: (Rule) => Rule.required(),
        },
        {
          ...mediaField,
          name: 'profilePicture',
          title: 'Profile Picture',
          validation: (Rule) => Rule.required(),
        },
      ],
      preview: {
        select: {
          title: 'name',
          description: 'quote',
          media: 'profilePicture.image.asset',
        },
      },
    }),
  groqQueryPart: () => groq`
      name,
      title[]{${inlineRichTextQueryPart}},
      quote[]{${inlineRichTextQueryPart}},
      profilePicture->{${mediaRecord.getGroqQueryPart()}},
  `,
});
