import { IconBrandYoutube } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { record } from '@/schema/sanity-type';

export interface YouTubeMedia {
  _type: 'youtubeMedia';
  youtubeId: string;
  alt: string;
  aspectRatio?: string;
}

export const youtubeMediaRecord = record<YouTubeMedia>({
  sanitySchema: () =>
    defineType({
      type: 'document',
      name: 'youtubeMedia',
      title: 'YouTube Video',
      icon: IconBrandYoutube,
      fields: [
        {
          name: 'youtubeId',
          type: 'string',
          title: 'YouTube Video ID',
          description:
            'Obtained by grabbing the `v` parameter from `https://www.youtube.com/watch?v={YOUTUBE_VIDEO_ID}`',
          validation: (Rule) => Rule.required(),
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
          title: 'Alt Text',
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
          youtubeId,
          alt,
          aspectRatio,
        `;
  },
});
