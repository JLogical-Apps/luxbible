import { vercelStegaCleanAll } from '@sanity/client/stega';
import { IconExternalLink } from '@tabler/icons-react';
import Link from 'next/link';
import React from 'react';

import {
  getActionDescriptiveText,
  getActionProps
} from '@/components/props/action-props';
import IconRenderer from '@/components/renderers/IconRenderer';
import { Button } from '@/components/ui/Button';
import ColorPaletteWrapper from '@/components/util/ColorPaletteWrapper';
import { Cta } from '@/schema/objects/cta';

export default function CtaRenderer({ cta }: { cta: Cta }) {
  const descriptiveText = getActionDescriptiveText(cta.action);
  return (
    <ColorPaletteWrapper colorPalette={cta.colorPalette}>
      <Button variant={cta.type === 'filled' ? undefined : cta.type} asChild>
        <Link {...getActionProps(cta.action)}>
          {cta.icon && (
            <span className="mr-2 h-4 w-4">
              <IconRenderer icon={cta.icon} />
            </span>
          )}
          {!cta.icon &&
            cta.action && vercelStegaCleanAll(cta.action._type) === 'externalUrlAction' && (
              <span className="mr-2 h-4 w-4">
                <IconExternalLink style={{ width: '100%', height: '100%' }} />
              </span>
            )}
          {cta.text}
          {descriptiveText && (
            <span className="sr-only">{descriptiveText}</span>
          )}
        </Link>
      </Button>
    </ColorPaletteWrapper>
  );
}
