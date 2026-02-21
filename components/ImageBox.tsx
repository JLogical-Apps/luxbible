import Image from 'next/image';

import { urlForImage } from '@/sanity/lib/utils';

interface ImageBoxProps {
  image?: { asset?: any };
  alt?: string;
  width?: number;
  height?: number;
  size?: string;
  classesWrapper?: string;
  'data-sanity'?: string;
  priority?: boolean;
}

export default function ImageBox({
  image,
  alt = 'Cover image',
  width = 3500,
  height = 2000,
  size = '100vw',
  classesWrapper,
  priority,
  ...props
}: ImageBoxProps) {
  const imageUrl =
    image && urlForImage(image)?.height(height).width(width).fit('crop').url();

  return (
    <div
      className={`w-full overflow-hidden rounded-[3px] bg-gray-50 ${classesWrapper}`}
      data-sanity={props['data-sanity']}
    >
      {imageUrl && (
        <Image
          alt={alt}
          width={width}
          height={height}
          sizes={size}
          src={imageUrl}
          priority={priority}
        />
      )}
    </div>
  );
}
