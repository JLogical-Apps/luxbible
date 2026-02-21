import { clsx } from 'clsx';
import React, { ReactNode } from 'react';

import { Alignment } from '@/schema/fields/alignment-field';
import { MediaAlignment } from '@/schema/fields/media-alignment-field';
import { Size } from '@/schema/fields/size-field';

export default function Layout({
  title,
  useH1 = false,
  subtitle,
  belowSubtitle,
  body,
  tagline,
  media,
  alignment = 'center',
  smallAlignment = 'start',
  titleSize = 'md',
  mediaAlignment = 'right',
  mediaSize = 'lg',
  children,
}: {
  title?: ReactNode;
  useH1?: boolean;
  subtitle?: ReactNode;
  belowSubtitle?: ReactNode;
  body?: ReactNode;
  tagline?: ReactNode;
  media?: (maxWidth: number) => ReactNode;
  alignment?: Alignment;
  smallAlignment?: Alignment;
  titleSize?: Size;
  mediaAlignment?: MediaAlignment;
  mediaSize?: Size;
  children?: ReactNode;
}) {
  function getTextAlignment() {
    let css = '';
    if (smallAlignment == 'start') {
      css += 'text-start';
    } else if (smallAlignment == 'center') {
      css += 'text-center';
    } else if (smallAlignment == 'end') {
      css += 'text-end';
    }

    if (smallAlignment !== alignment) {
      if (alignment == 'start') {
        css += ' sm:text-start';
      } else if (alignment == 'center') {
        css += ' sm:text-center';
      } else if (alignment == 'end') {
        css += ' sm:text-end';
      }
    }

    return css;
  }

  function getItemsAlignment() {
    let css = '';
    if (smallAlignment == 'start') {
      css += 'items-start';
    } else if (smallAlignment == 'center') {
      css += 'items-center';
    } else if (smallAlignment == 'end') {
      css += 'items-end';
    }

    if (smallAlignment !== alignment) {
      if (alignment == 'start') {
        css += ' sm:items-start';
      } else if (alignment == 'center') {
        css += ' sm:items-center';
      } else if (alignment == 'end') {
        css += ' sm:items-end';
      }
    }

    return css;
  }

  function getJustify() {
    let css = '';
    if (smallAlignment == 'start') {
      css += 'justify-start';
    } else if (smallAlignment == 'center') {
      css += 'justify-center';
    } else if (smallAlignment == 'end') {
      css += 'justify-end';
    }

    if (smallAlignment !== alignment) {
      if (alignment == 'start') {
        css += ' sm:justify-start';
      } else if (alignment == 'center') {
        css += ' sm:justify-center';
      } else if (alignment == 'end') {
        css += ' sm:justify-end';
      }
    }

    return css;
  }

  function getTitleClass() {
    switch (titleSize) {
      case 'lg':
        return 'title-lg';
      default:
        return 'title';
    }
  }

  function getMediaSize() {
    switch (mediaSize) {
      case 'lg':
        return 'max-w-6xl basis-[56rem]';
      case 'md':
        return 'max-w-lg basis-[32rem]';
      case 'sm':
        return 'max-w-64 basis-[16rem]';
    }
  }

  function getMediaMaxWidth() {
    switch (mediaSize) {
      case 'lg':
        return 1152;
      case 'md':
        return 512;
      case 'sm':
        return 256;
    }
  }

  return (
    <>
      <div
        className={clsx(
          'flex items-center justify-center gap-4 md:gap-8 px-2 mx-auto flex-wrap',
          mediaAlignment === 'right' ? ' flex-row' : 'flex-row-reverse',
        )}
      >
        <div
          className={`${getTextAlignment()} ${getJustify()} ${getItemsAlignment()} max-w-4xl flex-grow basis-[380px]`}
        >
          {tagline && (
            <p className="font-semibold leading-7 text-foreground-soft">
              {tagline}
            </p>
          )}
          {title && (titleSize === 'lg' || useH1) && (
            <h1 className={getTitleClass()}>{title}</h1>
          )}
          {title && titleSize === 'md' && !useH1 && (
            <p className={getTitleClass()}>{title}</p>
          )}
          {subtitle && <p className="mt-6 subtitle">{subtitle}</p>}
          {belowSubtitle && <div className="mt-4">{belowSubtitle}</div>}
          {body && <div className="mt-6 text-left">{body}</div>}
        </div>
        {media && (mediaAlignment === 'left' || mediaAlignment === 'right') && (
          <div className={`${getMediaSize()} flex flex-col items-center`}>
            {media(getMediaMaxWidth())}
          </div>
        )}
      </div>
      {children && (
        <div
          className={clsx(
            subtitle || belowSubtitle || body || media
              ? 'mt-12 sm:mt-16'
              : 'mt-4 sm:mt-8',
          )}
        >
          {children}
        </div>
      )}
      {mediaAlignment === 'below' && media && (
        <div className={`mx-auto mt-16 ${getMediaSize()}`}>
          {media(getMediaMaxWidth())}
        </div>
      )}
    </>
  );
}
