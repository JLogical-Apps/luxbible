import Image from 'next/image';
import { ReactNode } from 'react';

import { cn } from '@/lib/utils';

// In points, matching the frame that scripts/render-iphone-frame.swift renders at 3x.
const frameWidth = 447;
const frameHeight = 888;
const screen = { left: 27, top: 18, width: 393, height: 852, radius: 57 };

const percentOf = (value: number, total: number) => `${(value / total) * 100}%`;

// Recordings are the screen alone, so the Simulator bezel is layered over them.
export default function PhoneFrame({
  children,
  className,
}: {
  children: ReactNode;
  className?: string;
}) {
  return (
    <div
      className={cn('relative', className)}
      style={{ aspectRatio: `${frameWidth}/${frameHeight}` }}
    >
      <div
        className="absolute isolate overflow-hidden bg-black"
        style={{
          left: percentOf(screen.left, frameWidth),
          top: percentOf(screen.top, frameHeight),
          width: percentOf(screen.width, frameWidth),
          height: percentOf(screen.height, frameHeight),
          borderRadius: `${percentOf(
            screen.radius,
            screen.width,
          )} / ${percentOf(screen.radius, screen.height)}`,
        }}
      >
        {children}
      </div>
      <Image
        src="/media/iphone-frame.webp"
        alt=""
        width={frameWidth * 3}
        height={frameHeight * 3}
        unoptimized
        className="pointer-events-none absolute inset-0 h-full w-full"
      />
    </div>
  );
}
