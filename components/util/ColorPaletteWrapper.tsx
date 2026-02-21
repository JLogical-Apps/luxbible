import { ReactNode } from 'react';

import {
  ColorPalette,
  getColorPaletteVariables,
} from '@/schema/documents/design/color-palette';

export default function ColorPaletteWrapper({
  colorPalette,
  children,
  prefix,
  includeBackground = true,
}: {
  colorPalette?: ColorPalette;
  children: ReactNode;
  prefix?: string;
  includeBackground?: boolean;
}) {
  if (!colorPalette) {
    return <>{children}</>;
  }

  const colorPaletteVariables = getColorPaletteVariables(
    colorPalette,
    prefix,
    includeBackground,
  );

  return <div style={colorPaletteVariables}>{children}</div>;
}
