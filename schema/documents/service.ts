import { PortableTextBlock } from '@portabletext/types';
import { IconHammer } from '@tabler/icons-react';
import { defineType } from 'sanity';

import {
  ImageMedia,
  imageMediaRecord,
} from '@/schema/documents/media/image-media';
import { mediaRecord } from '@/schema/documents/media/media';
import { Project, projectRecord } from '@/schema/documents/project';
import { HasSeo, hasSeoMixin } from '@/schema/mixins/has-seo';
import { Feature, featureRecord } from '@/schema/objects/feature';
import {
  inlineRichText,
  inlineRichTextQueryPart,
} from '@/schema/richtext/inline-rich-text';
import { record } from '@/schema/sanity-type';

export type Service = HasSeo & {
  _type: 'service';
  name: string;
  slug: string;
  thumbnail: ImageMedia;
  description: PortableTextBlock[];
  features: Feature[];
  successStories: Project[];
};

export const serviceRecord = record<Service>({
  mixins: [hasSeoMixin],
  sanitySchema: () =>
    defineType({
      type: 'document',
      name: 'service',
      title: 'Service',
      icon: IconHammer,
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
          name: 'features',
          title: 'Features',
          type: 'array',
          of: featureRecord.typeOption,
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
            subtitle: 'Service',
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
      features[]{${featureRecord.getGroqQueryPart()}},
      successStories[]->{${projectRecord.getGroqQueryPart()}},
    `;
  },
});
