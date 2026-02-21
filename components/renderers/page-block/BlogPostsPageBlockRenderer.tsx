'use client';

import Link from 'next/link';

import ImageMediaRenderer from '@/components/renderers/media/ImageMediaRenderer';
import { Button } from '@/components/ui/Button';
import { Skeleton } from '@/components/ui/skeleton';
import { formatDate } from '@/sanity/lib/utils';
import { useQuery } from '@/sanity/loader/useQuery';
import { blogPostPageRecord } from '@/schema/documents/blog-post';
import { BlogPostsPageBlock } from '@/schema/documents/page-block/blog-posts-page-block';

export default function BlogPostsPageBlockRenderer({
  pageBlock,
}: {
  pageBlock: BlogPostsPageBlock;
}) {
  const blogPosts = useQuery(
    blogPostPageRecord.fetchAll({
      end: pageBlock.amount ? pageBlock.amount - 1 : undefined,
      orderBy: 'published desc',
    }),
    {},
    undefined,
    true,
  );

  if (blogPosts.loading) {
    return <BlogPostsPageBlockSkeleton />;
  }

  return (
    <>
      <div className="flex flex-wrap justify-center items-stretch gap-8">
        {blogPosts.data.map((blogPost) => (
          <div key={blogPost.slug} className="flex flex-col max-w-96 gap-2">
            {blogPost.thumbnail && (
              <Link href={`/blog/${blogPost.slug}`}>
                <ImageMediaRenderer
                  media={blogPost.thumbnail}
                  width={384}
                  height={205}
                />
              </Link>
            )}
            <Link href={`/blog/${blogPost.slug}`} className="no-underline">
              {blogPost.title}
            </Link>
            <p className="text-foreground-soft text-sm">{blogPost.subtitle}</p>
            <div className="flex flex-row items-center justify-start gap-2 mt-3">
              {blogPost?.author?.profilePicture && (
                <ImageMediaRenderer
                  className="rounded-full flex-shrink-0"
                  media={blogPost.author.profilePicture}
                  width={48}
                  height={48}
                  style={{ aspectRatio: '1/1' }}
                />
              )}

              <div>
                <p>{blogPost?.author?.name}</p>
                {blogPost?.published && (
                  <p className="text-sm text-foreground-soft">
                    Published {formatDate(blogPost.published)}
                  </p>
                )}
              </div>
            </div>
          </div>
        ))}
      </div>
      {pageBlock.showAllPage && (
        <Button variant="outline" size="lg" className="mt-8 mx-auto" asChild>
          <Link href={pageBlock.showAllPage.path}>Show All</Link>
        </Button>
      )}
    </>
  );
}

function BlogPostsPageBlockSkeleton() {
  return (
    <div className="flex flex-wrap justify-center items-stretch gap-8">
      {[...new Array(3)].map((_, i) => (
        <div key={i} className="flex flex-col max-w-96 gap-4">
          <Skeleton className="w-[384px] h-[205px] rounded-2xl" />
          <Skeleton className="w-[200px] h-4" />
          <Skeleton className="w-[200px] h-8" />
          <div className="flex flex-row items-center justify-start gap-2">
            <Skeleton className="w-[48px] h-[48px]" />
            <div className="gap-2">
              <Skeleton className="w-[120px] h-4" />
              <Skeleton className="w-[120px] h-3" />
            </div>
          </div>
        </div>
      ))}
    </div>
  );
}
