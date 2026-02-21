import { Metadata } from 'next';
import { notFound } from 'next/navigation';

import ServicePageRenderer from '@/app/(pages)/services/[slug]/ServicePageRenderer';
import { generatePageMetadata } from '@/lib/router/router-utils';
import { generateStaticSlugs } from '@/sanity/loader/generateStaticSlugs';
import { loadService, loadSettings } from '@/sanity/loader/loadQuery';

type Props = {
  params: { slug: string };
};

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  return generatePageMetadata({ pageLoader: () => loadService(params.slug) });
}

export function generateStaticParams() {
  return generateStaticSlugs('service');
}

export default async function PageSlugRoute({ params }: Props) {
  const [service, settings] = await Promise.all([
    loadService(params.slug),
    loadSettings(),
  ]);

  if (!service.data || !settings.data) {
    notFound();
  }

  return (
    <ServicePageRenderer service={service.data} settings={settings.data} />
  );
}
