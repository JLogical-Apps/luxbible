'use client';

import { useEffect } from 'react';

import { Campaign, getCampaign, getStoreUrl } from '@/lib/campaign';
import { getPreferredStore } from '@/lib/store';

// The page only loads when Android didn't open the link in Lux, which can still mean Lux is installed
// (an in-app browser, an unverified app link). An intent URL lets Chrome open it or fall back to Play.
export default function AndroidAppRedirect({
  googlePlayUrl,
  defaultCampaign,
}: {
  googlePlayUrl: string;
  defaultCampaign?: Campaign;
}) {
  useEffect(() => {
    if (getPreferredStore(navigator) !== 'google-play') return;

    const campaign = getCampaign(window.location.search) ?? defaultCampaign;
    const fallbackUrl = getStoreUrl({
      href: googlePlayUrl,
      store: 'google-play',
      campaign,
    });
    const packageName = new URL(googlePlayUrl).searchParams.get('id');
    const { host, pathname } = window.location;
    window.location.replace(
      `intent://${host}${pathname}#Intent;scheme=https;package=${packageName};S.browser_fallback_url=${encodeURIComponent(
        fallbackUrl,
      )};end`,
    );
  }, [defaultCampaign, googlePlayUrl]);

  return null;
}
