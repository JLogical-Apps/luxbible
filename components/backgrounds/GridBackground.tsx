import { clsx } from 'clsx';
import { ReactNode } from 'react';

export default function GridBackground({
  children,
  className,
}: {
  children: ReactNode;
  className?: string;
}) {
  return (
    <div
      className={clsx(
        'relative bg-background text-foreground bg-grid-small-black/[0.15]',
        className,
      )}
    >
      <div className="absolute pointer-events-none rounded-3xl inset-0 flex items-center justify-center bg-background [mask-image:radial-gradient(ellipse_at_center,transparent_20%,hsl(var(--background)))]" />
      <div className="relative">{children}</div>
    </div>
  );
}
