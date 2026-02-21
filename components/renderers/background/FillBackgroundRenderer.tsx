import { ReactNode } from 'react';

import { getColorPaletteVariables } from '@/schema/documents/design/color-palette';
import { FillBackground } from '@/schema/objects/background/fill-background';

export default function FillBackgroundRenderer({
  background,
  children,
  className,
}: {
  background: FillBackground;
  children: ReactNode;
  className?: string;
}) {
  return (
    <div
      className={`bg-background text-foreground ${className}`}
      style={getColorPaletteVariables(background.colorPalette)}
    >
      {children}
    </div>
  );
}
