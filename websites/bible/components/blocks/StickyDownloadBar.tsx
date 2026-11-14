'use client';

import { ReactNode, useEffect, useState } from 'react';

import DownloadCtaButton from '@/components/blocks/DownloadCtaButton';
import { Campaign } from '@/lib/campaign';
import { site } from '@/lib/site';
import { cn } from '@/lib/utils';

// Shows on phones once the element with `showAfterId` scrolls away, and hides again at the download section.
export default function StickyDownloadBar({
  title,
  subtitle,
  showAfterId,
  defaultCampaign,
}: {
  title: ReactNode;
  subtitle?: ReactNode;
  showAfterId: string;
  defaultCampaign?: Campaign;
}) {
  const [isVisible, setIsVisible] = useState(false);

  useEffect(() => {
    const update = () => {
      const start = document.getElementById(showAfterId);
      const download = document.getElementById('download');
      setIsVisible(
        !!start &&
          start.getBoundingClientRect().bottom < 0 &&
          (!download ||
            download.getBoundingClientRect().top > window.innerHeight),
      );
    };
    update();
    window.addEventListener('scroll', update, { passive: true });
    window.addEventListener('resize', update);
    return () => {
      window.removeEventListener('scroll', update);
      window.removeEventListener('resize', update);
    };
  }, [showAfterId]);

  return (
    <div
      className={cn(
        'fixed inset-x-0 bottom-0 z-40 flex items-center justify-between gap-4 border-t border-border/40 bg-background/95 px-4 pt-3 pb-[calc(0.75rem+env(safe-area-inset-bottom))] backdrop-blur transition-transform duration-300 supports-[backdrop-filter]:bg-background/60 md:hidden',
        !isVisible && 'pointer-events-none translate-y-full',
      )}
    >
      <div className="min-w-0">
        <p className="truncate text-sm font-semibold">{title}</p>
        {subtitle && (
          <p className="truncate text-xs text-foreground-soft/70">{subtitle}</p>
        )}
      </div>
      <DownloadCtaButton
        appStoreUrl={site.appStoreUrl}
        appStoreProviderToken={site.appStoreProviderToken}
        googlePlayUrl={site.googlePlayUrl}
        defaultCampaign={defaultCampaign}
      />
    </div>
  );
}
