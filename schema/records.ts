import { authorRecord } from '@/schema/documents/author';
import { blogPostPageRecord } from '@/schema/documents/blog-post';
import { colorRecord } from '@/schema/documents/design/color';
import { colorPaletteRecord } from '@/schema/documents/design/color-palette';
import { formRecord } from '@/schema/documents/form';
import { inlineFormRecord } from '@/schema/documents/inline-form';
import { mediaRecord } from '@/schema/documents/media/media';
import { pageRecord } from '@/schema/documents/page';
import { getPageBlockRecord } from '@/schema/documents/page-block/page-block';
import { projectRecord } from '@/schema/documents/project';
import { serviceRecord } from '@/schema/documents/service';
import { sharedPageBlockRecord } from '@/schema/documents/shared/shared-page-block';
import { sharedPageSectionRecord } from '@/schema/documents/shared/shared-page-section';
import { homePageRecord } from '@/schema/documents/singletons/home';
import { settingsRecord } from '@/schema/documents/singletons/settings';
import { solutionRecord } from '@/schema/documents/solution';
import { testimonialRecord } from '@/schema/documents/testimonial';
import { actionRecord } from '@/schema/objects/action/action';
import { backgroundRecord } from '@/schema/objects/background/background-record';
import { ctaRecord } from '@/schema/objects/cta';
import { descriptionRecord } from '@/schema/objects/description';
import { faqRecord } from '@/schema/objects/faq';
import { featureRecord } from '@/schema/objects/feature';
import { formActionRecord } from '@/schema/objects/form-action/form-action';
import { formFieldRecord } from '@/schema/objects/form-field';
import { formFieldTypeRecord } from '@/schema/objects/form-field-type/form-field-type';
import { itemRecord } from '@/schema/objects/item';
import { menuItemRecord } from '@/schema/objects/menu-item';
import { pageOverrideRecord } from '@/schema/objects/page-override';
import { getPageSectionRecord } from '@/schema/objects/page-section/page-section';
import { timelineItemRecord } from '@/schema/objects/timeline-item';
import { SanityType } from '@/schema/sanity-type';

const RECORDS: SanityType<any>[] = [
  homePageRecord,
  settingsRecord,
  menuItemRecord,
  pageRecord,
  blogPostPageRecord,
  authorRecord,
  featureRecord,
  descriptionRecord,
  faqRecord,
  itemRecord,
  timelineItemRecord,
  testimonialRecord,
  ctaRecord,
  mediaRecord,
  sharedPageSectionRecord,
  sharedPageBlockRecord,
  getPageSectionRecord(),
  getPageBlockRecord(),
  actionRecord,
  colorRecord,
  colorPaletteRecord,
  formRecord,
  inlineFormRecord,
  formFieldRecord,
  formActionRecord,
  formFieldTypeRecord,
  pageOverrideRecord,
  backgroundRecord,
];

export function getRecords() {
  return RECORDS;
}
