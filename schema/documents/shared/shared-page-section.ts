import { IconLayout } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { getPageSectionRecord } from '@/schema/objects/page-section/page-section';
import { record } from '@/schema/sanity-type';

export const sharedPageSectionRecord = record({
  sanitySchema: () =>
    defineType({
      type: 'document',
      title: 'Shared Page Section',
      name: 'sharedPageSection',
      icon: IconLayout,
      fields: [
        {
          name: 'pageSection',
          type: 'array',
          of: getPageSectionRecord({ includeShared: false }).typeOption,
          options: {
            single: true,
          },
        },
      ],
      preview: {
        select: {
          title: 'pageSection.0.title',
        },
      },
    }),
  groqQueryPart(): string {
    return ``;
  },
});
