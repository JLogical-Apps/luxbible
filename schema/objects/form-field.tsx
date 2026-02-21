import { groq } from 'next-sanity';
import SVG from 'react-inlinesvg';
import { defineType } from 'sanity';

import { Icon, iconQueryPart } from '@/lib/types/icon';
import { iconField } from '@/schema/fields/icon-field';
import {
  FormFieldType,
  formFieldTypeRecord,
} from '@/schema/objects/form-field-type/form-field-type';
import { record } from '@/schema/sanity-type';

export type FormField = {
  name: string;
  title: string;
  description?: string;
  icon?: Icon;
  type: FormFieldType;
  required?: boolean;
};

export const formFieldRecord = record<FormField>({
  sanitySchema: () =>
    defineType({
      name: 'formField',
      type: 'object',
      title: 'Form Field',
      fields: [
        {
          name: 'name',
          title: 'Name',
          type: 'string',
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'title',
          title: 'Title',
          type: 'string',
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'description',
          title: 'Description',
          type: 'string',
        },
        {
          ...iconField,
          name: 'icon',
          title: 'Icon',
        },
        {
          name: 'type',
          title: 'Type',
          type: 'array',
          of: formFieldTypeRecord.typeOption,
          options: {
            single: true,
          },
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'required',
          type: 'boolean',
          title: 'Required',
        },
      ],
      preview: {
        select: {
          title: 'title',
          icon: 'icon.svg',
        },
        prepare({ title, icon }) {
          return {
            title: title,
            media: icon && (
              <SVG
                src={icon}
                style={{
                  width: '1em',
                  height: '1em',
                }}
              />
            ),
          };
        },
      },
    }),
  groqQueryPart: () => groq`
      name,
      title,
      description,
      icon{${iconQueryPart}},
      type[0]{${formFieldTypeRecord.getGroqQueryPart()}},
      required,
  `,
});
