import { IconLink } from '@tabler/icons-react';
import { defineType } from 'sanity';

import {
  Linkable,
  linkableImplementations,
  linkableTypes,
} from '@/schema/interfaces/linkable';
import { ActionBase } from '@/schema/objects/action/action';
import { getInterfaceQuery } from '@/schema/sanity-interface';
import { record } from '@/schema/sanity-type';

export interface InternalUrlAction extends ActionBase {
  _type: 'internalUrlAction';
  linkable: Linkable;
  id?: string;
  newTab?: boolean;
}

export const internalUrlActionRecord = record({
  sanitySchema: () =>
    defineType({
      type: 'object',
      name: 'internalUrlAction',
      title: 'Internal URL',
      description: 'Navigates to a page defined in your CMS.',
      icon: IconLink,
      fields: [
        {
          name: 'linkable',
          type: 'reference',
          title: 'Page',
          description: 'The page to navigate to.',
          to: linkableTypes,
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'id',
          type: 'string',
          title: 'ID',
          description: 'The ID to navigate to.',
        },
        {
          name: 'newTab',
          type: 'boolean',
          title: 'Open in New Tab?',
        },
      ],
      preview: {
        prepare() {
          return {
            title: 'Internal URL',
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      linkable->{${getInterfaceQuery(linkableImplementations)}},
      id,
      newTab,
    `;
  },
});
