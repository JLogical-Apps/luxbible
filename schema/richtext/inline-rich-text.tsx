import dynamic from 'next/dynamic';
import { BlockDecoratorProps, defineArrayMember } from 'sanity';

import { actionRecord } from '@/schema/objects/action/action';

export const inlineRichText = {
  type: 'array',
  of: [
    defineArrayMember({
      lists: [],
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
          {
            title: 'Gradient',
            value: 'gradient',
            icon: dynamic(() =>
              import('@sanity/icons').then((mod) => mod.ColorWheelIcon),
            ),
            component: (props: BlockDecoratorProps) => (
              <span style={{ color: 'goldenrod' }}>{props.children}</span>
            ),
          },
        ],
      },
      styles: [],
      type: 'block',
    }),
  ],
};

export const inlineRichTextQueryPart = `
  ...,
  markDefs[]{
    ...,
    _type == "link" => {
      action[]{${actionRecord.getGroqQueryPart()}},
    },
  },
`;
