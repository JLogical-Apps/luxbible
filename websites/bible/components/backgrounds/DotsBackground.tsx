import { clsx } from 'clsx';
import { ReactNode } from 'react';

export default function DotsBackground({
  children,
  className,
}: {
  children: ReactNode;
  className?: string;
}) {
  return (
    <div
      className={clsx(
        'relative bg-background text-foreground bg-dot-white/[0.25]',
        className,
      )}
    >
      <div className="absolute pointer-events-none rounded-3xl inset-0 flex items-center justify-center bg-background [mask-image:radial-gradient(ellipse_at_center,transparent_20%,hsl(var(--background)))]" />
      <div className="relative">{children}</div>
    </div>
  );
}
