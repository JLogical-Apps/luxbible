import { IconForms } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { convertToShared } from '@/sanity/plugins/convert-to-shared';
import { InlineForm, inlineFormRecord } from '@/schema/documents/inline-form';
import { PageBlockBase } from '@/schema/documents/page-block/page-block';
import { isElementMixin } from '@/schema/mixins/is-element';
import { record } from '@/schema/sanity-type';

export interface InlineFormPageBlock extends PageBlockBase {
  _type: 'inlineFormPageBlock';
  inlineForm: InlineForm;
}

export const inlineFormPageBlockRecord = record({
  mixins: [isElementMixin],
  sanitySchema: () =>
    defineType({
      name: 'inlineFormPageBlock',
      title: 'Inline Form',
      type: 'object',
      icon: IconForms,
      fields: [
        convertToShared({
          type: 'sharedPageBlock',
          innerField: 'pageBlock'
        }),
        {
          type: 'reference',
          name: 'inlineForm',
          title: 'Form',
          to: inlineFormRecord.typeOption
        }
      ],
      preview: {
        prepare() {
          return {
            title: 'Inline Form'
          };
        }
      }
    }),
  groqQueryPart(): string {
    return `
      inlineForm->{${inlineFormRecord.getGroqQueryPart()}},
    `;
  }
});
