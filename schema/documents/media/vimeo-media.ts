import { IconBrandVimeo, IconBrandYoutube } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { record } from '@/schema/sanity-type';

export interface VimeoMedia {
  _type: 'vimeoMedia';
  vimeoId: string;
  alt: string;
  aspectRatio?: string;
}

export const vimeoMediaRecord = record({
  sanitySchema: () =>
    defineType({
      type: 'document',
      name: 'vimeoMedia',
      title: 'Vimeo Video',
      icon: IconBrandVimeo,
      fields: [
        {
          name: 'vimeoId',
          type: 'string',
          title: 'Vimeo Video ID',
          description:
            'Obtained by grabbing the parameter from `https://player.vimeo.com/video/{VIMDEO_VIDEO_ID}`',
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
      vimeoId,
      alt,
      aspectRatio,
    `;
  },
});
