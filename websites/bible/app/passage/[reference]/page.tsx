import type { Metadata } from 'next';

import AppStoreButtons from '@/components/blocks/AppStoreButtons';
import AndroidAppRedirect from '@/components/blocks/AndroidAppRedirect';
import Page from '@/components/layout/Page';
import { passageShareCampaign } from '@/lib/campaign';
import { formatPassage } from '@/lib/passage';
import { site } from '@/lib/site';

type Props = { params: { reference: string } };

// An empty list makes every passage render on its first request and cache from then on.
export const generateStaticParams = () => [];

export function generateMetadata({ params }: Props): Metadata {
  const reference = formatPassage(decodeURIComponent(params.reference));
  const title = reference
    ? `${reference} in Lux Bible`
    : 'Passage in Lux Bible';
  const url = `https://app.luxbible.app/passage/${encodeURIComponent(
    params.reference,
  )}`;
  return {
    title,
    openGraph: { title, url },
    itunes: { appId: site.appStoreId, appArgument: url },
  };
}

export default function PassagePage({ params }: Props) {
  const reference = formatPassage(decodeURIComponent(params.reference));

  return (
    <Page>
      <div className="container flex flex-col items-center gap-6 py-32 text-center">
        <h1 className="title-lg">
          {reference ? `Read ${reference} in Lux Bible` : 'Read in Lux Bible'}
        </h1>
        <p className="subtitle">
          Open this passage in Lux Bible. If the app is not installed, get it
          for free.
        </p>
        <AppStoreButtons
          appStoreUrl={site.appStoreUrl}
          appStoreProviderToken={site.appStoreProviderToken}
          googlePlayUrl={site.googlePlayUrl}
          defaultCampaign={passageShareCampaign}
        />
        <AndroidAppRedirect
          googlePlayUrl={site.googlePlayUrl}
          defaultCampaign={passageShareCampaign}
        />
      </div>
    </Page>
  );
}
