import { IconApps } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { getPageBlockRecord } from '@/schema/documents/page-block/page-block';
import { record } from '@/schema/sanity-type';

export const sharedPageBlockRecord = record({
  sanitySchema: () =>
    defineType({
      type: 'document',
      title: 'Shared Page Block',
      name: 'sharedPageBlock',
      icon: IconApps,
      fields: [
        {
          name: 'internalName',
          type: 'string',
          title: 'Internal Name',
        },
        {
          name: 'pageBlock',
          type: 'array',
          of: getPageBlockRecord({ includeShared: false }).typeOption,
          options: {
            single: true,
          },
        },
      ],
      preview: {
        select: {
          title: 'internalName',
        },
      },
    }),
  groqQueryPart(): string {
    return ``;
  },
});
