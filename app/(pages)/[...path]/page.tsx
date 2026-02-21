import { Metadata } from 'next';
import { notFound } from 'next/navigation';

import { PageRenderer } from '@/app/(pages)/[...path]/PageRenderer';
import { generatePageMetadata } from '@/lib/router/router-utils';
import { generateStaticSlugs } from '@/sanity/loader/generateStaticSlugs';
import { loadPage, loadSettings } from '@/sanity/loader/loadQuery';

type Props = {
  params: { path: string[] };
};

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  return generatePageMetadata({ pageLoader: () => loadPage(params.path) });
}

export function generateStaticParams() {
  return generateStaticSlugs('page');
}

export default async function PageSlugRoute({ params }: Props) {
  const [page, settings] = await Promise.all([
    loadPage(params.path),
    loadSettings(),
  ]);

  if (!page.data || !settings.data) {
    notFound();
  }

  return <PageRenderer page={page.data} settings={settings.data} />;
}
