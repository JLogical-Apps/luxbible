import { Metadata } from 'next';

export type ArticleCategory = 'Bible Study';

export type Article = {
  slug: string;
  title: string;
  shortName: string;
  description: string;
  category: ArticleCategory;
  thumbnail: string;
};

export const soapArticle: Article = {
  slug: 'how-to-study-the-bible-with-soap',
  title: 'How to Study the Bible with the SOAP Method',
  shortName: 'Study the Bible with SOAP',
  description:
    'A simple four-step method for slowing down, understanding a passage, and putting it into practice.',
  category: 'Bible Study',
  thumbnail: '/media/articles/how-to-study-the-bible-with-soap/thumbnail.png',
};

export const noteTakingArticle: Article = {
  slug: 'how-to-take-bible-notes',
  title: 'How to Take Better Bible Notes',
  shortName: 'Take Better Bible Notes',
  description:
    'Build a Bible note-taking system around the way you read, reflect, and study Scripture.',
  category: 'Bible Study',
  thumbnail:
    '/media/articles/bible-word-study-without-greek-or-hebrew/thumbnail.png',
};

export const articles = [soapArticle, noteTakingArticle];

export const bibleStudyArticles = articles.filter(
  ({ category }) => category === 'Bible Study',
);

export function getArticleHref(article: Article) {
  return `/articles/${article.slug}`;
}

export function getArticleMetadata(article: Article): Metadata {
  const images = [
    {
      url: article.thumbnail,
      width: 1200,
      height: 630,
      alt: article.title,
    },
  ];

  return {
    title: article.title,
    description: article.description,
    openGraph: {
      title: article.title,
      description: article.description,
      images,
      type: 'article',
    },
    twitter: {
      title: article.title,
      description: article.description,
      images,
    },
  };
}
