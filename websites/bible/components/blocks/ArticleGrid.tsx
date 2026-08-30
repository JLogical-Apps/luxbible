import ArticleCard from '@/components/blocks/ArticleCard';
import { Article } from '@/lib/articles';

export default function ArticleGrid({ articles }: { articles: Article[] }) {
  return (
    <div className="grid gap-12 md:grid-cols-2">
      {articles.map((article) => (
        <ArticleCard key={article.slug} article={article} />
      ))}
    </div>
  );
}
