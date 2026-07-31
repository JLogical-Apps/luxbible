import { IconExternalLink } from '@tabler/icons-react';
import Link from 'next/link';
import { CSSProperties, ReactNode } from 'react';

import { Button } from '@/components/ui/Button';

export type CtaVariant = 'filled' | 'ghost';

export default function CtaButton({
  text,
  href,
  variant = 'filled',
  external = false,
  icon,
  paletteVars,
}: {
  text: string;
  href: string;
  variant?: CtaVariant;
  external?: boolean;
  icon?: ReactNode;
  paletteVars?: CSSProperties;
}) {
  const button = (
    <Button variant={variant === 'filled' ? 'default' : 'ghost'} asChild>
      <Link href={href} target={external ? '_blank' : undefined}>
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
      </Link>
    </Button>
  );

  return paletteVars ? <div style={paletteVars}>{button}</div> : button;
}
