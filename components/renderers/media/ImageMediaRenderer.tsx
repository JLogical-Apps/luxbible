'use client';

import { clsx } from 'clsx';
import Image from 'next/image';
import { CSSProperties } from 'react';

import { useSanityImage } from '@/sanity/loader/hooks';
import { ImageMedia } from '@/schema/documents/media/image-media';

export default function ImageMediaRenderer({
  className = 'rounded-2xl',
  media,
  priority = false,
  style,
  width,
  height,
  maxWidth,
}: {
  className?: string;
  media: ImageMedia;
  priority?: boolean;
  style?: CSSProperties;
  width?: number;
  height?: number;
  maxWidth?: number;
}) {
  const imageProps = useSanityImage(media.asset, { width, height, maxWidth });

  return (
    <>
      <Image
        {...imageProps}
        className={clsx(media.mobileAsset ? 'hidden md:block' : '', className)}
        alt={media.alt}
        style={{
          aspectRatio:
            width && height
              ? undefined
              : media.asset.metadata.dimensions.aspectRatio,
          ...style,
        }}
        sizes={
          width
            ? `${width}px`
            : maxWidth
              ? `(max-width: ${maxWidth}px) 100vw, ${maxWidth}px`
              : undefined
        }
        placeholder={media.blurPlaceholder ? 'blur' : undefined}
        blurDataURL={
          media.blurPlaceholder ? media.asset.metadata.lqip : undefined
        }
        priority={priority}
      />
      {media.mobileAsset && (
        <MobileImage
          className={className}
          media={media}
          priority={priority}
          style={style}
          width={width}
          height={height}
        />
      )}
    </>
  );
}

function MobileImage({
  className = 'rounded-2xl',
  media,
  priority = false,
  style,
  width,
  height,
  maxWidth,
}: {
  className?: string;
  media: ImageMedia;
  priority?: boolean;
  style?: CSSProperties;
  width?: number;
  height?: number;
  maxWidth?: number;
}) {
  const mobileAsset = media.mobileAsset!;

  const imageProps = useSanityImage(mobileAsset, {
    width,
    height,
    maxWidth: maxWidth ?? 767,
  });

  return (
    <Image
      {...imageProps}
      className={clsx('block md:hidden', className)}
      alt={media.alt}
      style={{
        aspectRatio:
          width && height
            ? undefined
            : mobileAsset.metadata.dimensions.aspectRatio,
        ...style,
      }}
      sizes={width ? `${width}px` : `767px`}
      placeholder={media.blurPlaceholder ? 'blur' : undefined}
      blurDataURL={
        media.blurPlaceholder ? mobileAsset.metadata.lqip : undefined
      }
      priority={priority}
    />
  );
}
