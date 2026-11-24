import { IconExternalLink } from '@tabler/icons-react';
import { CSSProperties, ReactNode } from 'react';

import { Button } from '@/components/ui/Button';

export type CtaVariant = 'filled' | 'ghost';

// A plain anchor, since the app router's Link opens external URLs from script after the tap, which in-app
// browsers like Instagram's don't hand off to the App Store or Play Store.
export default function CtaButton({
  text,
  href,
  variant = 'filled',
  external = false,
  icon,
  paletteVars,
  onClick,
}: {
  text: string;
  href: string;
  variant?: CtaVariant;
  external?: boolean;
  icon?: ReactNode;
  paletteVars?: CSSProperties;
  onClick?: () => void;
}) {
  const button = (
    <Button variant={variant === 'filled' ? 'default' : 'ghost'} asChild>
      <a href={href} target={external ? '_blank' : undefined} onClick={onClick}>
        {icon ? (
          <span className="mr-2 h-4 w-4">{icon}</span>
        ) : (
          external && (
            <span className="mr-2 h-4 w-4">
              <IconExternalLink style={{ width: '100%', height: '100%' }} />
            </span>
          )
        )}
        {text}
      </a>
    </Button>
  );

  return paletteVars ? <div style={paletteVars}>{button}</div> : button;
}
