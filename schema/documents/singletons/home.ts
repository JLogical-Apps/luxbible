import dynamic from 'next/dynamic';
import { defineType } from 'sanity';

import { IsPage, isPageMixin } from '@/schema/mixins/is-page';
import { record } from '@/schema/sanity-type';

export type HomePage = IsPage & {
  _type: 'home';
};

export const homePageRecord = record<HomePage>({
  mixins: [isPageMixin({ withPath: false })],
  sanitySchema: () =>
    defineType({
      type: 'document',
      name: 'home',
      title: 'Home',
      icon: dynamic(() => import('@sanity/icons').then((mod) => mod.HomeIcon)),
      fields: [],
      preview: {
        prepare: () => ({
          title: 'Homepage',
        }),
      },
    }),
  groqQueryPart(): string {
    return ``;
  },
});
