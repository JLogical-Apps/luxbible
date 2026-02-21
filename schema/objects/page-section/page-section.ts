import {
  ContainerPageSection,
  containerPageSectionRecord,
} from '@/schema/objects/page-section/container-page-section';
import {
  OneOffPageSection,
  oneOffPageSectionRecord,
} from '@/schema/objects/page-section/one-off-page-section';
import {
  SharedPageSectionWrapper,
  sharedPageSectionWrapperRecord,
} from '@/schema/objects/page-section/shared-page-section-wrapper';
import { abstractRecord } from '@/schema/sanity-type';

export type PageSection =
  | OneOffPageSection
  | ContainerPageSection
  | SharedPageSectionWrapper;

export type PageSectionBase = {
  _type: string;
};

export function getPageSectionRecord({
  includeShared = true,
}: {
  includeShared?: boolean;
} = {}) {
  return abstractRecord({
    records: [
      oneOffPageSectionRecord,
      containerPageSectionRecord,
      ...(!includeShared ? [] : [sharedPageSectionWrapperRecord]),
    ],
  });
}
