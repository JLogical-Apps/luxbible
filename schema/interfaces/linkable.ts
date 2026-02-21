import { SanityDocument } from 'sanity';

import { client } from '@/sanity/lib/client';
import { BlogPostPage } from '@/schema/documents/blog-post';
import { Page } from '@/schema/documents/page';
import { Project } from '@/schema/documents/project';
import { Service } from '@/schema/documents/service';
import { HomePage } from '@/schema/documents/singletons/home';
import { Solution } from '@/schema/documents/solution';
import {
  createImplementation,
  SanityImplementation,
} from '@/schema/sanity-interface';

export interface Linkable {
  path: string;
  linkableText: string;
}

export const linkableImplementations: Array<SanityImplementation<Linkable>> = [
  createImplementation<HomePage, Linkable>({
    type: 'home',
    queryPart: `
      "path": '/',
      "linkableText": "Home",
    `,
    instantiate() {
      return {
        path: '/',
        linkableText: 'Home',
      };
    },
    async instantiateDocument() {
      return {
        path: '/',
        linkableText: 'Home',
      };
    },
  }),
  createImplementation<Page, Linkable>({
    type: 'page',
    queryPart: `
      "path": coalesce(parent->{"path": "/" + slug.current}.path, "") + "/" + slug.current,
      "linkableText": name,
    `,
    instantiate(obj: Record<string, any> & { _type: string }) {
      return {
        path: `${obj.parent ? `/${obj.parent.slug}` : ''}/${obj.slug}`,
        linkableText: obj.name,
      };
    },
    async instantiateDocument(document: SanityDocument) {
      const parentRef = (
        document.parent as
          | {
              _ref: string | undefined;
            }
          | undefined
      )?._ref;
      const parent = parentRef
        ? await client.fetch<
            | {
                slug: string | undefined;
              }
            | undefined
          >(
            '*[_type == "page" && _id == $id][0]{"slug": slug.current}',
            {
              id: parentRef,
            },
            {},
          )
        : undefined;

      const path = `${parent ? `/${parent.slug}` : ''}/${getSlugFromDocument(
        document,
      )}`;

      return {
        path,
        linkableText: document.name as string,
      };
    },
  }),
  createImplementation<BlogPostPage, Linkable>({
    type: 'blogPost',
    queryPart: `
      "path": "/blog/" + slug.current,
      "linkableText": name,
    `,
    instantiate(blogPost: BlogPostPage) {
      return {
        path: `/blog/${blogPost.slug}`,
        linkableText: blogPost.title,
      };
    },
    async instantiateDocument(document: SanityDocument) {
      return {
        path: `/blog/${getSlugFromDocument(document)}`,
        linkableText: document.title as string,
      };
    },
  }),
];

export const linkableTypes = linkableImplementations.map((implementation) => ({
  type: implementation.type,
}));

function getSlugFromDocument(document: SanityDocument) {
  return (document['slug'] as { current: string } | undefined)?.current;
}
