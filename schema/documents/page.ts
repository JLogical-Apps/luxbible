import dynamic from 'next/dynamic';
import { defineType } from 'sanity';

import { IsPage, isPageMixin } from '@/schema/mixins/is-page';
import { record } from '@/schema/sanity-type';

export type Page = IsPage & {
  _type: 'page';
  name: string;
  slug: string;
  parent?: Page;
};

export const pageRecord = record<Page>({
  mixins: [isPageMixin()],
  sanitySchema: () =>
    defineType({
      type: 'document',
      name: 'page',
      title: 'Page',
      icon: dynamic(() =>
        import('@sanity/icons').then((mod) => mod.DocumentIcon),
      ),
      fields: [
        {
          type: 'reference',
          to: { type: 'page' },
          name: 'parent',
          title: 'Parent',
          description: 'Page this page lives under.',
        },
      ],
      preview: {
        select: {
          name: 'name',
          parentName: 'parent.name',
        },
        prepare({ name, parentName }) {
          return {
            title: [parentName, name].filter((e) => e).join(' - '),
            subtitle: 'Page',
          };
        },
      },
    }),
  groqQueryPart(): string {
    return getPageGroqQueryPart(true);
  },
});

function getPageGroqQueryPart(includeReferences: boolean = false) {
  return `
    name,
    "slug": slug.current,
    ${
      includeReferences
        ? `
          parent->{${getPageGroqQueryPart(false)}},
        `
        : ``
    }
  `;
}
