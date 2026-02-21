import { notFound } from 'next/navigation';

import { loadSettings } from '@/sanity/loader/loadQuery';

export async function GET(request: Request) {
  const { data: settings } = await loadSettings();

  if (!settings) {
    notFound();
  }

  return new Response(
    `
User-agent: *
Disallow: /studio

User-agent: *
Allow: /

Sitemap: ${settings.domain}/sitemap.xml
`,
    { status: 200 },
  );
}
