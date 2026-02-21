import AppStoreDownloadPageBlockRenderer
  from '@/components/renderers/page-block/AppStoreDownloadPageBlockRenderer';
import BlogPostsPageBlockRenderer
  from '@/components/renderers/page-block/BlogPostsPageBlockRenderer';
import ContactUsPageBlockRenderer
  from '@/components/renderers/page-block/ContactUsPageBlockRenderer';
import CtaPageBlockRenderer
  from '@/components/renderers/page-block/CtaPageBlockRenderer';
import DescriptionListPageBlockRenderer
  from '@/components/renderers/page-block/DescriptionListPageBlockRenderer';
import FaqPageBlockRenderer
  from '@/components/renderers/page-block/FaqPageBlockRenderer';
import FeatureListPageBlockRenderer
  from '@/components/renderers/page-block/FeatureListPageBlockRenderer';
import FormPageBlockRenderer
  from '@/components/renderers/page-block/FormPageBlockRenderer';
import InlineFormPageBlockRenderer
  from '@/components/renderers/page-block/InlineFormPageBlockRenderer';
import ItemsListPageBlockRenderer
  from '@/components/renderers/page-block/ItemsListPageBlockRenderer';
import RichTextPageBlockRenderer
  from '@/components/renderers/page-block/RichTextPageBlockRenderer';
import TestimonialPageBlockRenderer
  from '@/components/renderers/page-block/TestimonialPageBlockRenderer';
import TimelinePageBlockRenderer
  from '@/components/renderers/page-block/TimelinePageBlockRenderer';
import { PageBlock } from '@/schema/documents/page-block/page-block';
import { Settings } from '@/schema/documents/singletons/settings';

export default function PageBlockRenderer({
  pageBlock,
  settings,
}: {
  pageBlock: PageBlock;
  settings: Settings | null;
}) {
  switch (pageBlock._type) {
    case 'sharedPageBlockWrapper':
      return (
        <PageBlockRenderer
          pageBlock={pageBlock.pageBlock}
          settings={settings}
        />
      );

    case 'richTextPageBlock':
      return <RichTextPageBlockRenderer pageBlock={pageBlock} />;
    case 'featureListPageBlock':
      return <FeatureListPageBlockRenderer pageBlock={pageBlock} />;
    case 'descriptionListPageBlock':
      return <DescriptionListPageBlockRenderer pageBlock={pageBlock} />;
    case 'faqPageBlock':
      return <FaqPageBlockRenderer pageBlock={pageBlock} />;
    case 'timelinePageBlock':
      return <TimelinePageBlockRenderer pageBlock={pageBlock} />;
    case 'testimonialPageBlock':
      return <TestimonialPageBlockRenderer pageBlock={pageBlock} />;
    case 'itemsListPageBlock':
      return <ItemsListPageBlockRenderer pageBlock={pageBlock} />;
    case 'ctaPageBlock':
      return <CtaPageBlockRenderer pageBlock={pageBlock} />;
    case 'appStorePageBlock':
      return <AppStoreDownloadPageBlockRenderer pageBlock={pageBlock} />;
    case 'blogPostsPageBlock':
      return <BlogPostsPageBlockRenderer pageBlock={pageBlock} />;
    case 'formPageBlock':
      return <FormPageBlockRenderer pageBlock={pageBlock} />;
    case 'inlineFormPageBlock':
      return <InlineFormPageBlockRenderer pageBlock={pageBlock} />;
    case 'contactUsPageBlock':
      return (
        <ContactUsPageBlockRenderer pageBlock={pageBlock} settings={settings} />
      );
  }
}
