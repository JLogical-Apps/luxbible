import { IconStar } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { ActionBase } from '@/schema/objects/action/action';
import { record } from '@/schema/sanity-type';

export interface IdAction extends ActionBase {
  _type: 'idAction';
  id: string;
}

export const idActionRecord = record({
  sanitySchema: () =>
    defineType({
      type: 'object',
      name: 'idAction',
      title: 'Go to ID',
      description: 'Navigates to a page section with a specific ID',
      icon: IconStar,
      fields: [
        {
          name: 'id',
          type: 'string',
          title: 'ID',
          description: 'The ID to navigate to.',
          validation: (Rule) => Rule.required(),
        },
      ],
      preview: {
        select: {
          id: 'id',
        },
        prepare({ id }) {
          return {
            title: 'Go to ID',
            description: id,
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      id,
    `;
  },
});
