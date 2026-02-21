import { IconMail } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { FormActionBase } from '@/schema/objects/form-action/form-action';
import { record } from '@/schema/sanity-type';

export interface EmailFormAction extends FormActionBase {
  _type: 'emailFormAction';
  toAddress: string;
}

export const emailFormActionRecord = record({
  sanitySchema: () =>
    defineType({
      type: 'object',
      name: 'emailFormAction',
      title: 'Send Email',
      description: 'Send an email with the values the user typed in.',
      icon: IconMail,
      fields: [
        {
          type: 'email',
          name: 'toAddress',
          title: 'To Address',
          description: 'The email address to send the email to.',
          validation: (Rule) => Rule.required(),
        },
      ],
      preview: {
        select: {
          toAddress: 'toAddress',
        },
        prepare({ toAddress }) {
          return {
            title: 'Send Email',
            description: `To ${toAddress}`,
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      toAddress,
    `;
  },
});
