import { readFileSync } from 'fs';
import { ImageResponse } from 'next/og';
import path from 'path';

import OgFrame from '@/components/og/OgFrame';
import { getOgImageOptions, ogColors, ogImageSize } from '@/lib/og';
import { site } from '@/lib/site';

export const size = ogImageSize;
export const contentType = 'image/png';
export const alt = `${site.name}: ${site.tagline}`;

export default function Image() {
  const heroScreenshotsSrc = `data:image/png;base64,${readFileSync(
    path.join(process.cwd(), 'public/media/hero-screenshots.png'),
  ).toString('base64')}`;

  return new ImageResponse(
    (
      <OgFrame>
        <img
          src={heroScreenshotsSrc}
          width={640}
          height={679}
          alt=""
          style={{ position: 'absolute', right: -60, top: 36 }}
        />
        <div
          style={{
            display: 'flex',
            flexDirection: 'column',
            justifyContent: 'center',
            flex: 1,
            width: 560,
            gap: 28,
          }}
        >
          <div style={{ fontSize: 68, lineHeight: 1.08 }}>{site.tagline}</div>
          <div
            style={{ fontSize: 30, lineHeight: 1.4, color: ogColors.emphasis }}
          >
            Free forever. No ads. No account. Works offline.
          </div>
        </div>
      </OgFrame>
    ),
    getOgImageOptions(),
  );
}
