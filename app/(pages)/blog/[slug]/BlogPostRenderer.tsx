import { CustomPortableText } from '@/components/CustomPortableText';
import Layout from '@/components/layout/Layout';
import PageFooter from '@/components/page/PageFooter';
import PageHeader from '@/components/page/PageHeader';
import PageWrapper from '@/components/page/PageWrapper';
import ImageMediaRenderer from '@/components/renderers/media/ImageMediaRenderer';
import PageSectionRenderer from '@/components/renderers/PageSectionRenderer';
import { formatDate } from '@/sanity/lib/utils';
import { BlogPostPage } from '@/schema/documents/blog-post';
import { Settings } from '@/schema/documents/singletons/settings';
import { getPageOverrideFromType } from '@/schema/objects/page-override';

export interface BlogPostProps {
  blogPost: BlogPostPage | null;
  settings: Settings | null;
}

export default function BlogPostRenderer({
  blogPost,
  settings,
}: BlogPostProps) {
  const bottomSections = settings
    ? getPageOverrideFromType({
        pageType: 'blogPost',
        pageOverrides: settings.pageOverrides,
      })?.bottomSections
    : undefined;
  return (
    <PageWrapper
      colorPalette={blogPost?.colorPalette ?? settings?.colorPalette}
      primaryColorPalette={settings?.primaryColorPalette}
      className="flex flex-col min-h-screen"
    >
      {settings && <PageHeader settings={settings} />}
      <main className="flex-1 flex-grow">
        <section className="bg-background text-foreground">
          <div className="container py-16 lg:py-20 xl:py-24">
            <Layout
              title={blogPost?.title}
              subtitle={blogPost?.subtitle}
              belowSubtitle={
                <div className="flex flex-row items-center justify-start gap-2">
                  {blogPost?.author?.profilePicture && (
                    <ImageMediaRenderer
                      className="rounded-full flex-shrink-0"
                      media={blogPost.author.profilePicture}
                      width={48}
                      height={48}
                      style={{ aspectRatio: '1/1' }}
                      priority
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
              }
              titleSize="lg"
              media={
                blogPost?.thumbnail
                  ? (maxWidth) => (
                      <ImageMediaRenderer
                        media={blogPost?.thumbnail}
                        priority
                        maxWidth={maxWidth}
                      />
                    )
                  : undefined
              }
              mediaAlignment="right"
              alignment="start"
              mediaSize="sm"
            >
              <div className="max-w-4xl mx-auto">
                <CustomPortableText value={blogPost?.body} inline={false} />
              </div>
            </Layout>
          </div>
        </section>
        {bottomSections &&
          bottomSections.map((section, i) => (
            <PageSectionRenderer
              key={i}
              pageSection={section}
              index={i}
              settings={settings}
            />
          ))}
      </main>
      {settings && <PageFooter settings={settings} />}
    </PageWrapper>
  );
}
