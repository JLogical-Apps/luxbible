import { IconTimelineEvent } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { convertToShared } from '@/sanity/plugins/convert-to-shared';
import {
  ColorPalette,
  colorPaletteRecord,
} from '@/schema/documents/design/color-palette';
import { PageBlockBase } from '@/schema/documents/page-block/page-block';
import { isElementMixin } from '@/schema/mixins/is-element';
import {
  TimelineItem,
  timelineItemRecord,
} from '@/schema/objects/timeline-item';
import { record } from '@/schema/sanity-type';

export interface TimelinePageBlock extends PageBlockBase {
  _type: 'timelinePageBlock';
  items: TimelineItem[];
  iconColorPalette?: ColorPalette;
}

export const timelinePageBlockRecord = record({
  mixins: [isElementMixin],
  sanitySchema: () =>
    defineType({
      name: 'timelinePageBlock',
      title: 'Timeline',
      type: 'object',
      icon: IconTimelineEvent,
      fields: [
        convertToShared({
          type: 'sharedPageBlock',
          innerField: 'pageBlock',
        }),
        {
          name: 'items',
          title: 'Items',
          type: 'array',
          of: timelineItemRecord.typeOption,
          validation: (Rule) => Rule.min(1),
        },
        {
          name: 'iconColorPalette',
          title: 'Icon Color Palette',
          type: 'reference',
          to: colorPaletteRecord.typeOption,
        },
      ],
      preview: {
        prepare() {
          return {
            title: 'Timeline',
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      items[]{${timelineItemRecord.getGroqQueryPart()}},
      iconColorPalette->{${colorPaletteRecord.getGroqQueryPart()}},
    `;
  },
});
