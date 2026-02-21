import { IconDownload } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { convertToShared } from '@/sanity/plugins/convert-to-shared';
import {
  ColorPalette,
  colorPaletteRecord,
} from '@/schema/documents/design/color-palette';
import { PageBlockBase } from '@/schema/documents/page-block/page-block';
import { isElementMixin } from '@/schema/mixins/is-element';
import { record } from '@/schema/sanity-type';

export interface AppStorePageBlock extends PageBlockBase {
  _type: 'appStorePageBlock';
  googlePlayUrl?: string;
  appStoreUrl?: string;
  webAppUrl?: string;
  buttonColorPalette?: ColorPalette;
}

export const appStorePageBlockRecord = record({
  mixins: [isElementMixin],
  sanitySchema: () =>
    defineType({
      name: 'appStorePageBlock',
      title: 'App Store Download',
      type: 'object',
      icon: IconDownload,
      fields: [
        convertToShared({
          type: 'sharedPageBlock',
          innerField: 'pageBlock',
        }),
        {
          name: 'googlePlayUrl',
          type: 'string',
          title: 'Google Play URL',
          description: 'For Android users.',
        },
        {
          name: 'appStoreUrl',
          type: 'string',
          title: 'App Store URL',
          description: 'For iOS users.',
        },
        {
          name: 'webAppUrl',
          type: 'string',
          title: 'Web App URL',
          description: 'For computer users.',
        },
        {
          name: 'buttonColorPalette',
          title: 'Button Color Palette',
          type: 'reference',
          to: colorPaletteRecord.typeOption,
        },
      ],
      preview: {
        prepare() {
          return {
            title: 'App Store Download',
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      googlePlayUrl,
      appStoreUrl,
      webAppUrl,
      buttonColorPalette->{${colorPaletteRecord.getGroqQueryPart()}},
    `;
  },
});
