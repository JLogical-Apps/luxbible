import { ReactNode } from 'react';

import ArticleTableOfContents from '@/components/layout/ArticleTableOfContents';
import type { ArticleTableOfContentsItem } from '@/components/layout/ArticleTableOfContents';
import Page from '@/components/layout/Page';
import { Article } from '@/lib/articles';

export default function ArticlePage({
  article,
  children,
  tableOfContents = [],
}: {
  article: Article;
  children: ReactNode;
  tableOfContents?: ArticleTableOfContentsItem[];
}) {
  return (
    <Page>
      <article className="container max-w-4xl py-16 lg:py-20 xl:py-24">
        <header className="mx-auto max-w-3xl">
          <p className="font-semibold text-foreground-soft">
            {article.category}
          </p>
          <h1 className="title-lg mt-3">{article.title}</h1>
          <p className="subtitle mt-6">{article.description}</p>
        </header>

        <div className="relative mx-auto mt-12 max-w-3xl">
          {tableOfContents.length > 0 && (
            <aside className="absolute bottom-0 right-full top-0 mr-10 hidden w-52 xl:block">
              <ArticleTableOfContents items={tableOfContents} />
            </aside>
          )}

          <div className="prose prose-invert max-w-none prose-a:text-emphasis prose-headings:scroll-mt-24 prose-headings:font-serif prose-h2:border-b prose-h2:border-background-soft prose-h2:pb-4 prose-h2:text-3xl prose-h2:leading-tight prose-h3:border-l-2 prose-h3:border-emphasis prose-h3:pl-4 prose-h3:text-xl prose-h3:leading-snug sm:prose-h2:text-4xl sm:prose-h3:text-2xl">
            {children}
            <div className="clear-both" />
          </div>
        </div>
      </article>
    </Page>
  );
}
