import { ImageResponse } from 'next/og';

import OgFrame from '@/components/og/OgFrame';
import { getPassageText } from '@/lib/bible';
import { getOgImageOptions, ogColors, ogImageSize } from '@/lib/og';
import { formatPassage } from '@/lib/passage';
import { site } from '@/lib/site';
import { truncateText } from '@/lib/utils';

export const size = ogImageSize;
export const contentType = 'image/png';
export const alt = 'A Bible passage shared from Lux Bible';

type Props = { params: { reference: string } };

const getFontSize = (text: string) =>
  text.length <= 110 ? 56 : text.length <= 190 ? 46 : 38;

export default function Image({ params }: Props) {
  const osisId = decodeURIComponent(params.reference);
  const reference = formatPassage(osisId);
  const text = getPassageText(osisId);
  const excerpt = text ? truncateText(text, 280) : site.tagline;

  return new ImageResponse(
    (
      <OgFrame>
        <div
          style={{
            display: 'flex',
            flex: 1,
            alignItems: 'center',
            fontSize: getFontSize(excerpt),
            lineHeight: 1.4,
          }}
        >
          {excerpt}
        </div>
        {reference && (
          <div style={{ display: 'flex', alignItems: 'baseline', gap: 16 }}>
            <div style={{ fontSize: 36, color: ogColors.emphasis }}>
              {reference}
            </div>
            {text && (
              <div style={{ fontSize: 26, color: ogColors.muted }}>BSB</div>
            )}
          </div>
        )}
      </OgFrame>
    ),
    getOgImageOptions(),
  );
}
