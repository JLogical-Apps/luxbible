'use client';

import Link from 'next/link';
import { ReactNode, useEffect, useState } from 'react';

import { getPreferredStore } from '@/lib/store';

// Only phones and tablets can open Lux, so desktop visitors don't see the link.
export default function OpenInAppLink({
  href,
  children,
}: {
  href: string;
  children: ReactNode;
}) {
  const [isMobile, setIsMobile] = useState(false);
  useEffect(() => setIsMobile(!!getPreferredStore(navigator)), []);

  if (!isMobile) return null;

  return (
    <Link href={href} className="text-sm font-semibold text-foreground-soft">
      {children}
    </Link>
  );
}
