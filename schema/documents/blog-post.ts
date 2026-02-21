import { PortableTextBlock } from '@portabletext/types';
import { IconArticle } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { Author, authorRecord } from '@/schema/documents/author';
import {
  ColorPalette,
  colorPaletteRecord,
} from '@/schema/documents/design/color-palette';
import {
  ImageMedia,
  imageMediaRecord,
} from '@/schema/documents/media/image-media';
import { hasDesignMixin } from '@/schema/mixins/has-design';
import { HasSeo, hasSeoMixin } from '@/schema/mixins/has-seo';
import {
  bodyRichText,
  bodyRichTextQueryPart,
} from '@/schema/richtext/body-rich-text';
import { record } from '@/schema/sanity-type';

export type BlogPostPage = HasSeo & {
  _type: 'blogPost';
  title: string;
  subtitle: string;
  slug: string;
  published: string;
  body: PortableTextBlock[];
  thumbnail: ImageMedia;
  author: Author;
  colorPalette?: ColorPalette;
};

export const blogPostPageRecord = record<BlogPostPage>({
  mixins: [hasSeoMixin, hasDesignMixin],
  sanitySchema: () =>
    defineType({
      type: 'document',
      name: 'blogPost',
      title: 'Blog Post',
      icon: IconArticle,
      groups: [
        {
          name: 'blogPost',
          title: 'Blog',
        },
      ],
      fields: [
        {
          type: 'string',
          name: 'title',
          title: 'Title',
          group: 'blogPost',
          validation: (Rule) => Rule.required(),
        },
        {
          type: 'string',
          name: 'subtitle',
          title: 'Subtitle',
          group: 'blogPost',
          validation: (Rule) => Rule.required(),
        },
        {
          type: 'slug',
          name: 'slug',
          title: 'Slug',
          description:
            'The unique identifier for the page and used for the URL.',
          group: 'blogPost',
          options: {
            source: 'title',
          },
          validation: (Rule) => Rule.required(),
        },
        {
          type: 'datetime',
          name: 'published',
          title: 'Published On',
          group: 'blogPost',
          initialValue: Date.now(),
        },
        {
          name: 'thumbnail',
          title: 'Thumbnail',
          group: 'blogPost',
          type: 'reference',
          to: imageMediaRecord.typeOption,
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'author',
          title: 'Author',
          group: 'blogPost',
          type: 'reference',
          to: authorRecord.typeOption,
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'body',
          title: 'Body',
          group: 'blogPost',
          ...bodyRichText,
        },
        {
          name: 'colorPalette',
          type: 'reference',
          to: colorPaletteRecord.typeOption,
          title: 'Color Palette',
        },
      ],
      preview: {
        select: {
          title: 'title',
          thumbnail: 'thumbnail.image.asset',
        },
        prepare({ title, thumbnail }) {
          return {
            title: title,
            subtitle: 'Blog Post',
            media: thumbnail,
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      title,
      subtitle,
      "slug": slug.current,
      published,
      body[]{${bodyRichTextQueryPart}},
      thumbnail->{${imageMediaRecord.getGroqQueryPart()}},
      author->{${authorRecord.getGroqQueryPart()}},
      colorPalette->{${colorPaletteRecord.getGroqQueryPart()}},
    `;
  },
});
