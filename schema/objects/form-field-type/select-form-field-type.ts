import { IconSelect } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { FormFieldTypeBase } from '@/schema/objects/form-field-type/form-field-type';
import { record } from '@/schema/sanity-type';

export interface SelectFormFieldType extends FormFieldTypeBase {
  _type: 'selectFormFieldType';
  options: string[];
  multiple?: boolean;
}

export const selectFormFieldTypeRecord = record({
  sanitySchema: () =>
    defineType({
      type: 'object',
      name: 'selectFormFieldType',
      title: 'Select',
      icon: IconSelect,
      fields: [
        {
          name: 'options',
          type: 'array',
          of: [{ type: 'string' }],
          title: 'Options',
        },
        {
          name: 'multiple',
          type: 'boolean',
          title: 'Select Multiple?',
          description: 'Whether the user can select more than one option.',
        },
      ],
    }),
  groqQueryPart(): string {
    return `
      options,
      multiple,
    `;
  },
});
