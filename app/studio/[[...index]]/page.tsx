/**
 * This route is responsible for the built-in authoring environment using Sanity Studio v3.
 * All routes under /studio will be handled by this file using Next.js' catch-all routes:
 * https://nextjs.org/docs/routing/dynamic-routes#catch-all-routes
 *
 * You can learn more about the next-sanity package here:
 * https://github.com/sanity-io/next-sanity
 */

import { Metadata } from 'next';
import { metadata as studioMetadata } from 'next-sanity/studio/metadata';

import Studio from './Studio';

export const dynamic = 'force-static';

export { viewport } from 'next-sanity/studio/viewport';

export const metadata: Metadata = {
  ...studioMetadata,
  icons: {
    icon: 'https://www.sanity.io/static/images/logo_rounded_square.png',
  },
};

export default function StudioPage() {
  return <Studio />;
}
