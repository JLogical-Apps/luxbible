import SVG from 'react-inlinesvg';

import { Icon } from '@/lib/types/icon';

export default function IconRenderer({
  icon,
  size,
  ...props
}: {
  icon: Icon;
  size?: number;
  [key: string]: any;
}) {
  return (
    <SVG
      {...props}
      src={icon.svg}
      style={{
        width: size ? `${size}em` : '100%',
        height: size ? `${size}em` : '100%',
      }}
    />
  );
}
