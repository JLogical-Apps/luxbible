import { ImageMedia } from '@/schema/documents/media/image-media';
import { mediaRecord } from '@/schema/documents/media/media';
import { SanityMixin } from '@/schema/sanity-mixin';

export type HasSeo = {
  seoTitle: string;
  seoDescription: string;
  seoKeywords: string;
  faviconOverride?: ImageMedia;
  openGraphOverride?: ImageMedia;
};

export const hasSeoMixin: SanityMixin = {
  groups: [
    {
      name: 'seo',
      title: 'SEO',
    },
  ],
  fields: [
    {
      type: 'string',
      name: 'seoTitle',
      title: 'SEO Title',
      group: 'seo',
      options: {
        suggestedMaxLength: {
          length: 60,
          message: 'SEO titles should not be longer than 60 characters!',
        },
        suggestedMinLength: {
          length: 30,
          message: 'SEO titles should not be shorter than 30 characters!',
        },
      },
    },
    {
      type: 'string',
      name: 'seoDescription',
      title: 'SEO Description',
      group: 'seo',
      options: {
        suggestedMaxLength: {
          length: 160,
          message: 'SEO descriptions should not be longer than 160 characters!',
        },
        suggestedMinLength: {
          length: 55,
          message: 'SEO descriptions should not be shorter than 55 characters!',
        },
        multiline: true,
      },
    },
    {
      type: 'string',
      name: 'seoKeywords',
      title: 'SEO Keywords',
      group: 'seo',
      options: {
        multiline: true,
      },
    },
    {
      name: 'faviconOverride',
      type: 'reference',
      title: 'Favicon Override',
      to: [{ type: 'imageMedia' }],
      group: 'seo',
    },
    {
      name: 'openGraphOverride',
      type: 'reference',
      title: 'Open-Graph Image Override',
      to: [{ type: 'imageMedia' }],
      group: 'seo',
    },
  ],
  groqQueryPart: `
    seoTitle,
    seoDescription,
    seoKeywords,
    faviconOverride->{${mediaRecord.getGroqQueryPart()}},
    openGraphOverride->{${mediaRecord.getGroqQueryPart()}},
  `,
};
