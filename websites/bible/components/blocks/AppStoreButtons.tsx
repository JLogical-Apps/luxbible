'use client';

import { IconBrandAppleFilled, IconBrandGooglePlay } from '@tabler/icons-react';
import Link from 'next/link';
import { ReactElement, useEffect, useState } from 'react';

import { Button } from '@/components/ui/Button';
import { trackStoreNavigation } from '@/lib/analytics';
import { Campaign, getStoreUrl } from '@/lib/campaign';
import { getPreferredStore, StoreName } from '@/lib/store';
import { useCampaign } from '@/lib/useCampaign';

const stores = {
  'app-store': {
    title: 'App Store',
    icon: <IconBrandAppleFilled style={{ width: '100%', height: '100%' }} />,
  },
  'google-play': {
    title: 'Google Play',
    icon: <IconBrandGooglePlay style={{ width: '100%', height: '100%' }} />,
  },
} as const;

function StoreButton({
  store,
  href,
  campaign,
}: {
  store: StoreName;
  href: string;
  campaign?: Campaign;
}) {
  return (
    <Button asChild>
      <Link href={href} onClick={() => trackStoreNavigation(store, campaign)}>
        <span className="mr-2 h-4 w-4">{stores[store].icon}</span>
        {stores[store].title}
      </Link>
    </Button>
  );
}

export default function AppStoreButtons({
  appStoreUrl,
  appStoreProviderToken,
  googlePlayUrl,
}: {
  appStoreUrl?: string;
  appStoreProviderToken?: string;
  googlePlayUrl?: string;
}) {
  const [preferredStore, setPreferredStore] = useState<StoreName>();
  const campaign = useCampaign();
  useEffect(() => {
    setPreferredStore(getPreferredStore(navigator));
  }, []);

  const buttons: ReactElement[] = [];
  if (preferredStore === 'app-store' && appStoreUrl) {
    buttons.push(
      <StoreButton
        key="app-store"
        store="app-store"
        href={getStoreUrl({
          href: appStoreUrl,
          store: 'app-store',
          campaign,
          appleProviderToken: appStoreProviderToken,
        })}
        campaign={campaign}
      />,
    );
  } else if (preferredStore === 'google-play' && googlePlayUrl) {
    buttons.push(
      <StoreButton
        key="google-play"
        store="google-play"
        href={getStoreUrl({
          href: googlePlayUrl,
          store: 'google-play',
          campaign,
        })}
        campaign={campaign}
      />,
    );
  } else {
    if (appStoreUrl) {
      buttons.push(
        <StoreButton
          key="app-store"
          store="app-store"
          href={getStoreUrl({
            href: appStoreUrl,
            store: 'app-store',
            campaign,
            appleProviderToken: appStoreProviderToken,
          })}
          campaign={campaign}
        />,
      );
    }
    if (googlePlayUrl) {
      buttons.push(
        <StoreButton
          key="google-play"
          store="google-play"
          href={getStoreUrl({
            href: googlePlayUrl,
            store: 'google-play',
            campaign,
          })}
          campaign={campaign}
        />,
      );
    }
  }

  return <div className="flex flex-wrap flex-center gap-4">{buttons}</div>;
}
