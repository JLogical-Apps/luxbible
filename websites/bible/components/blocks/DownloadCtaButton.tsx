'use client';

import { useEffect, useState } from 'react';

import CtaButton from '@/components/blocks/CtaButton';
import { trackStoreNavigation } from '@/lib/analytics';
import { getStoreUrl } from '@/lib/campaign';
import { getPreferredStore } from '@/lib/store';
import { useCampaign } from '@/lib/useCampaign';

export default function DownloadCtaButton({
  appStoreUrl,
  appStoreProviderToken,
  googlePlayUrl,
}: {
  appStoreUrl: string;
  appStoreProviderToken?: string;
  googlePlayUrl: string;
}) {
  const [href, setHref] = useState('#download');
  const [store, setStore] = useState<ReturnType<typeof getPreferredStore>>();
  const campaign = useCampaign();

  useEffect(() => {
    const preferredStore = getPreferredStore(navigator);
    setStore(preferredStore);
    setHref(
      preferredStore === 'app-store'
        ? getStoreUrl({
            href: appStoreUrl,
            store: preferredStore,
            campaign,
            appleProviderToken: appStoreProviderToken,
          })
        : preferredStore === 'google-play'
          ? getStoreUrl({
              href: googlePlayUrl,
              store: preferredStore,
              campaign,
            })
          : '#download',
    );
  }, [appStoreProviderToken, appStoreUrl, campaign, googlePlayUrl]);

  return (
    <CtaButton
      text="Download for Free"
      href={href}
      onClick={() => store && trackStoreNavigation(store, campaign)}
    />
  );
}
