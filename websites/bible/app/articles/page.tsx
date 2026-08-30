import { Metadata } from 'next';

import ArticleIndexPage from '@/components/layout/ArticleIndexPage';
import { bibleStudyArticles } from '@/lib/articles';

export const metadata: Metadata = {
  title: 'Bible Study Articles',
  description:
    'Practical guides for reading Scripture carefully and studying it with confidence.',
};

export default function ArticlesPage() {
  return (
    <ArticleIndexPage
      tagline="Articles"
      title="Learn to study Scripture"
      subtitle="Practical guides for reading with purpose, understanding what you find, and growing in confidence as you study."
      articles={bibleStudyArticles}
    />
  );
}
