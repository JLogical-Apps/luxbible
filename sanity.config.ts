/**
 * This config is used to set up Sanity Studio that's mounted on the `app/studio/[[...index]]/Studio.tsx` route
 */

import { colorInput } from '@sanity/color-input';
import { visionTool } from '@sanity/vision';
import { defineConfig } from 'sanity';
import { structureTool } from 'sanity/structure';
import { unsplashImageAsset } from 'sanity-plugin-asset-source-unsplash';
import { iconPicker } from 'sanity-plugin-icon-picker';

import { apiVersion, dataset, projectId, studioUrl } from '@/sanity/lib/api';
import { defaultDocumentNode } from '@/sanity/plugins/iframe-preview';
import { pageStructure, singletonPlugin } from '@/sanity/plugins/settings';
import { loadIcons } from '@/sanity/utils/tabler-icons-config';
import { tsxSanityConfig } from '@/sanity-config';
import { mediaRecord } from '@/schema/documents/media/media';
import { homePageRecord } from '@/schema/documents/singletons/home';
import { settingsRecord } from '@/schema/documents/singletons/settings';
import { getRecords } from '@/schema/records';

const title =
  process.env.NEXT_PUBLIC_SANITY_PROJECT_TITLE || 'JLogical Website';

export default defineConfig({
  basePath: studioUrl,
  projectId: projectId || '',
  dataset: dataset || '',
  title,
  ...tsxSanityConfig,
  schema: {
    types: getRecords().flatMap((record) => record.getSanitySchemas()),
  },
  plugins: [
    structureTool({
      defaultDocumentNode,
      structure: pageStructure({
        singletons: [homePageRecord.sanitySchema, settingsRecord.sanitySchema],
        medias: mediaRecord.getSanitySchemas(),
        hidden: ['media.tag'],
      }),
    }),
    singletonPlugin([
      homePageRecord.sanitySchema.name,
      settingsRecord.sanitySchema.name,
    ]),
    unsplashImageAsset(),
    visionTool({ defaultApiVersion: apiVersion }),
    iconPicker(),
    colorInput(),
  ],
});

loadIcons();
