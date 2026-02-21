import { createClient } from '@sanity/client';
import { SanityImageSource } from '@sanity/image-url/lib/types/types';
import { useNextSanityImage } from 'next-sanity-image';

import { apiVersion, dataset, projectId } from '@/sanity/lib/api';

const client = createClient({
  projectId,
  dataset,
  apiVersion,
  useCdn: true,
});

export function useSanityImage(
  image: SanityImageSource,
  {
    width,
    height,
    maxWidth = 1920,
  }: {
    width?: number;
    height?: number;
    maxWidth?: number;
  },
) {
  return useNextSanityImage(
    client,
    image,

    {
      imageBuilder: (imageBuilder, options) => {
        imageBuilder = imageBuilder
          .dpr(
            (width && width < 80) ||
              (maxWidth && maxWidth < 80) ||
              (height && height < 80)
              ? 2
              : 1.5,
          )
          .quality(
            (width && width < 80) ||
              (maxWidth && maxWidth < 80) ||
              (height && height < 80)
              ? 50
              : 80,
          )
          .fit('clip');

        if (width) {
          imageBuilder = imageBuilder.width(width);
        } else if (!height) {
          if (options.width) {
            imageBuilder = imageBuilder.width(
              Math.min(
                options.width,
                options.originalImageDimensions.width,
                maxWidth ?? 1920,
              ),
            );
          } else {
            imageBuilder = imageBuilder.width(
              Math.min(maxWidth ?? 1920, options.originalImageDimensions.width),
            );
          }
        }

        if (height) {
          imageBuilder = imageBuilder.height(height);
        }

        if (options.quality) {
          imageBuilder = imageBuilder.quality(options.quality);
        }

        return imageBuilder;
      },
    },
  );
}
