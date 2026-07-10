import Link from 'next/link';

import { site } from '@/lib/site';

export default function SiteHeader() {
  return (
    <header className="sticky top-0 z-50 w-full border-b border-border/40 bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
      <div className="container flex h-14 max-w-screen-2xl items-center">
        <Link href="/" className="flex items-center no-underline">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src="/media/lux-logo.svg"
            alt={`${site.name} logo`}
            style={{ width: 'auto', height: '40px' }}
          />
        </Link>
      </div>
    </header>
  );
}
