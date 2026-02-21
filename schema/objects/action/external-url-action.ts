import { IconExternalLink } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { ActionBase } from '@/schema/objects/action/action';
import { record } from '@/schema/sanity-type';

export interface ExternalUrlAction extends ActionBase {
  _type: 'externalUrlAction';
  url: string;
  newTab?: boolean;
}

export const externalUrlActionRecord = record({
  sanitySchema: () =>
    defineType({
      type: 'object',
      name: 'externalUrlAction',
      title: 'External URL',
      description: 'Navigates to an external url.',
      icon: IconExternalLink,
      fields: [
        {
          name: 'url',
          type: 'url',
          title: 'External URL',
          description: 'The url to navigate to.',
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'newTab',
          type: 'boolean',
          title: 'Open in New Tab?',
        },
      ],
      preview: {
        select: {
          url: 'url',
        },
        prepare({ url }) {
          return {
            title: 'External URL',
            description: url,
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      url,
      newTab,
    `;
  },
});
