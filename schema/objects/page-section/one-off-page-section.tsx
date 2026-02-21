import { PortableTextBlock } from '@portabletext/types';
import { IconLayoutList } from '@tabler/icons-react';
import { defineField, defineType } from 'sanity';

import { convertToShared } from '@/sanity/plugins/convert-to-shared';
import { Media, mediaRecord } from '@/schema/documents/media/media';
import {
  getPageBlockRecord,
  PageBlock,
} from '@/schema/documents/page-block/page-block';
import { Alignment, alignmentField } from '@/schema/fields/alignment-field';
import {
  MediaAlignment,
  mediaAlignmentField,
} from '@/schema/fields/media-alignment-field';
import { mediaField } from '@/schema/fields/media-field';
import { Size, sizeField } from '@/schema/fields/size-field';
import { HasDesign, hasDesignMixin } from '@/schema/mixins/has-design';
import { IsElement, isElementMixin } from '@/schema/mixins/is-element';
import { Cta, ctaRecord } from '@/schema/objects/cta';
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

export type OneOffPageSection = PageSectionBase & {
  _type: 'oneOffPageSection';
  title?: PortableTextBlock[] | string;
  subtitle?: PortableTextBlock[] | string;
  ctas?: Cta[];
  tagline?: PortableTextBlock[] | string;
  body?: PortableTextBlock[] | string;
  media?: Media;
  blocks?: PageBlock[];
  alignment?: Alignment;
  smallAlignment?: Alignment;
  mediaAlignment?: MediaAlignment;
  mediaSize?: Size;
  titleSize?: Size;
} & IsElement &
  HasDesign;

export const oneOffPageSectionRecord = record({
  mixins: [isElementMixin, hasDesignMixin],
  sanitySchema: () =>
    defineType({
      type: 'object',
      name: 'oneOffPageSection',
      title: 'Page Section',
      icon: IconLayoutList,
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
        {
          name: 'ctas',
          title: 'CTAs',
          type: 'array',
          of: ctaRecord.typeOption,
        },
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
        defineField({
          ...mediaField,
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
          name: 'mediaAlignment',
          title: 'Media Alignment',
          description:
            'How the media should align with the rest of the page section.',
          ...mediaAlignmentField,
        },
        {
          name: 'mediaSize',
          title: 'Media Size',
          description: 'The size of the media.',
          ...sizeField,
        },
      ],
    }),
  groqQueryPart(): string {
    return `
      title[]{${inlineRichTextQueryPart}},
      subtitle[]{${inlineRichTextQueryPart}},
      ctas[]{${ctaRecord.getGroqQueryPart()}},
      tagline[]{${inlineRichTextQueryPart}},
      body[]{${bodyRichTextQueryPart}},
      media->{${mediaRecord.getGroqQueryPart()}},
      blocks[]{${getPageBlockRecord().getGroqQueryPart()}},
      alignment,
      smallAlignment,
      titleSize,
      mediaAlignment,
      mediaSize,
    `;
  },
});
