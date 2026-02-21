import dynamic from 'next/dynamic';
import { defineArrayMember } from 'sanity';

import { mediaRecord } from '@/schema/documents/media/media';
import { actionRecord } from '@/schema/objects/action/action';

export const bodyRichText = {
  type: 'array',
  of: [
    defineArrayMember({
      styles: [
        { title: 'Normal', value: 'normal' },
        { title: 'Page Title', value: 'h1' },
        { title: 'Section Title', value: 'h2' },
        { title: 'Subheader', value: 'h3' },
        { title: 'Tiny Header', value: 'h4' },
        { title: 'Quote', value: 'blockquote' },
      ],
      lists: [
        { title: 'Bullet', value: 'bullet' },
        { title: 'Numbered', value: 'number' },
      ],
      marks: {
        annotations: [
          {
            name: 'link',
            type: 'object',
            title: 'Link',
            fields: [
              {
                type: 'array',
                name: 'action',
                title: 'Action',
                of: actionRecord.typeOption,
                options: {
                  single: true,
                },
              },
            ],
          },
        ],
        decorators: [
          {
            title: 'Italic',
            value: 'em',
          },
          {
            title: 'Strong',
            value: 'strong',
          },
          { title: 'Code', value: 'code' },
          { title: 'Underline', value: 'underline' },
          { title: 'Strike', value: 'strike-through' },
        ],
      },
      type: 'block',
    }),
    {
      type: 'object',
      name: 'media',
      title: 'Media',
      icon: dynamic(() => import('@sanity/icons').then((mod) => mod.ImageIcon)),
      fields: [
        {
          name: 'media',
          title: 'Media',
          type: 'reference',
          to: mediaRecord.typeOption,
        },
      ],
      preview: {
        select: {
          title: 'media.name',
          media: 'media.image.asset',
        },
      },
    },
  ],
};

export const bodyRichTextQueryPart = `
  _type,
  _type == "block" => {...},
  _type == "media" => @.media->{${mediaRecord.getGroqQueryPart()}},
  markDefs[]{
    ...,
    _type == "link" => {
      action[]{${actionRecord.getGroqQueryPart()}},
    },
  },

`;
