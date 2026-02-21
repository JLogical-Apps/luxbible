import { IconPalette } from '@tabler/icons-react';
import { CSSProperties } from 'react';
import { defineType } from 'sanity';

import { computeHslAttribute } from '@/lib/types/hsl-color';
import { Color, colorRecord } from '@/schema/documents/design/color';
import { record } from '@/schema/sanity-type';

export type ColorPalette = {
  backgroundColor: Color;
  backgroundSoftColor: Color;
  foregroundColor: Color;
  foregroundSoftColor: Color;
  emphasisColorPalette?: ColorPalette;
};

export function getColorPaletteVariables(
  colorPalette: ColorPalette | undefined,
  prefix?: string,
  includeBackground: boolean = true,
): CSSProperties {
  if (!colorPalette) {
    return {};
  }

  const variablePrefix = prefix ? `${prefix}-` : '';
  return {
    [`--${[prefix, includeBackground ? 'background' : '']
      .filter((e) => e)
      .join('-')}` as any]: computeHslAttribute(
      colorPalette.backgroundColor.color,
    ),
    [`--${[prefix, includeBackground ? 'background' : '', 'soft']
      .filter((e) => e)
      .join('-')}` as any]: computeHslAttribute(
      colorPalette.backgroundSoftColor.color,
    ),
    [`--${variablePrefix}foreground` as any]: computeHslAttribute(
      colorPalette.foregroundColor.color,
    ),
    [`--${variablePrefix}foreground-soft` as any]: computeHslAttribute(
      colorPalette.foregroundSoftColor.color,
    ),
    ...(colorPalette.emphasisColorPalette
      ? {
          [`--${variablePrefix}emphasis` as any]: computeHslAttribute(
            colorPalette.emphasisColorPalette.backgroundColor.color,
          ),
          [`--${variablePrefix}emphasis-soft` as any]: computeHslAttribute(
            colorPalette.emphasisColorPalette.backgroundSoftColor.color,
          ),
          [`--${variablePrefix}on-emphasis` as any]: computeHslAttribute(
            colorPalette.emphasisColorPalette.foregroundColor.color,
          ),
          [`--${variablePrefix}on-emphasis-soft` as any]: computeHslAttribute(
            colorPalette.emphasisColorPalette.foregroundSoftColor.color,
          ),
        }
      : {}),
  };
}

export const colorPaletteRecord = record({
  sanitySchema: () =>
    defineType({
      type: 'document',
      name: 'colorPalette',
      title: 'Color Palette',
      icon: IconPalette,
      fields: [
        {
          type: 'string',
          name: 'name',
          title: 'Name',
          validation: (Rule) => Rule.required(),
        },
        {
          ...colorRecord.sharedOrOneOff,
          name: 'backgroundColor',
          title: 'Background Color',
          validation: (Rule) => Rule.required(),
        },
        {
          ...colorRecord.sharedOrOneOff,
          name: 'backgroundSoftColor',
          title: 'Background Soft Color',
          validation: (Rule) => Rule.required(),
        },
        {
          ...colorRecord.sharedOrOneOff,
          name: 'foregroundColor',
          title: 'Foreground Color',
          validation: (Rule) => Rule.required(),
        },
        {
          ...colorRecord.sharedOrOneOff,
          name: 'foregroundSoftColor',
          title: 'Foreground Soft Color',
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'emphasisColorPalette',
          type: 'reference',
          title: 'Emphasis Color Palette',
          to: [{ type: 'colorPalette' }],
        },
      ],
      preview: {
        select: {
          name: 'name',
          background: 'backgroundColor.0.color.hex',
          backgroundSoft: 'backgroundSoftColor.0.color.hex',
          foreground: 'foregroundColor.0.color.hex',
          foregroundSoft: 'foregroundSoftColor.0.color.hex',
          emphasis: 'emphasisColorPalette.backgroundColor.0.color.hex',
          emphasisSoft: 'emphasisColorPalette.backgroundSoftColor.0.color.hex',
        },
        prepare({
          name,
          background,
          backgroundSoft,
          foreground,
          foregroundSoft,
          emphasis,
          emphasisSoft,
        }) {
          return {
            title: name,
            media: (
              <span
                style={{
                  width: '100%',
                  height: '100%',
                  display: 'flex',
                  flexDirection: 'column',
                }}
              >
                <div style={{ display: 'flex', flexDirection: 'row', flex: 5 }}>
                  <div style={{ flex: 2, background: background }} />
                  <div style={{ flex: 1, background: backgroundSoft }} />
                </div>
                <div style={{ display: 'flex', flexDirection: 'row', flex: 1 }}>
                  <div style={{ flex: 2, background: foreground }} />
                  <div style={{ flex: 1, background: foregroundSoft }} />
                </div>
                <div style={{ display: 'flex', flexDirection: 'row', flex: 1 }}>
                  <div style={{ flex: 2, background: emphasis }} />
                  <div style={{ flex: 1, background: emphasisSoft }} />
                </div>
              </span>
            ),
          };
        },
      },
    }),
  groqQueryPart(): string {
    return getColorPaletteGroqQueryPart(true);
  },
});

function getColorPaletteGroqQueryPart(includeEmphasis: boolean) {
  return `
    "backgroundColor": {${colorRecord.getSharedOrOneOffGroqQueryPart(
      'backgroundColor',
    )}},
    "backgroundSoftColor": {${colorRecord.getSharedOrOneOffGroqQueryPart(
      'backgroundSoftColor',
    )}},
    "foregroundColor": {${colorRecord.getSharedOrOneOffGroqQueryPart(
      'foregroundColor',
    )}},
    "foregroundSoftColor": {${colorRecord.getSharedOrOneOffGroqQueryPart(
      'foregroundSoftColor',
    )}},
    ${
      includeEmphasis
        ? `"emphasisColorPalette": emphasisColorPalette->{${getColorPaletteGroqQueryPart(
            false,
          )}},`
        : ''
    } 
  `;
}
