import { PortableTextBlock } from '@portabletext/types';
import { IconPackage } from '@tabler/icons-react';
import { defineType } from 'sanity';

import {
  ImageMedia,
  imageMediaRecord,
} from '@/schema/documents/media/image-media';
import { mediaRecord } from '@/schema/documents/media/media';
import { Project, projectRecord } from '@/schema/documents/project';
import { Service, serviceRecord } from '@/schema/documents/service';
import { HasSeo, hasSeoMixin } from '@/schema/mixins/has-seo';
import { Faq, faqRecord } from '@/schema/objects/faq';
import {
  inlineRichText,
  inlineRichTextQueryPart,
} from '@/schema/richtext/inline-rich-text';
import { record } from '@/schema/sanity-type';

export type Solution = HasSeo & {
  _type: 'solution';
  name: string;
  slug: string;
  thumbnail: ImageMedia;
  description: PortableTextBlock[];
  servicesDescription: PortableTextBlock[];
  services?: Service[];
  faqs?: Faq[];
  successStories?: Project[];
};

export const solutionRecord = record<Solution>({
  mixins: [hasSeoMixin],
  sanitySchema: () =>
    defineType({
      type: 'document',
      name: 'solution',
      title: 'Solution',
      icon: IconPackage,
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
          name: 'description',
          title: 'Description',
          ...inlineRichText,
        },
        {
          name: 'servicesDescription',
          title: 'Services Description',
          description: 'The description that goes in the services section.',
          ...inlineRichText,
        },
        {
          name: 'services',
          title: 'Services',
          type: 'array',
          of: serviceRecord.referenceTypeOption,
        },
        {
          name: 'faqs',
          title: 'FAQs',
          type: 'array',
          of: faqRecord.typeOption,
        },
        {
          name: 'successStories',
          title: 'Success Stories',
          type: 'array',
          of: projectRecord.referenceTypeOption,
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
            subtitle: 'Solution',
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
      description[]{${inlineRichTextQueryPart}},
      servicesDescription[]{${inlineRichTextQueryPart}},
      services[]->{${serviceRecord.getGroqQueryPart()}},
      faqs[]{${faqRecord.getGroqQueryPart()}},
      successStories[]->{${projectRecord.getGroqQueryPart()}},
    `;
  },
});
