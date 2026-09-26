'use client';

import { useEffect } from 'react';

import { trackStoreNavigation } from '@/lib/analytics';
import { Campaign, getCampaign, getStoreUrl } from '@/lib/campaign';
import { getPreferredStore } from '@/lib/store';

export default function StoreRedirect({
  appStoreUrl,
  appStoreProviderToken,
  googlePlayUrl,
  defaultCampaign,
}: {
  appStoreUrl: string;
  appStoreProviderToken?: string;
  googlePlayUrl: string;
  defaultCampaign?: Campaign;
}) {
  useEffect(() => {
    const store = getPreferredStore(navigator);
    if (!store) return;

    const campaign = getCampaign(window.location.search) ?? defaultCampaign;
    const href =
      store === 'app-store'
        ? getStoreUrl({
            href: appStoreUrl,
            store,
            campaign,
            appleProviderToken: appStoreProviderToken,
          })
        : getStoreUrl({ href: googlePlayUrl, store, campaign });

    let isRedirected = false;
    const redirect = () => {
      if (isRedirected) return;
      isRedirected = true;
      window.location.replace(href);
    };

    trackStoreNavigation(store, campaign, redirect);
    // gtag never calls back when it is blocked or not loaded, so redirect regardless.
    const timeout = setTimeout(redirect, 1000);
    return () => clearTimeout(timeout);
  }, [appStoreProviderToken, appStoreUrl, defaultCampaign, googlePlayUrl]);

  return null;
}
