import { Metadata } from 'next';
import { notFound } from 'next/navigation';

import ProjectPageRenderer from '@/app/(pages)/projects/[slug]/ProjectPageRenderer';
import { generatePageMetadata } from '@/lib/router/router-utils';
import { generateStaticSlugs } from '@/sanity/loader/generateStaticSlugs';
import { loadProject, loadSettings } from '@/sanity/loader/loadQuery';

type Props = {
  params: { slug: string };
};

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  return generatePageMetadata({ pageLoader: () => loadProject(params.slug) });
}

export function generateStaticParams() {
  return generateStaticSlugs('project');
}

export default async function PageSlugRoute({ params }: Props) {
  const [project, settings] = await Promise.all([
    loadProject(params.slug),
    loadSettings(),
  ]);

  if (!project.data || !settings.data) {
    notFound();
  }

  return (
    <ProjectPageRenderer project={project.data} settings={settings.data} />
  );
}
