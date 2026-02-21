import { ReactNode } from 'react';

import {
  ColorPalette,
  getColorPaletteVariables,
} from '@/schema/documents/design/color-palette';

export default function PageWrapper({
  colorPalette,
  primaryColorPalette,
  children,
  ...props
}: {
  colorPalette?: ColorPalette;
  primaryColorPalette?: ColorPalette;
  children: ReactNode;
  [key: string]: any;
}) {
  const paletteVariables = colorPalette
    ? getColorPaletteVariables(colorPalette)
    : {};

  const primaryPaletteVariables = primaryColorPalette
    ? getColorPaletteVariables(primaryColorPalette, 'primary', false)
    : {};

  return (
    <div style={{ ...paletteVariables, ...primaryPaletteVariables }} {...props}>
      {children}
    </div>
  );
}
