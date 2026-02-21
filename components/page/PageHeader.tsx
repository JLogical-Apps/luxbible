import Link from 'next/link';
import * as React from 'react';

import { MainNav } from '@/components/page/MainNav';
import { MobileNav } from '@/components/page/MobileNav';
import CtaRenderer from '@/components/renderers/CtaRenderer';
import ImageMediaRenderer
  from '@/components/renderers/media/ImageMediaRenderer';
import { Settings } from '@/schema/documents/singletons/settings';

export default function PageHeader({ settings }: { settings: Settings }) {
  return (
    <header
      className="sticky top-0 z-50 w-full border-b border-border/40 bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
      <div className="container flex h-14 max-w-screen-2xl items-center">
        {settings.menuItems && settings.menuItems.length > 0 &&
          <MobileNav settings={settings} />}
        <Link href="/" className="mr-6 flex items-center space-x-2">
          <ImageMediaRenderer
            media={settings.logo}
            height={40}
            style={{ width: 'auto', height: '40px' }}
            priority
            className=""
          />
        </Link>
        <MainNav settings={settings} />
        <div className="flex flex-1 items-center space-x-2 justify-end">
          {settings.cta && <CtaRenderer cta={settings.cta} />}
        </div>
      </div>
    </header>
  );
}
