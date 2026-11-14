import { ReactNode } from 'react';

import { cn } from '@/lib/utils';

// Recordings are the screen alone, so the bezel is drawn here.
export default function PhoneFrame({
  children,
  className,
}: {
  children: ReactNode;
  className?: string;
}) {
  return (
    <div
      className={cn(
        'overflow-hidden rounded-[2.5rem] border-[6px] border-zinc-800 bg-black',
        className,
      )}
    >
      {children}
    </div>
  );
}
