import type { Metadata } from 'next';

import AppStoreButtons from '@/components/blocks/AppStoreButtons';
import StoreRedirect from '@/components/blocks/StoreRedirect';
import Page from '@/components/layout/Page';
import { passageShareCampaign } from '@/lib/campaign';
import { site } from '@/lib/site';

type Props = { params: { reference: string } };

const getReference = (value: string) =>
  /^[1-3]?[A-Za-z][A-Za-z0-9]*(?:\.\d+(?:\.\d+)?)(?:-[1-3]?[A-Za-z][A-Za-z0-9]*\.\d+(?:\.\d+)?)?(?: [1-3]?[A-Za-z][A-Za-z0-9]*(?:\.\d+(?:\.\d+)?)(?:-[1-3]?[A-Za-z][A-Za-z0-9]*\.\d+(?:\.\d+)?)?)*$/.test(
    value,
  )
    ? value
    : null;

export function generateMetadata({ params }: Props): Metadata {
  const reference = getReference(params.reference);
  const title = reference
    ? `${reference} in Lux Bible`
    : 'Passage in Lux Bible';
  return {
    title,
    openGraph: {
      title,
      url: `https://app.luxbible.app/passage/${encodeURIComponent(
        params.reference,
      )}`,
    },
  };
}

export default function PassagePage({ params }: Props) {
  const reference = getReference(params.reference);

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
        <StoreRedirect
          appStoreUrl={site.appStoreUrl}
          appStoreProviderToken={site.appStoreProviderToken}
          googlePlayUrl={site.googlePlayUrl}
          defaultCampaign={passageShareCampaign}
        />
      </div>
    </Page>
  );
}
