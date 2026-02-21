import { PortableTextBlock } from '@portabletext/types';
import { IconForms } from '@tabler/icons-react';
import { defineType } from 'sanity';

import {
  FormAction,
  formActionRecord,
} from '@/schema/objects/form-action/form-action';
import { FormField, formFieldRecord } from '@/schema/objects/form-field';
import {
  bodyRichText,
  bodyRichTextQueryPart,
} from '@/schema/richtext/body-rich-text';
import { record } from '@/schema/sanity-type';

export type InlineForm = {
  _id: string;
  name: string;
  formField: FormField;
  showRequiredIndicator?: boolean;
  recaptcha: boolean;
  submitButtonText: string;
  successMessage: PortableTextBlock[];
  formActions: FormAction[];
};

export const inlineFormRecord = record<InlineForm>({
  sanitySchema: () =>
    defineType({
      name: 'inlineForm',
      type: 'document',
      title: 'Inline Form',
      icon: IconForms,
      fields: [
        {
          type: 'string',
          name: 'name',
          title: 'Form Name',
          description: 'Name used to identify the form.',
          validation: (Rule) => Rule.required(),
        },
        {
          type: 'array',
          name: 'formField',
          title: 'Field',
          of: formFieldRecord.typeOption,
          validation: (Rule) => Rule.required(),
          options: {
            single: true,
          },
        },
        {
          type: 'boolean',
          name: 'showRequiredIndicator',
          title: 'Show Required Indicator?',
          description:
            'Whether to show the asterisks symbol next to required fields.',
          initialValue: true,
        },
        {
          type: 'boolean',
          name: 'recaptcha',
          title: 'Protect with Recaptcha?',
          description:
            'Forces users to pass a Recaptcha in order to submit the form.',
          initialValue: true,
        },
        {
          type: 'array',
          name: 'formActions',
          title: 'Actions',
          description: 'Actions to complete once the user submits the data.',
          of: formActionRecord.typeOption,
          validation: (Rule) => Rule.required(),
        },
        {
          type: 'string',
          name: 'submitButtonText',
          title: 'Submit Button Text',
          validation: (Rule) => Rule.required(),
        },
        {
          ...bodyRichText,
          name: 'successMessage',
          title: 'Success Message',
          validation: (Rule) => Rule.required(),
        },
      ],
    }),
  groqQueryPart(): string {
    return `
      _id,
      name,
      formField[0]{${formFieldRecord.getGroqQueryPart()}},
      showRequiredIndicator,
      recaptcha,
      submitButtonText,
      successMessage[]{${bodyRichTextQueryPart}},
      formActions[]{${formActionRecord.getGroqQueryPart()}},
    `;
  },
});
