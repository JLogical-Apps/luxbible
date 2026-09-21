import type { Metadata } from 'next';
import Link from 'next/link';

import Page from '@/components/layout/Page';
import { Button } from '@/components/ui/Button';
import { site } from '@/lib/site';

type Props = { params: { reference: string } };

const getReference = (value: string) =>
  /^[1-3]?[A-Za-z][A-Za-z0-9]*(?:\.\d+(?:\.\d+)?)(?:-[1-3]?[A-Za-z][A-Za-z0-9]*\.\d+(?:\.\d+)?)?(?: [1-3]?[A-Za-z][A-Za-z0-9]*(?:\.\d+(?:\.\d+)?)(?:-[1-3]?[A-Za-z][A-Za-z0-9]*\.\d+(?:\.\d+)?)?)*$/.test(value)
    ? value
    : null;

export function generateMetadata({ params }: Props): Metadata {
  const reference = getReference(params.reference);
  const title = reference ? `${reference} in Lux Bible` : 'Passage in Lux Bible';
  return {
    title,
    openGraph: {
      title,
      url: `https://app.luxbible.app/passage/${encodeURIComponent(params.reference)}`,
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
          Open this passage in Lux Bible. If the app is not installed, get it for free.
        </p>
        <div className="flex flex-wrap justify-center gap-4">
          <Button asChild>
            <Link href={site.appStoreUrl}>App Store</Link>
          </Button>
          <Button asChild>
            <Link href={site.googlePlayUrl}>Google Play</Link>
          </Button>
        </div>
      </div>
    </Page>
  );
}
