import { getPageSectionRecord } from '../objects/page-section/page-section';

export const contentField = {
  type: 'array',
  of: getPageSectionRecord().typeOption,
};
