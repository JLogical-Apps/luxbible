import 'server-only';

import * as queryStore from '@sanity/react-loader';
import { draftMode } from 'next/headers';
import { QueryParams } from 'sanity';

import { client } from '@/sanity/lib/client';
import { readToken } from '@/sanity/lib/token';
import { blogPostPageRecord } from '@/schema/documents/blog-post';
import { formRecord } from '@/schema/documents/form';
import { inlineFormRecord } from '@/schema/documents/inline-form';
import { pageRecord } from '@/schema/documents/page';
import { projectRecord } from '@/schema/documents/project';
import { serviceRecord } from '@/schema/documents/service';
import { homePageRecord } from '@/schema/documents/singletons/home';
import { settingsRecord } from '@/schema/documents/singletons/settings';
import { solutionRecord } from '@/schema/documents/solution';
import {
  Linkable,
  linkableImplementations,
  linkableTypes,
} from '@/schema/interfaces/linkable';
import { getInterfaceQuery } from '@/schema/sanity-interface';

import Query from '../lib/query';

const serverClient = client.withConfig({
  token: readToken,
  stega: {
    // Enable stega if it's a Vercel preview deployment, as the Vercel Toolbar has controls that shows overlays
    enabled: process.env.VERCEL_ENV === 'preview',
  },
});

/**
 * Sets the server client for the query store, doing it here ensures that all data fetching in production
 * happens on the server and not on the client.
 * Live mode in `sanity/presentation` still works, as it uses the `useLiveMode` hook to update `useQuery` instances with
 * live draft content using `postMessage`.
 */
queryStore.setServerClient(serverClient);

const usingCdn = serverClient.config().useCdn;

export async function loadQuery<Input extends QueryParams, Output>(
  query: Query<Input, Output>,
  params: Input,
  options = {},
): Promise<queryStore.QueryResponseInitial<Output>> {
  return await loadRawQuery<Output>(query.query, params, options);
}

// Automatically handle draft mode
export const loadRawQuery = ((query, params = {}, options = {}) => {
  const {
    perspective = draftMode().isEnabled ? 'previewDrafts' : 'published',
  } = options;
  // Don't cache by default
  let revalidate: NextFetchRequestConfig['revalidate'] = 0;
  // If `next.tags` is set, and we're not using the CDN, then it's safe to cache
  if (
    (process.env.NODE_ENV === 'production' || perspective === 'published') &&
    !usingCdn &&
    Array.isArray(options.next?.tags)
  ) {
    revalidate = false;
  }

  return queryStore.loadQuery(query, params, {
    ...options,
    next: {
      revalidate,
      ...(options.next || {}),
    },
    perspective,
  });
}) satisfies typeof queryStore.loadQuery;

/**
 * Loaders that are used in more than one place are declared here, otherwise they're colocated with the component
 */

export function loadHomePage() {
  return loadQuery(
    homePageRecord.fetchFirst({}),
    {},
    { next: { tags: ['home'] } },
  );
}

export function loadPage(path: string[]) {
  const hasParent = path.length == 2;
  if (hasParent) {
    return loadQuery(
      pageRecord.fetchFirst<{
        parentSlug: string | undefined;
        slug: string | undefined;
      }>({
        condition:
          'parent->slug.current == $parentSlug && slug.current == $slug',
      }),
      { parentSlug: path[0], slug: path[1] },
      { next: { tags: [`page:${path[1]}`] } },
    );
  } else {
    return loadQuery(
      pageRecord.fetchFirst<{
        slug: string | undefined;
      }>({ condition: 'slug.current == $slug' }),
      { slug: path[0] },
      { next: { tags: [`page:${path[0]}`] } },
    );
  }
}

export function loadBlogPost(slug: string) {
  return loadQuery(
    blogPostPageRecord.fetchFirst({ condition: 'slug.current == $slug' }),
    { slug },
    { next: { tags: [`blogPost:${slug}`] } },
  );
}

export function loadProject(slug: string) {
  return loadQuery(
    projectRecord.fetchFirst({ condition: 'slug.current == $slug' }),
    { slug },
    { next: { tags: [`project:${slug}`] } },
  );
}

export function loadService(slug: string) {
  return loadQuery(
    serviceRecord.fetchFirst({ condition: 'slug.current == $slug' }),
    { slug },
    { next: { tags: [`service:${slug}`] } },
  );
}

export function loadSolution(slug: string) {
  return loadQuery(
    solutionRecord.fetchFirst({ condition: 'slug.current == $slug' }),
    { slug },
    { next: { tags: [`solution:${slug}`] } },
  );
}

export function loadSettings() {
  return loadQuery(
    settingsRecord.fetchFirst({}),
    {},
    { next: { tags: ['settings'] } },
  );
}

export function loadForm({ id }: { id: string }) {
  return loadQuery(
    formRecord.fetchFirst({ condition: `_id == $id` }),
    { id },
    { next: { tags: [`form:${id}`] } },
  );
}

export function loadInlineForm({ id }: { id: string }) {
  return loadQuery(
    inlineFormRecord.fetchFirst({ condition: `_id == $id` }),
    { id },
    { next: { tags: [`inlineForm:${id}`] } },
  );
}

export function loadLinkables() {
  return loadQuery<{}, Linkable[]>(
    {
      query: `*[_type in [${linkableTypes
        .map((e) => `"${e.type}"`)
        .join(',')}]]{${getInterfaceQuery(linkableImplementations)}}`,
    },
    {},
    {
      next: {
        tags: [],
      },
    },
  );
}
