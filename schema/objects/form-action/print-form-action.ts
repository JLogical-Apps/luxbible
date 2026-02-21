import { IconBug } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { FormActionBase } from '@/schema/objects/form-action/form-action';
import { record } from '@/schema/sanity-type';

export interface PrintFormAction extends FormActionBase {
  _type: 'printFormAction';
}

export const printFormActionRecord = record({
  sanitySchema: () =>
    defineType({
      type: 'object',
      name: 'printFormAction',
      title: 'Debug Print',
      description: 'Used for debugging.',
      icon: IconBug,
      fields: [],
      preview: {
        prepare() {
          return {
            title: 'Debug Print',
          };
        },
      },
    }),
  groqQueryPart(): string {
    return ``;
  },
});
