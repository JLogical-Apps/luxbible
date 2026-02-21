import { Metadata } from 'next';
import { notFound } from 'next/navigation';

import BlogPostRenderer from '@/app/(pages)/blog/[slug]/BlogPostRenderer';
import { generatePageMetadata } from '@/lib/router/router-utils';
import { generateStaticSlugs } from '@/sanity/loader/generateStaticSlugs';
import { loadBlogPost, loadSettings } from '@/sanity/loader/loadQuery';

type Props = {
  params: { slug: string };
};

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  return generatePageMetadata({ pageLoader: () => loadBlogPost(params.slug) });
}

export function generateStaticParams() {
  return generateStaticSlugs('blogPost');
}

export default async function PageSlugRoute({ params }: Props) {
  const [blogPost, settings] = await Promise.all([
    loadBlogPost(params.slug),
    loadSettings(),
  ]);

  if (!blogPost.data || !settings.data) {
    notFound();
  }

  return <BlogPostRenderer blogPost={blogPost.data} settings={settings.data} />;
}
