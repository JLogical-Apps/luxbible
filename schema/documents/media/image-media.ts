import dynamic from 'next/dynamic';
import { defineType } from 'sanity';

import { ImageAsset } from '@/lib/types/image-asset';
import { MediaBase } from '@/schema/documents/media/media';
import { record } from '@/schema/sanity-type';

export interface ImageMedia extends MediaBase {
  _type: 'imageMedia';
  alt: string;
  asset: ImageAsset;
  mobileAsset?: ImageAsset;
  blurPlaceholder?: boolean;
}

export const imageMediaRecord = record({
  sanitySchema: () =>
    defineType({
      type: 'document',
      name: 'imageMedia',
      title: 'Image',
      icon: dynamic(() => import('@sanity/icons').then((mod) => mod.ImageIcon)),
      fields: [
        {
          name: 'image',
          type: 'image',
          title: 'Image',
          options: {
            hotspot: true,
            metadata: ['lqip'],
          },
        },
        {
          name: 'mobileImage',
          type: 'image',
          title: 'Mobile Image',
          description: 'Image to show on mobile devices',
          options: {
            hotspot: true,
            metadata: ['lqip'],
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
          validation: (Rule) => Rule.required().min(5),
        },
        {
          name: 'blurPlaceholder',
          type: 'boolean',
          title: 'Show Blur Placeholder?',
          description:
            'Whether to show a blurred placeholder while the image loads on slower networks.',
          initialValue: true,
        },
      ],
      preview: {
        select: {
          name: 'name',
          image: 'image.asset',
        },
        prepare: ({ name, image }) => {
          return {
            title: name,
            media: image,
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      alt,
      "asset": image.asset->,
      "mobileAsset": mobileImage.asset->,
      blurPlaceholder,
    `;
  },
});
