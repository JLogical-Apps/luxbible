import { defineType } from 'sanity';

import { linkableImplementations } from '@/schema/interfaces/linkable';
import {
  Background,
  backgroundRecord,
} from '@/schema/objects/background/background-record';
import {
  getPageSectionRecord,
  PageSection,
} from '@/schema/objects/page-section/page-section';
import { record } from '@/schema/sanity-type';

export type PageOverride = {
  pageType: string;
  sectionBackgrounds: {
    sectionName: string;
    background: Background;
  }[];
  bottomSections: PageSection[];
};

export const pageOverrideRecord = record<PageOverride>({
  sanitySchema: () =>
    defineType({
      name: 'pageOverride',
      type: 'object',
      title: 'Page Override',
      fields: [
        {
          name: 'pageType',
          title: 'Page Type',
          type: 'string',
          options: {
            list: linkableImplementations.map((impl) => impl.type),
          },
        },
        {
          name: 'sectionBackgrounds',
          type: 'array',
          title: 'Section Backgrounds',
          description:
            'Override the backgrounds of sections based on their names.',
          of: [
            {
              type: 'object',
              fields: [
                {
                  type: 'string',
                  name: 'sectionName',
                  title: 'Section Name',
                  validation: (Rule) => Rule.required(),
                },
                {
                  name: 'background',
                  title: 'Background',
                  type: 'array',
                  of: backgroundRecord.typeOption,
                  options: {
                    single: true,
                  },
                  validation: (Rule) => Rule.required(),
                },
              ],
            },
          ],
        },
        {
          name: 'bottomSections',
          type: 'array',
          of: getPageSectionRecord().typeOption,
          title: 'Bottom Sections',
          description: 'Sections to show at the bottom of this page type.',
        },
      ],
    }),
  groqQueryPart: () => `
    pageType,
    sectionBackgrounds[]{sectionName,background[0]{${backgroundRecord.getGroqQueryPart()}}},
    bottomSections[]{${getPageSectionRecord().getGroqQueryPart()}},
  `,
});

export function getPageOverrideFromType({
  pageOverrides = [],
  pageType,
}: {
  pageOverrides?: PageOverride[];
  pageType: string;
}) {
  return pageOverrides?.find(
    (pageOverride) => pageOverride.pageType === pageType,
  );
}

export function getSectionBackgrounds(pageOverride: PageOverride | undefined) {
  if (!pageOverride) {
    return new Map<string, Background>();
  }

  return pageOverride?.sectionBackgrounds.reduce(function (map, obj) {
    map[obj.sectionName] = obj.background;
    return map;
  }, {});
}
