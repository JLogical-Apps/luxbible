import { CSSProperties } from 'react';

import ImageMediaRenderer from '@/components/renderers/media/ImageMediaRenderer';
import VimeoMediaRenderer from '@/components/renderers/media/VimeoMediaRenderer';
import YouTubeMediaRenderer from '@/components/renderers/media/YouTubeMediaRenderer';
import { Media } from '@/schema/documents/media/media';

export default function MediaRenderer({
  media,
  ...props
}: {
  media: Media;
  sizes?: string;
  priority?: boolean;
  style?: CSSProperties;
  [key: string]: any;
}) {
  if (media._type === 'imageMedia') {
    return <ImageMediaRenderer {...props} media={media} />;
  } else if (media._type === 'youtubeMedia') {
    return <YouTubeMediaRenderer {...props} media={media} />;
  } else if (media._type === 'vimeoMedia') {
    return <VimeoMediaRenderer {...props} media={media} />;
  }
}
