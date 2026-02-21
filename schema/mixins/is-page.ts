import {
  ColorPalette,
  colorPaletteRecord,
} from '@/schema/documents/design/color-palette';
import { contentField } from '@/schema/fields/content-field';
import { HasSeo, hasSeoMixin } from '@/schema/mixins/has-seo';
import {
  getPageSectionRecord,
  PageSection,
} from '@/schema/objects/page-section/page-section';
import { SanityMixin } from '@/schema/sanity-mixin';

export type IsPage = HasSeo & {
  content: PageSection[];
  colorPalette?: ColorPalette;
};

export function isPageMixin({
  withPath = true,
}: {
  withPath?: boolean;
} = {}): SanityMixin {
  return {
    mixins: [hasSeoMixin],
    groups: [
      {
        name: 'page',
        title: 'Page',
      },
    ],
    fields: [
      ...(withPath
        ? [
            {
              type: 'string',
              name: 'name',
              title: 'Name',
              description:
                'Name of the page. Used for the navigation bar and URL.',
              group: 'page',
            },
            {
              type: 'slug',
              name: 'slug',
              title: 'Slug',
              description:
                'The unique identifier for the page and used for the URL.',
              group: 'page',
              options: {
                source: 'name',
              },
              validation: (Rule) => Rule.required(),
            },
          ]
        : []),
      {
        ...contentField,
        name: 'content',
        title: 'Content',
        group: 'page',
      },
      {
        name: 'colorPalette',
        type: 'reference',
        to: colorPaletteRecord.typeOption,
        title: 'Color Palette',
      },
    ],
    groqQueryPart: `
      content[]{${getPageSectionRecord().getGroqQueryPart()}},
      colorPalette->{${colorPaletteRecord.getGroqQueryPart()}},
    `,
  };
}
