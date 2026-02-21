import { IconTableShare } from '@tabler/icons-react';
import { defineField, defineType } from 'sanity';

import { HasDesign, hasDesignMixin } from '@/schema/mixins/has-design';
import { IsElement, isElementMixin } from '@/schema/mixins/is-element';
import {
  getPageSectionRecord,
  PageSection,
  PageSectionBase,
} from '@/schema/objects/page-section/page-section';
import { record } from '@/schema/sanity-type';

export type SharedPageSectionWrapper = PageSectionBase &
  IsElement &
  HasDesign & {
    _type: 'sharedPageSectionWrapper';
    pageSection: PageSection;
  };

export const sharedPageSectionWrapperRecord = record({
  mixins: [isElementMixin, hasDesignMixin],
  sanitySchema: () =>
    defineType({
      name: 'sharedPageSectionWrapper',
      type: 'object',
      title: 'Shared Page Section',
      icon: IconTableShare,
      fields: [
        defineField({
          name: 'sharedPageSection',
          type: 'reference',
          to: [
            {
              type: 'sharedPageSection',
            },
          ],
          title: 'Shared Page Section',
        }),
      ],
      preview: {
        select: {
          title: 'sharedPageSection.pageSection.0.title',
        },
      },
    }),
  groqQueryPart(): string {
    return `
      "pageSection": sharedPageSection->pageSection[0]{${getPageSectionRecord({
        includeShared: false,
      }).getGroqQueryPart()}},
    `;
  },
});
