import { toPlainText } from '@portabletext/react';
import { PortableTextBlock } from '@portabletext/types';
import { groq } from 'next-sanity';
import SVG from 'react-inlinesvg';
import { defineType } from 'sanity';

import { Icon, iconQueryPart } from '@/lib/types/icon';
import { iconField } from '@/schema/fields/icon-field';
import {
  inlineRichText,
  inlineRichTextQueryPart,
} from '@/schema/richtext/inline-rich-text';
import { record } from '@/schema/sanity-type';

export type TimelineItem = {
  name: PortableTextBlock[];
  body: PortableTextBlock[];
  icon: Icon;
};

export const timelineItemRecord = record<TimelineItem>({
  sanitySchema: () =>
    defineType({
      name: 'timelineItem',
      type: 'object',
      title: 'Timeline Item',
      fields: [
        {
          name: 'name',
          title: 'Name',
          ...inlineRichText,
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'body',
          title: 'Body',
          ...inlineRichText,
          validation: (Rule) => Rule.required(),
        },
        {
          ...iconField,
          validation: (Rule) => Rule.required(),
        },
      ],
      preview: {
        select: {
          title: 'name',
          icon: 'icon.svg',
        },
        prepare({ title, icon }) {
          return {
            title: toPlainText(title),
            media: icon && (
              <SVG
                src={icon}
                style={{
                  width: '1em',
                  height: '1em',
                }}
              />
            ),
          };
        },
      },
    }),
  groqQueryPart: () => groq`
      name[]{${inlineRichTextQueryPart}},
      body[]{${inlineRichTextQueryPart}},
      icon{${iconQueryPart}},
  `,
});
