import { IconVideo } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { record } from '@/schema/sanity-type';

export interface VideoMedia {
  _type: 'videoMedia';
  url: string;
  alt: string;
  aspectRatio?: string;
}

export const videoMediaRecord = record<VideoMedia>({
  sanitySchema: () =>
    defineType({
      type: 'document',
      name: 'videoMedia',
      title: 'Video File',
      icon: IconVideo,
      fields: [
        {
          name: 'file',
          type: 'file',
          title: 'Video File',
          validation: (Rule) => Rule.required(),
          options: {
            accept: 'video/webm',
          },
        },
        {
          name: 'name',
          type: 'string',
          title: 'Name',
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'alt',
          type: 'string',
          title: 'Alt',
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'aspectRatio',
          type: 'string',
          title: 'Aspect Ratio',
          description: 'Defaults to 16/9',
        },
      ],
      preview: {
        select: {
          name: 'name',
        },
        prepare: ({ name }) => {
          return {
            title: name,
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      "url": file.asset->url,
      alt,
      aspectRatio,
    `;
  },
});
