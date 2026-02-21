import { toPlainText } from '@portabletext/react';
import { PortableTextBlock } from '@portabletext/types';
import { groq } from 'next-sanity';
import SVG from 'react-inlinesvg';
import { defineType } from 'sanity';

import { Icon, iconQueryPart } from '@/lib/types/icon';
import { iconField } from '@/schema/fields/icon-field';
import {
  bodyRichText,
  bodyRichTextQueryPart,
} from '@/schema/richtext/body-rich-text';
import {
  inlineRichText,
  inlineRichTextQueryPart,
} from '@/schema/richtext/inline-rich-text';
import { record } from '@/schema/sanity-type';

export type Feature = {
  name: PortableTextBlock[];
  body: PortableTextBlock[];
  icon: Icon;
};

export const featureRecord = record<Feature>({
  sanitySchema: () =>
    defineType({
      name: 'feature',
      type: 'object',
      title: 'Feature',
      fields: [
        {
          name: 'name',
          title: 'Name',
          ...inlineRichText,
        },
        {
          name: 'body',
          title: 'Body',
          ...bodyRichText,
        },
        {
          ...iconField,
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
      body[]{${bodyRichTextQueryPart}},
      icon{${iconQueryPart}},
  `,
});
