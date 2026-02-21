import { vercelStegaCleanAll } from '@sanity/client/stega';

import { CustomPortableText } from '@/components/CustomPortableText';
import Layout from '@/components/layout/Layout';
import BackgroundRenderer from '@/components/renderers/BackgroundRenderer';
import CtaRenderer from '@/components/renderers/CtaRenderer';
import MediaRenderer from '@/components/renderers/media/MediaRenderer';
import PageBlockRenderer from '@/components/renderers/page-block/PageBlockRenderer';
import { Settings } from '@/schema/documents/singletons/settings';
import { PageSection } from '@/schema/objects/page-section/page-section';

export default function PageSectionRenderer({
  pageSection,
  settings,
  index,
}: {
  pageSection: PageSection;
  settings: Settings | null;
  index: number;
}) {
  switch (pageSection._type) {
    case 'sharedPageSectionWrapper':
      return (
        <PageSectionRenderer
          pageSection={{
            ...pageSection.pageSection,
            ...(pageSection.id ? { id: pageSection.id } : {}),
            ...(pageSection.background
              ? { background: pageSection.background }
              : {}),
          }}
          settings={settings}
          index={index}
        />
      );
    case 'oneOffPageSection':
      return (
        <section id={pageSection.id}>
          <BackgroundRenderer background={pageSection.background}>
            <div className="container py-16 lg:py-20 xl:py-24">
              <Layout
                smallAlignment={vercelStegaCleanAll(
                  pageSection.smallAlignment ?? 'start',
                )}
                alignment={vercelStegaCleanAll(
                  pageSection.alignment ?? 'center',
                )}
                mediaAlignment={vercelStegaCleanAll(
                  pageSection.mediaAlignment ?? 'right',
                )}
                mediaSize={vercelStegaCleanAll(pageSection.mediaSize ?? 'md')}
                titleSize={vercelStegaCleanAll(pageSection.titleSize ?? 'md')}
                title={
                  pageSection.title && (
                    <CustomPortableText value={pageSection.title} />
                  )
                }
                useH1={index == 0}
                subtitle={
                  pageSection.subtitle && (
                    <CustomPortableText value={pageSection.subtitle} />
                  )
                }
                belowSubtitle={
                  pageSection.ctas && (
                    <div className="flex flex-wrap gap-2">
                      {pageSection.ctas.map((cta, i) => (
                        <CtaRenderer key={i} cta={cta} />
                      ))}
                    </div>
                  )
                }
                tagline={
                  pageSection.tagline && (
                    <CustomPortableText value={pageSection.tagline} />
                  )
                }
                body={
                  pageSection.body && (
                    <CustomPortableText
                      inline={false}
                      value={pageSection.body}
                    />
                  )
                }
                media={
                  pageSection.media
                    ? (maxWidth) => (
                        <MediaRenderer
                          media={pageSection.media!}
                          priority={index == 0}
                          maxWidth={maxWidth}
                        />
                      )
                    : undefined
                }
              >
                {pageSection.blocks && (
                  <div className="flex flex-col gap-4">
                    {pageSection.blocks.map((pageBlock, i) => (
                      <PageBlockRenderer
                        key={i}
                        pageBlock={pageBlock}
                        settings={settings}
                      />
                    ))}
                  </div>
                )}
              </Layout>
            </div>
          </BackgroundRenderer>
        </section>
      );
    case 'containerPageSection':
      return (
        <section id={pageSection.id}>
          <BackgroundRenderer background={pageSection.background}>
            <div className="container py-16 lg:py-20 xl:py-24">
              <BackgroundRenderer
                background={pageSection.containerBackground}
                className="rounded-3xl px-4 md:px-6 py-16 w-full"
              >
                <Layout
                  smallAlignment={vercelStegaCleanAll(
                    pageSection.smallAlignment ?? 'start',
                  )}
                  alignment={vercelStegaCleanAll(
                    pageSection.alignment ?? 'center',
                  )}
                  titleSize={vercelStegaCleanAll(pageSection.titleSize ?? 'md')}
                  title={
                    pageSection.title && (
                      <CustomPortableText value={pageSection.title} />
                    )
                  }
                  subtitle={
                    pageSection.subtitle && (
                      <CustomPortableText value={pageSection.subtitle} />
                    )
                  }
                  tagline={
                    pageSection.tagline && (
                      <CustomPortableText value={pageSection.tagline} />
                    )
                  }
                  body={
                    pageSection.body && (
                      <CustomPortableText
                        inline={false}
                        value={pageSection.body}
                      />
                    )
                  }
                >
                  {pageSection.blocks && (
                    <div className="flex flex-col gap-4">
                      {pageSection.blocks.map((pageBlock, i) => (
                        <PageBlockRenderer
                          key={i}
                          pageBlock={pageBlock}
                          settings={settings}
                        />
                      ))}
                    </div>
                  )}
                </Layout>
              </BackgroundRenderer>
            </div>
          </BackgroundRenderer>
        </section>
      );
  }
}
