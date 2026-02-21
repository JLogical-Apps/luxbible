'use client';

import 'react-lite-youtube-embed/dist/LiteYouTubeEmbed.css';

import { vercelStegaCleanAll } from '@sanity/client/stega';
import { useMemo } from 'react';
import LiteYouTubeEmbed from 'react-lite-youtube-embed';

import { YouTubeMedia } from '@/schema/documents/media/youtube-media';

export default function YouTubeMediaRenderer({
  media,
}: {
  media: YouTubeMedia;
}) {
  const aspectParts = useMemo(
    () => (media.aspectRatio ?? '16/9').split('/'),
    [media.aspectRatio],
  );

  return (
    <LiteYouTubeEmbed
      aspectWidth={+aspectParts[0]}
      aspectHeight={+aspectParts[1]}
      id={vercelStegaCleanAll(media.youtubeId)}
      title={media.alt}
      poster="maxresdefault"
      params="rel=0"
      noCookie={true}
      webp={true}
      wrapperClass="yt-lite rounded-xl"
    />
  );
}
