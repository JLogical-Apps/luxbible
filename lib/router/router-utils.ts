import { QueryResponseInitial } from '@sanity/react-loader';
import { Metadata } from 'next';

import { urlForImage } from '@/sanity/lib/utils';
import { loadSettings } from '@/sanity/loader/loadQuery';
import { HasSeo } from '@/schema/mixins/has-seo';

export async function generatePageMetadata({
  pageLoader,
}: {
  pageLoader: () => Promise<QueryResponseInitial<HasSeo | null>>;
}): Promise<Metadata> {
  const [{ data: page }, { data: settings }] = await Promise.all([
    pageLoader(),
    loadSettings(),
  ]);

  const favicon =
    page?.faviconOverride ?? settings?.faviconOverride ?? settings?.logo;
  const openGraphImage =
    page?.openGraphOverride ?? settings?.openGraphOverride ?? settings?.logo;

  const globalKeywords = settings?.seoKeywords?.split(',') || [];
  const pageKeywords = page?.seoKeywords?.split(',') || [];
  const combinedKeywords = Array.from(
    new Set([...globalKeywords, ...pageKeywords]),
  ).join(',');

  return {
    title: page?.seoTitle ?? settings?.seoTitle ?? settings?.brandName,
    description: page?.seoDescription ?? settings?.seoDescription,
    keywords: combinedKeywords,
    icons: {
      icon: favicon?.asset.url,
    },
    openGraph: {
      images: openGraphImage
        ? urlForImage(openGraphImage.asset)
            ?.width(1200)
            .height(630)
            .fit('fill')
            .bg('0000')
            .ignoreImageParams()
            .url()
        : undefined,
    },
    metadataBase: settings?.domain ? new URL(settings.domain) : undefined,
  };
}
