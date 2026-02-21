import { vercelStegaCleanAll } from '@sanity/client/stega';
import { vercelStegaEncode } from '@vercel/stega';
import { clsx } from 'clsx';
import { ReactNode } from 'react';

import { getColorPaletteVariables } from '@/schema/documents/design/color-palette';
import { GridBackground } from '@/schema/objects/background/grid-background';

export default function GridBackgroundRenderer({
  background,
  children,
  className,
}: {
  background: GridBackground;
  children: ReactNode;
  className?: string;
}) {
  return (
    <div
      className={clsx(
        `relative bg-background text-foreground`,
        getGridSize(background),
        className,
      )}
      style={getColorPaletteVariables(background.colorPalette)}
    >
      <div className="absolute pointer-events-none rounded-3xl inset-0 flex items-center justify-center bg-background [mask-image:radial-gradient(ellipse_at_center,transparent_20%,hsl(var(--background)))]" />
      <div className="relative">{children}</div>
    </div>
  );
}

function getGridSize(background: GridBackground) {
  const brightness = vercelStegaCleanAll(background.brightness ?? 'light');
  const size = vercelStegaCleanAll(background.size ?? 'md');

  if (brightness === 'light') {
    if (size === 'lg' || size === 'md') {
      return 'bg-grid-black/[0.15]';
    } else {
      return 'bg-grid-small-black/[0.15]';
    }
  } else {
    if (size === 'lg' || size === 'md') {
      return 'bg-grid-white/[0.15]';
    } else {
      return 'bg-grid-small-white/[0.15]';
    }
  }
}
