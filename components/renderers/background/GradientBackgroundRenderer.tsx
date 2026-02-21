import { ReactNode } from 'react';

import { computeHslAttribute } from '@/lib/types/hsl-color';
import { getColorPaletteVariables } from '@/schema/documents/design/color-palette';
import { GradientBackground } from '@/schema/objects/background/gradient-background';

export default function GradientBackgroundRenderer({
  background,
  children,
  className,
}: {
  background: GradientBackground;
  children: ReactNode;
  className?: string;
}) {
  return (
    <div
      className={`text-foreground ${className}`}
      style={{
        ...getColorPaletteVariables(background.colorPalette),
        background: `linear-gradient(hsl(${computeHslAttribute(
          background.startColor.color,
        )}), hsl(${computeHslAttribute(background.endColor.color)}))`,
      }}
    >
      {children}
    </div>
  );
}
