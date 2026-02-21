import { SanityMixin } from '@/schema/sanity-mixin';

export interface IsElement {
  id?: string;
}

export const isElementMixin: SanityMixin = {
  groups: [
    {
      name: 'advanced',
      title: 'Advanced',
    },
  ],
  fields: [
    {
      type: 'string',
      name: 'id',
      title: 'ID',
      description: 'Used to reference this element on the page.',
      group: 'advanced',
    },
  ],
  groqQueryPart: `
    id,
  `,
};
