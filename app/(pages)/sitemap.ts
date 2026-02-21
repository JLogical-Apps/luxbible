import { MetadataRoute } from 'next';

import { loadLinkables, loadSettings } from '@/sanity/loader/loadQuery';

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const [{ data: settings }, { data: linkables }] = await Promise.all([
    loadSettings(),
    loadLinkables(),
  ]);

  if (!settings) {
    return [];
  }

  const host = settings.domain;

  return linkables.map((linkable) => ({
    url: `${host}${linkable.path}`,
    lastModified: new Date(),
    changeFrequency: 'daily',
    priority: 1.0,
  }));
}
