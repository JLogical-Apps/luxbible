import { Metadata } from 'next';
import Link from 'next/link';
import React from 'react';

import { HomePageRenderer } from '@/app/(pages)/(home)/HomePageRenderer';
import PageWrapper from '@/components/page/PageWrapper';
import { generatePageMetadata } from '@/lib/router/router-utils';
import { studioUrl } from '@/sanity/lib/api';
import { loadHomePage, loadSettings } from '@/sanity/loader/loadQuery';

export async function generateMetadata(): Promise<Metadata> {
  return generatePageMetadata({ pageLoader: loadHomePage });
}

export default async function IndexRoute() {
  const [homePage, settings] = await Promise.all([
    loadHomePage(),
    loadSettings(),
  ]);

  if (!homePage.data || !settings.data) {
    return (
      <PageWrapper>
        <div className="text-center">
          You don&rsquo;t have a homepage yet,{' '}
          <Link href={`${studioUrl}/desk/home`} className="underline">
            create one now
          </Link>
          !
        </div>
      </PageWrapper>
    );
  }

  return <HomePageRenderer homePage={homePage.data} settings={settings.data} />;
}
