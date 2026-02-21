import { IconArticle } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { convertToShared } from '@/sanity/plugins/convert-to-shared';
import { PageBlockBase } from '@/schema/documents/page-block/page-block';
import {
  Linkable,
  linkableImplementations,
  linkableTypes,
} from '@/schema/interfaces/linkable';
import { isElementMixin } from '@/schema/mixins/is-element';
import { getInterfaceQuery } from '@/schema/sanity-interface';
import { record } from '@/schema/sanity-type';

export interface BlogPostsPageBlock extends PageBlockBase {
  _type: 'blogPostsPageBlock';
  amount?: number;
  showAllPage?: Linkable;
}

export const blogPostsPageBlockRecord = record({
  mixins: [isElementMixin],
  sanitySchema: () =>
    defineType({
      name: 'blogPostsPageBlock',
      title: 'Blog Posts',
      type: 'object',
      icon: IconArticle,
      fields: [
        convertToShared({
          type: 'sharedPageBlock',
          innerField: 'pageBlock',
        }),
        {
          name: 'amount',
          type: 'number',
          title: 'Amount',
          description:
            'Amount of blog posts to show. If left blank, will show all of them.',
        },
        {
          name: 'showAllPage',
          type: 'reference',
          to: linkableTypes,
          title: 'Show All Page',
          description: 'Page to show all blog posts at.',
        },
      ],
      preview: {
        prepare() {
          return {
            title: 'Blog Posts',
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      amount,
      showAllPage->{${getInterfaceQuery(linkableImplementations)}},
    `;
  },
});
