import { PortableTextBlock } from '@portabletext/types';

import { CustomPortableText } from '@/components/CustomPortableText';
import IconRenderer from '@/components/renderers/IconRenderer';
import ColorPaletteWrapper from '@/components/util/ColorPaletteWrapper';
import { Icon } from '@/lib/types/icon';
import { ColorPalette } from '@/schema/documents/design/color-palette';

export default function Feature({
  name,
  body,
  icon,
  iconColorPalette,
}: {
  name: PortableTextBlock[];
  body: PortableTextBlock[];
  icon: Icon;
  iconColorPalette?: ColorPalette;
}) {
  return (
    <div className="relative pl-16">
      <div className="text-base text-start font-semibold leading-7 text-foreground">
        <ColorPaletteWrapper
          colorPalette={iconColorPalette}
          prefix="primary"
          includeBackground={false}
        >
          <div
            className="absolute left-0 top-0 flex h-10 w-10 items-center justify-center rounded-lg bg-primary text-primary-foreground"
            aria-hidden="true"
          >
            <IconRenderer icon={icon} size={1.5} />
          </div>
        </ColorPaletteWrapper>
        <CustomPortableText value={name} />
      </div>
      <div className="mt-2 text-start text-base leading-7 text-foreground-soft">
        <CustomPortableText value={body} />
      </div>
    </div>
  );
}
