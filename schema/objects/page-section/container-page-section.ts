import { PortableTextBlock } from '@portabletext/types';
import { IconContainer } from '@tabler/icons-react';
import { defineField, defineType } from 'sanity';

import { convertToShared } from '@/sanity/plugins/convert-to-shared';
import {
  getPageBlockRecord,
  PageBlock,
} from '@/schema/documents/page-block/page-block';
import { Alignment, alignmentField } from '@/schema/fields/alignment-field';
import { Size, sizeField } from '@/schema/fields/size-field';
import { HasDesign, hasDesignMixin } from '@/schema/mixins/has-design';
import { IsElement, isElementMixin } from '@/schema/mixins/is-element';
import {
  Background,
  backgroundRecord,
} from '@/schema/objects/background/background-record';
import { PageSectionBase } from '@/schema/objects/page-section/page-section';
import {
  bodyRichText,
  bodyRichTextQueryPart,
} from '@/schema/richtext/body-rich-text';
import {
  inlineRichText,
  inlineRichTextQueryPart,
} from '@/schema/richtext/inline-rich-text';
import { record } from '@/schema/sanity-type';

export type ContainerPageSection = PageSectionBase & {
  _type: 'containerPageSection';
  title?: PortableTextBlock[] | string;
  subtitle?: PortableTextBlock[] | string;
  tagline?: PortableTextBlock[] | string;
  body?: PortableTextBlock[] | string;
  blocks?: PageBlock[];
  alignment?: Alignment;
  smallAlignment?: Alignment;
  titleSize?: Size;
  containerBackground?: Background;
} & IsElement &
  HasDesign;

export const containerPageSectionRecord = record({
  mixins: [isElementMixin, hasDesignMixin],
  sanitySchema: () =>
    defineType({
      type: 'object',
      name: 'containerPageSection',
      title: 'Container',
      icon: IconContainer,
      fields: [
        convertToShared({
          type: 'sharedPageSection',
          innerField: 'pageSection',
        }),
        defineField({
          name: 'title',
          title: 'Title',
          ...inlineRichText,
        }),
        defineField({
          name: 'subtitle',
          title: 'Subtitle',
          ...inlineRichText,
        }),
        defineField({
          name: 'tagline',
          title: 'Tagline',
          ...inlineRichText,
        }),
        defineField({
          name: 'body',
          title: 'Body',
          ...bodyRichText,
        }),
        {
          name: 'blocks',
          title: 'Blocks',
          type: 'array',
          of: getPageBlockRecord().typeOption,
        },
        {
          name: 'alignment',
          title: 'Alignment',
          description: 'Alignment to use when the screen is large (desktop).',
          ...alignmentField,
        },
        {
          name: 'smallAlignment',
          title: 'Small Alignment',
          description: 'Alignment to use when the screen is small (mobile).',
          ...alignmentField,
        },
        {
          name: 'titleSize',
          title: 'Title Size',
          description: 'The size of the title.',
          ...sizeField,
        },
        {
          type: 'array',
          name: 'containerBackground',
          title: 'Container Background',
          group: 'design',
          of: backgroundRecord.typeOption,
          options: {
            single: true,
          },
        },
      ],
    }),
  groqQueryPart(): string {
    return `
      title[]{${inlineRichTextQueryPart}},
      subtitle[]{${inlineRichTextQueryPart}},
      tagline[]{${inlineRichTextQueryPart}},
      body[]{${bodyRichTextQueryPart}},
      blocks[]{${getPageBlockRecord().getGroqQueryPart()}},
      alignment,
      smallAlignment,
      titleSize,
      containerBackground[0]{${backgroundRecord.getGroqQueryPart()}},
    `;
  },
});
