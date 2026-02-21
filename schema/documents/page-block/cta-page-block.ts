import { IconClick } from '@tabler/icons-react';
import { defineField, defineType } from 'sanity';

import { convertToShared } from '@/sanity/plugins/convert-to-shared';
import { PageBlockBase } from '@/schema/documents/page-block/page-block';
import { isElementMixin } from '@/schema/mixins/is-element';
import { Cta, ctaRecord } from '@/schema/objects/cta';
import { record } from '@/schema/sanity-type';

export interface CtaPageBlock extends PageBlockBase {
  _type: 'ctaPageBlock';
  ctas: Cta[];
}

export const ctaPageBlockRecord = record({
  mixins: [isElementMixin],
  sanitySchema: () =>
    defineType({
      name: 'ctaPageBlock',
      title: 'CTAs',
      type: 'object',
      icon: IconClick,
      fields: [
        convertToShared({
          type: 'sharedPageBlock',
          innerField: 'pageBlock',
        }),
        defineField({
          type: 'array',
          name: 'ctas',
          title: 'CTAs',
          of: [{ type: 'cta' }],
        }),
      ],
      preview: {
        prepare() {
          return {
            title: 'CTAs',
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      ctas[]{${ctaRecord.getGroqQueryPart()}},
    `;
  },
});
