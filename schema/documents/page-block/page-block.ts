import {
  AppStorePageBlock,
  appStorePageBlockRecord,
} from '@/schema/documents/page-block/app-store-page-block';
import {
  BlogPostsPageBlock,
  blogPostsPageBlockRecord,
} from '@/schema/documents/page-block/blog-posts-page-block';
import {
  ContactUsPageBlock,
  contactUsPageBlockRecord,
} from '@/schema/documents/page-block/contact-us-page-block';
import {
  CtaPageBlock,
  ctaPageBlockRecord,
} from '@/schema/documents/page-block/cta-page-block';
import {
  DescriptionListPageBlock,
  descriptionListPageBlockRecord,
} from '@/schema/documents/page-block/description-list-page-block';
import {
  FaqPageBlock,
  faqPageBlockRecord,
} from '@/schema/documents/page-block/faq-page-block';
import {
  FeatureListPageBlock,
  featureListPageBlockRecord,
} from '@/schema/documents/page-block/feature-list-page-block';
import {
  FormPageBlock,
  formPageBlockRecord,
} from '@/schema/documents/page-block/form-page-block';
import {
  InlineFormPageBlock, inlineFormPageBlockRecord
} from '@/schema/documents/page-block/inline-form-page-block';
import {
  ItemsListPageBlock,
  itemsListPageBlockRecord,
} from '@/schema/documents/page-block/items-list-page-block';
import {
  PromoListPageBlock,
  promoListPageBlockRecord,
} from '@/schema/documents/page-block/promo-list-page-block';
import {
  RichTextPageBlock,
  richTextPageBlockRecord,
} from '@/schema/documents/page-block/rich-text-page-block';
import {
  SharedPageBlockWrapper,
  sharedPageBlockWrapperRecord,
} from '@/schema/documents/page-block/shared-page-block-wrapper';
import {
  TestimonialPageBlock,
  testimonialPageBlockRecord,
} from '@/schema/documents/page-block/testimonial-page-block';
import {
  TimelinePageBlock,
  timelinePageBlockRecord,
} from '@/schema/documents/page-block/timeline-page-block';
import { IsElement } from '@/schema/mixins/is-element';
import { abstractRecord } from '@/schema/sanity-type';

export type PageBlock =
  | RichTextPageBlock
  | FeatureListPageBlock
  | DescriptionListPageBlock
  | FaqPageBlock
  | TimelinePageBlock
  | TestimonialPageBlock
  | PromoListPageBlock
  | ItemsListPageBlock
  | CtaPageBlock
  | AppStorePageBlock
  | BlogPostsPageBlock
  | FormPageBlock
  | InlineFormPageBlock
  | ContactUsPageBlock
  | SharedPageBlockWrapper;

export type PageBlockBase = {
  _type: string;
} & IsElement;

export function getPageBlockRecord({
  includeShared = true,
}: {
  includeShared?: boolean;
} = {}) {
  return abstractRecord({
    records: [
      richTextPageBlockRecord,
      featureListPageBlockRecord,
      descriptionListPageBlockRecord,
      itemsListPageBlockRecord,
      promoListPageBlockRecord,
      faqPageBlockRecord,
      timelinePageBlockRecord,
      testimonialPageBlockRecord,
      ctaPageBlockRecord,
      appStorePageBlockRecord,
      blogPostsPageBlockRecord,
      formPageBlockRecord,
      inlineFormPageBlockRecord,
      contactUsPageBlockRecord,
      ...(!includeShared ? [] : [sharedPageBlockWrapperRecord]),
    ],
  });
}
