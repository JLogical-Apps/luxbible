import dynamic from 'next/dynamic';
import { defineType } from 'sanity';

import {
  ColorPalette,
  colorPaletteRecord,
} from '@/schema/documents/design/color-palette';
import { InlineForm, inlineFormRecord } from '@/schema/documents/inline-form';
import {
  ImageMedia,
  imageMediaRecord,
} from '@/schema/documents/media/image-media';
import { mediaRecord } from '@/schema/documents/media/media';
import { HasSeo, hasSeoMixin } from '@/schema/mixins/has-seo';
import {
  HasSocialLinks,
  hasSocialLinksMixin,
} from '@/schema/mixins/has-social-links';
import { Cta, ctaRecord } from '@/schema/objects/cta';
import { MenuItem, menuItemRecord } from '@/schema/objects/menu-item';
import {
  PageOverride,
  pageOverrideRecord,
} from '@/schema/objects/page-override';
import { record } from '@/schema/sanity-type';

export type Settings = HasSeo &
  HasSocialLinks & {
    brandName: string;
    logo: ImageMedia;
    domain: string;
    colorPalette: ColorPalette;
    primaryColorPalette: ColorPalette;
    menuItems: MenuItem[];
    cta?: Cta;
    footerItems: MenuItem[];
    footerColorPalette?: ColorPalette;
    builtByImage?: ImageMedia;
    builtByLink?: string;
    newsletterTitle?: string;
    newsletterBody?: string;
    newsletterForm?: InlineForm;
    pageOverrides: PageOverride[];
  };

export const settingsRecord = record<Settings>({
  mixins: [hasSeoMixin, hasSocialLinksMixin],
  sanitySchema: () =>
    defineType({
      type: 'document',
      name: 'settings',
      title: 'Site Settings',
      icon: dynamic(() => import('@sanity/icons').then((mod) => mod.CogIcon)),
      fields: [
        {
          name: 'brandName',
          title: 'Brand Name',
          type: 'string',
          description: 'Name of the company.',
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'logo',
          title: 'Logo',
          type: 'reference',
          to: [{ type: 'imageMedia' }],
          description:
            'Used for favicon, open graph image, and navigation bar header.',
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'domain',
          title: 'Domain',
          type: 'url',
          description: 'The main domain this site is hosted on.',
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'colorPalette',
          title: 'Color Palette',
          type: 'reference',
          to: colorPaletteRecord.typeOption,
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'primaryColorPalette',
          title: 'Primary Color Palette',
          type: 'reference',
          to: colorPaletteRecord.typeOption,
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'menuItems',
          title: 'Menu Items',
          description: 'Links displayed on the header of your site.',
          type: 'array',
          of: menuItemRecord.typeOption,
        },
        {
          name: 'cta',
          title: 'CTA',
          description: 'CTA at the top-right of the page.',
          type: 'array',
          of: [{ type: 'cta' }],
          options: {
            single: true,
          },
        },
        {
          name: 'footerItems',
          title: 'Footer Item list',
          description: 'Links displayed on the footer of your site.',
          type: 'array',
          of: menuItemRecord.typeOption,
        },
        {
          name: 'footerColorPalette',
          title: 'Footer Color Palette',
          type: 'reference',
          to: colorPaletteRecord.typeOption,
        },
        {
          name: 'builtByImage',
          title: 'Built By Image',
          type: 'reference',
          to: imageMediaRecord.typeOption,
        },
        {
          name: 'builtByLink',
          title: 'Built By Link',
          type: 'string',
        },
        {
          name: 'newsletterTitle',
          type: 'string',
          title: 'Newsletter Title',
        },
        {
          name: 'newsletterBody',
          type: 'string',
          title: 'Newsletter Body',
        },
        {
          name: 'newsletterForm',
          type: 'reference',
          to: inlineFormRecord.typeOption,
          title: 'Newsletter Form',
          description: 'Form to show in the footer.',
        },
        {
          name: 'pageOverrides',
          type: 'array',
          of: pageOverrideRecord.typeOption,
          title: 'Page Overrides',
          description: 'Override the display of pages.',
        },
      ],
      preview: {
        prepare() {
          return {
            title: 'Site Settings',
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      brandName,
      logo->{${mediaRecord.getGroqQueryPart()}},
      domain,
      colorPalette->{${colorPaletteRecord.getGroqQueryPart()}},
      primaryColorPalette->{${colorPaletteRecord.getGroqQueryPart()}},
      menuItems[]{${menuItemRecord.getGroqQueryPart()}},
      cta[0]{${ctaRecord.getGroqQueryPart()}},
      footerItems[]{${menuItemRecord.getGroqQueryPart()}},
      footerColorPalette->{${colorPaletteRecord.getGroqQueryPart()}},
      builtByImage->{${imageMediaRecord.getGroqQueryPart()}},
      builtByLink,
      newsletterTitle,
      newsletterBody,
      newsletterForm->{${inlineFormRecord.getGroqQueryPart()}},
      pageOverrides[]{${pageOverrideRecord.getGroqQueryPart()}},
    `;
  },
});
