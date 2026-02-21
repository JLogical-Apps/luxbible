import { defineType } from 'sanity';

import {
  Linkable,
  linkableImplementations,
  linkableTypes,
} from '@/schema/interfaces/linkable';
import { getInterfaceQuery } from '@/schema/sanity-interface';
import { record } from '@/schema/sanity-type';

export type MenuItem = {
  linkable: Linkable;
  children?: Linkable[];
};

export const menuItemRecord = record<MenuItem>({
  sanitySchema: () =>
    defineType({
      name: 'menuItem',
      type: 'object',
      title: 'Menu Item',
      fields: [
        {
          name: 'linkable',
          title: 'Item',
          description:
            'The main item of the menu item. Will always be displayed.',
          type: 'reference',
          to: linkableTypes,
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'children',
          title: 'Children',
          description:
            'The children of this menu item. They will be expanded and selectable in desktop mode.',
          type: 'array',
          of: [
            {
              type: 'reference',
              to: linkableTypes,
            },
          ],
        },
      ],
      preview: {
        select: {
          title: 'linkable.name',
        },
      },
    }),
  groqQueryPart: () => `
    linkable->{${getInterfaceQuery(linkableImplementations)}},
    children[]->{${getInterfaceQuery(linkableImplementations)}},
  `,
});
