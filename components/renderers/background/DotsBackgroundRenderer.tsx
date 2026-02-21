import { vercelStegaCleanAll } from '@sanity/client/stega';
import { clsx } from 'clsx';
import { ReactNode } from 'react';

import { getColorPaletteVariables } from '@/schema/documents/design/color-palette';
import { DotsBackground } from '@/schema/objects/background/dots-background';

export default function DotsBackgroundRenderer({
  background,
  children,
  className,
}: {
  background: DotsBackground;
  children: ReactNode;
  className?: string;
}) {
  return (
    <div
      className={clsx(
        `relative bg-background text-foreground`,
        vercelStegaCleanAll(background.brightness ?? '') == 'light'
          ? `bg-dot-black/[0.25]`
          : `bg-dot-white/[0.25]`,
        className,
      )}
      style={getColorPaletteVariables(background.colorPalette)}
    >
      <div className="absolute pointer-events-none rounded-3xl inset-0 flex items-center justify-center bg-background [mask-image:radial-gradient(ellipse_at_center,transparent_20%,hsl(var(--background)))]" />
      <div className="relative">{children}</div>
    </div>
  );
}
