import { IconForms } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { convertToShared } from '@/sanity/plugins/convert-to-shared';
import { Form, formRecord } from '@/schema/documents/form';
import { PageBlockBase } from '@/schema/documents/page-block/page-block';
import { isElementMixin } from '@/schema/mixins/is-element';
import { record } from '@/schema/sanity-type';

export interface FormPageBlock extends PageBlockBase {
  _type: 'formPageBlock';
  form: Form;
}

export const formPageBlockRecord = record({
  mixins: [isElementMixin],
  sanitySchema: () =>
    defineType({
      name: 'formPageBlock',
      title: 'Form',
      type: 'object',
      icon: IconForms,
      fields: [
        convertToShared({
          type: 'sharedPageBlock',
          innerField: 'pageBlock',
        }),
        {
          type: 'reference',
          name: 'form',
          title: 'Form',
          to: formRecord.typeOption,
        },
      ],
      preview: {
        prepare() {
          return {
            title: 'Form',
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      form->{${formRecord.getGroqQueryPart()}},
    `;
  },
});
