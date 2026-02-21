import { mediaRecord } from '@/schema/documents/media/media';

export const mediaField = {
  name: 'media',
  title: 'Media',
  type: 'reference',
  to: mediaRecord.typeOption,
};
