'use client';

import {
  IconBrandAppleFilled,
  IconBrandGooglePlay,
  IconCloudFilled,
} from '@tabler/icons-react';
import Link from 'next/link';
import { ReactElement, useEffect, useState } from 'react';

import { Button } from '@/components/ui/Button';
import ColorPaletteWrapper from '@/components/util/ColorPaletteWrapper';
import { AppStorePageBlock } from '@/schema/documents/page-block/app-store-page-block';

export default function AppStoreDownloadPageBlockRenderer({
  pageBlock,
}: {
  pageBlock: AppStorePageBlock;
}) {
  const [userAgent, setUserAgent] = useState<string | undefined>();
  useEffect(() => {
    setUserAgent(navigator.userAgent);
  }, []);

  return (
    <div className="flex flex-center gap-4">
      <ColorPaletteWrapper
        colorPalette={pageBlock.buttonColorPalette}
        prefix="primary"
        includeBackground={false}
      >
        <div className="flex flex-row gap-4">
          {getCtas(pageBlock, userAgent)}
        </div>
      </ColorPaletteWrapper>
    </div>
  );
}

type StoreName = 'google-play' | 'app-store' | 'web-app';
type StoreInfo = {
  title: string;
  icon: ReactElement;
};

const stores: Record<StoreName, StoreInfo> = {
  'google-play': {
    title: 'Google Play',
    icon: <IconBrandGooglePlay style={{ width: '100%', height: '100%' }} />,
  },
  'app-store': {
    title: 'App Store',
    icon: <IconBrandAppleFilled style={{ width: '100%', height: '100%' }} />,
  },
  'web-app': {
    title: 'Web',
    icon: <IconCloudFilled style={{ width: '100%', height: '100%' }} />,
  },
};

function getCtas(pageBlock: AppStorePageBlock, userAgent?: string) {
  const { appStoreUrl, googlePlayUrl, webAppUrl } = pageBlock;

  const ctas: ReactElement[] = [];
  if (/iPhone|iPad|iPod/i.test(userAgent ?? '') && appStoreUrl) {
    ctas.push(createCta('app-store', appStoreUrl));
  } else if (/Android/i.test(userAgent ?? '') && googlePlayUrl) {
    ctas.push(createCta('google-play', googlePlayUrl));
  } else {
    if (appStoreUrl) {
      ctas.push(createCta('app-store', appStoreUrl));
    }
    if (googlePlayUrl) {
      ctas.push(createCta('google-play', googlePlayUrl));
    }
    if (webAppUrl) {
      ctas.push(createCta('web-app', webAppUrl));
    }
  }

  return ctas;
}

function createCta(storeName: StoreName, url: string) {
  const storeInfo = stores[storeName];
  return (
    <Button key={storeName} asChild>
      <Link href={url}>
        {<span className="mr-2 h-4 w-4">{storeInfo.icon}</span>}
        {storeInfo.title}
      </Link>
    </Button>
  );
}
