import createImageUrlBuilder from '@sanity/image-url';
import { SanityAsset } from '@sanity/image-url/lib/types/types';

import { dataset, projectId } from '@/sanity/lib/api';

const imageBuilder = createImageUrlBuilder({
  projectId: projectId || '',
  dataset: dataset || '',
});

export const urlForImage = (source: string | SanityAsset) => {
  return imageBuilder?.image(source).auto('format').fit('max');
};

export function urlForOpenGraphImage(image: string | SanityAsset) {
  return urlForImage(image)?.width(1200).height(627).fit('crop').url();
}

export function formatDate(dateTime: string) {
  const options: Intl.DateTimeFormatOptions = {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  };

  return new Intl.DateTimeFormat('en-US', options).format(new Date(dateTime));
}
