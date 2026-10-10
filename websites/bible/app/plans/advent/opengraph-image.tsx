import { readFileSync } from 'fs';
import { ImageResponse } from 'next/og';
import path from 'path';

import OgFrame from '@/components/og/OgFrame';
import {
  adventDayCount,
  formatAdventDate,
  getUpcomingAdvent,
} from '@/lib/advent';
import { getOgImageOptions, ogColors, ogImageSize } from '@/lib/og';

export const size = ogImageSize;
export const contentType = 'image/png';
export const alt =
  "Advent in Lux Bible: Don't just read the Christmas story. Study it.";
export const revalidate = 86400;

export default function Image() {
  const { year, start } = getUpcomingAdvent(new Date());
  const sceneSrc = `data:image/jpeg;base64,${readFileSync(
    path.join(process.cwd(), 'assets/advent/scene.jpg'),
  ).toString('base64')}`;

  return new ImageResponse(
    (
      <OgFrame>
        <img
          src={sceneSrc}
          width={520}
          height={293}
          alt=""
          style={{
            position: 'absolute',
            right: 56,
            top: 176,
            borderRadius: 24,
          }}
        />
        <div
          style={{
            display: 'flex',
            flexDirection: 'column',
            justifyContent: 'center',
            flex: 1,
            width: 500,
            gap: 24,
          }}
        >
          <div
            style={{ fontSize: 26, color: ogColors.emphasis }}
          >{`Advent ${year}`}</div>
          <div
            style={{ display: 'flex', flexDirection: 'column', fontSize: 52 }}
          >
            <div style={{ lineHeight: 1.1 }}>
              Don&apos;t just read the Christmas story.
            </div>
            <div style={{ lineHeight: 1.1, color: ogColors.emphasis }}>
              Study it.
            </div>
          </div>
          <div
            style={{
              display: 'flex',
              flexDirection: 'column',
              fontSize: 26,
              lineHeight: 1.4,
              color: ogColors.muted,
            }}
          >
            <div>{`${adventDayCount} days of readings and study notes`}</div>
            <div>{`${formatAdventDate(start)} to Christmas Day`}</div>
          </div>
        </div>
      </OgFrame>
    ),
    getOgImageOptions(),
  );
}
