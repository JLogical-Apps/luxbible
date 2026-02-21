import { Metadata } from 'next';
import { notFound } from 'next/navigation';

import SolutionPageRenderer from '@/app/(pages)/solutions/[slug]/SolutionPageRenderer';
import { generatePageMetadata } from '@/lib/router/router-utils';
import { generateStaticSlugs } from '@/sanity/loader/generateStaticSlugs';
import { loadSettings, loadSolution } from '@/sanity/loader/loadQuery';

type Props = {
  params: { slug: string };
};

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  return generatePageMetadata({ pageLoader: () => loadSolution(params.slug) });
}

export function generateStaticParams() {
  return generateStaticSlugs('solution');
}

export default async function PageSlugRoute({ params }: Props) {
  const [solution, settings] = await Promise.all([
    loadSolution(params.slug),
    loadSettings(),
  ]);

  if (!solution.data || !settings.data) {
    notFound();
  }

  return (
    <SolutionPageRenderer solution={solution.data} settings={settings.data} />
  );
}
