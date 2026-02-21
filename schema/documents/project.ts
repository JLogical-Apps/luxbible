import { PortableTextBlock } from '@portabletext/types';
import { IconRectangularPrism } from '@tabler/icons-react';
import { defineType } from 'sanity';

import {
  ImageMedia,
  imageMediaRecord,
} from '@/schema/documents/media/image-media';
import { mediaRecord } from '@/schema/documents/media/media';
import { Testimonial, testimonialRecord } from '@/schema/documents/testimonial';
import { HasSeo, hasSeoMixin } from '@/schema/mixins/has-seo';
import {
  bodyRichText,
  bodyRichTextQueryPart,
} from '@/schema/richtext/body-rich-text';
import { inlineRichText } from '@/schema/richtext/inline-rich-text';
import { record } from '@/schema/sanity-type';

export type Project = HasSeo & {
  _type: 'project';
  name: string;
  slug: string;
  thumbnail: ImageMedia;
  link: string;
  description: PortableTextBlock[];
  insights: PortableTextBlock[];
  testimonial?: Testimonial;
};

export const projectRecord = record<Project>({
  mixins: [hasSeoMixin],
  sanitySchema: () =>
    defineType({
      type: 'document',
      name: 'project',
      title: 'Project',
      icon: IconRectangularPrism,
      fields: [
        {
          type: 'string',
          name: 'name',
          title: 'Name',
        },
        {
          type: 'slug',
          name: 'slug',
          title: 'Slug',
          description:
            'The unique identifier for the project and used for the URL.',
          options: {
            source: 'name',
          },
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'thumbnail',
          title: 'Thumbnail',
          type: 'reference',
          to: imageMediaRecord.typeOption,
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'link',
          type: 'string',
          title: 'Link',
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'description',
          title: 'Description',
          ...inlineRichText,
        },
        {
          name: 'insights',
          title: 'Insights',
          ...bodyRichText,
        },
        {
          name: 'testimonial',
          title: 'Testimonial',
          type: 'reference',
          to: testimonialRecord.typeOption,
        },
      ],
      preview: {
        select: {
          name: 'name',
          thumbnail: 'thumbnail.image.asset',
        },
        prepare({ name, thumbnail }) {
          return {
            title: name,
            subtitle: 'Project',
            media: thumbnail,
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      name,
      "slug": slug.current,
      thumbnail->{${mediaRecord.getGroqQueryPart()}},
      link,
      description[]{${bodyRichTextQueryPart}},
      insights[]{${bodyRichTextQueryPart}},
      testimonial->{${testimonialRecord.getGroqQueryPart()}},
    `;
  },
});
