import { IconTextSize } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { textFormFieldTypeOptions } from '@/lib/form/form-field-types';
import { FormFieldTypeBase } from '@/schema/objects/form-field-type/form-field-type';
import { record } from '@/schema/sanity-type';

export interface TextFormFieldType extends FormFieldTypeBase {
  _type: 'textFormFieldType';
  type?: string;
  placeholder?: string;
}

export const textFormFieldTypeRecord = record({
  sanitySchema: () =>
    defineType({
      type: 'object',
      name: 'textFormFieldType',
      title: 'Text',
      icon: IconTextSize,
      fields: [
        {
          name: 'type',
          type: 'string',
          title: 'Type',
          options: {
            list: textFormFieldTypeOptions,
          },
        },
        {
          name: 'placeholder',
          type: 'string',
          title: 'Placeholder',
        },
      ],
      preview: {
        select: {
          type: 'type',
        },
        prepare({ type }) {
          return {
            title: 'Text',
            subtitle: type,
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      type,
      placeholder,
    `;
  },
});
