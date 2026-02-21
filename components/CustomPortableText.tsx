import { PortableText, PortableTextComponents } from '@portabletext/react';
import type { PortableTextBlock } from '@portabletext/types';
import Link from 'next/link';
import React from 'react';

import {
  getActionDescriptiveText,
  getActionProps,
} from '@/components/props/action-props';
import ImageMediaRenderer from '@/components/renderers/media/ImageMediaRenderer';
import VimeoMediaRenderer from '@/components/renderers/media/VimeoMediaRenderer';
import YouTubeMediaRenderer from '@/components/renderers/media/YouTubeMediaRenderer';
import { ImageMedia } from '@/schema/documents/media/image-media';
import { VimeoMedia } from '@/schema/documents/media/vimeo-media';
import { YouTubeMedia } from '@/schema/documents/media/youtube-media';

export function CustomPortableText({
  inline = true,
  value,
}: {
  inline?: boolean;
  value?: PortableTextBlock[] | string;
}) {
  if (!value) {
    return null;
  }

  if (typeof value == 'string') {
    return <>{value}</>;
  }

  const components: PortableTextComponents = {
    block: {
      normal: ({ children }) => {
        if (inline) {
          return children;
        } else {
          return <p className="mt-4 first:mt-0">{children}</p>;
        }
      },
      h1: ({ children }) => {
        return <h1 className="title-lg mt-14">{children}</h1>;
      },
      h2: ({ children }) => {
        return <h2 className="title border-b pb-2 mt-10">{children}</h2>;
      },
      h3: ({ children }) => {
        return <h3 className="subtitle mt-6">{children}</h3>;
      },
      h4: ({ children }) => {
        return <h4 className="tagline mt-4">{children}</h4>;
      },
      blockquote: ({ children }) => {
        return (
          <blockquote className="mt-6 border-l-2 pl-6 italic">
            {children}
          </blockquote>
        );
      },
    },
    marks: {
      code: ({ children }) => {
        return (
          <code className="relative rounded bg-background-soft px-[0.3rem] py-[0.2rem] font-mono text-sm font-semibold">
            {children}
          </code>
        );
      },
      link: ({ children, value }) => {
        const action =
          value?.action && value.action.length != 0
            ? value.action[0]
            : undefined;
        const descriptiveText = getActionDescriptiveText(action);
        return (
          <Link {...getActionProps(action)}>
            {children}
            {descriptiveText && (
              <span className="sr-only">{descriptiveText}</span>
            )}
          </Link>
        );
      },
      gradient: ({ children, value }) => {
        return <span className="gradient-heading">{children}</span>;
      },
    },
    types: {
      imageMedia: ({ value }: { value: ImageMedia }) => {
        return (
          <div className="my-6 space-y-2">
            <ImageMediaRenderer media={value} />
          </div>
        );
      },
      youtubeMedia: ({ value }: { value: YouTubeMedia }) => {
        return (
          <div className="my-6 space-y-2">
            <YouTubeMediaRenderer media={value} />
          </div>
        );
      },
      vimeoMedia: ({ value }: { value: VimeoMedia }) => {
        return (
          <div className="my-6 space-y-2">
            <VimeoMediaRenderer media={value} />
          </div>
        );
      },
    },
    list: {
      bullet: ({ children }) => {
        return <ul className="mt-6 ml-6 list-disc [&>li]:mt-2">{children}</ul>;
      },
      number: ({ children }) => {
        return (
          <ul className="mt-6 ml-6 list-decimal [&>li]:mt-2">{children}</ul>
        );
      },
    },
  };

  return <PortableText components={components} value={value} />;
}
