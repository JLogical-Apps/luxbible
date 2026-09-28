import { readFileSync } from 'fs';
import path from 'path';

export const ogImageSize = { width: 1200, height: 630 };

// Read at render time: pages import their opengraph-image module for its metadata, and their functions don't bundle these files.
export const getOgImageOptions = () => ({
  ...ogImageSize,
  fonts: [
    {
      name: 'Inter',
      data: readFileSync(
        path.join(process.cwd(), 'assets/fonts/Inter-Regular.ttf'),
      ),
      weight: 400 as const,
      style: 'normal' as const,
    },
  ],
});

export const ogColors = {
  background: '#09090b',
  foreground: '#ffffff',
  muted: '#a1a1aa',
  emphasis: '#facc15',
  emphasisSoft: '#eab308',
};

export const getLuxLogoSrc = () =>
  `data:image/svg+xml;base64,${readFileSync(
    path.join(process.cwd(), 'public/media/lux-logo.svg'),
  ).toString('base64')}`;
