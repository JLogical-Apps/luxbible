import {
  Background,
  backgroundRecord,
} from '@/schema/objects/background/background-record';
import { SanityMixin } from '@/schema/sanity-mixin';

export type HasDesign = {
  background?: Background;
};

export const hasDesignMixin: SanityMixin = {
  groups: [
    {
      name: 'design',
      title: 'Design',
    },
  ],
  fields: [
    {
      type: 'array',
      name: 'background',
      title: 'Background',
      group: 'design',
      of: backgroundRecord.typeOption,
      options: {
        single: true,
      },
    },
  ],
  groqQueryPart: `
    background[0]{${backgroundRecord.getGroqQueryPart()}}
  `,
};
