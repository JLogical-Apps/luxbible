import { ReactNode } from 'react';

import ArticleGrid from '@/components/blocks/ArticleGrid';
import Page from '@/components/layout/Page';
import { Article } from '@/lib/articles';

export default function ArticleIndexPage({
  tagline,
  title,
  subtitle,
  articles,
}: {
  tagline: string;
  title: ReactNode;
  subtitle: string;
  articles: Article[];
}) {
  return (
    <Page>
      <div className="container py-16 lg:py-20 xl:py-24">
        <header className="max-w-3xl">
          <p className="font-semibold text-foreground-soft">{tagline}</p>
          <h1 className="title-lg mt-3">{title}</h1>
          <p className="subtitle mt-6">{subtitle}</p>
        </header>
        <div className="mt-12 sm:mt-16">
          <ArticleGrid articles={articles} />
        </div>
      </div>
    </Page>
  );
}
