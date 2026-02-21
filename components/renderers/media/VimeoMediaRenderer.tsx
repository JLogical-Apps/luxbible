'use client';

import { vercelStegaCleanAll } from '@sanity/client/stega';
import { IconPlayerPlayFilled } from '@tabler/icons-react';
import { useQuery } from '@tanstack/react-query';
import { clsx } from 'clsx';
import Image from 'next/image';

import { Skeleton } from '@/components/ui/skeleton';
import PlayerFacade from '@/components/util/PlayerFacade';
import { VimeoMedia } from '@/schema/documents/media/vimeo-media';

export default function VimeoMediaRenderer({ media }: { media: VimeoMedia }) {
  const vimeoPlayerUrl = `https://player.vimeo.com/video/${vercelStegaCleanAll(
    media.vimeoId,
  )}?autoplay=1`;

  const {
    isPending,
    error,
    data: thumbnail,
  } = useQuery({
    queryKey: ['vimeoThumbnail', vimeoPlayerUrl],
    queryFn: () =>
      fetch(`https://vimeo.com/api/v2/video/${media.vimeoId}.json`)
        .then((res) => res.json())
        .then((json) => json[0].thumbnail_large),
    staleTime: Infinity,
  });

  if (isPending || error)
    return (
      <Skeleton
        className="w-full h-auto rounded-2xl"
        style={{ aspectRatio: media.aspectRatio ?? '16/9' }}
      />
    );

  return (
    <PlayerFacade
      className="rounded-2xl overflow-hidden"
      placeholder={<Image src={thumbnail} alt={media.alt} fill />}
      playerBuilder={() => (
        <iframe
          className="bg-black rounded-2xl"
          src={vimeoPlayerUrl}
          allow="autoplay; fullscreen; picture-in-picture"
          style={{
            position: 'absolute',
            top: 0,
            left: 0,
            width: '100%',
            height: '100%',
          }}
          title={media.alt}
        />
      )}
      aspectRatio={media.aspectRatio}
      playButton={(isHovering) => (
        <div
          className={clsx(
            'px-6 py-3 rounded-lg transition',
            isHovering ? 'bg-primary shadow-2xl' : 'bg-black/20',
          )}
        >
          <IconPlayerPlayFilled
            className={clsx(
              'transition',
              isHovering ? 'text-primary-foreground' : 'text-white',
            )}
          >
            Play Button
          </IconPlayerPlayFilled>
        </div>
      )}
    />
  );
}

async function getThumbnailUrl(vimeoPlayerUrl: string) {
  try {
    const noembed = await fetch(
      `https://noembed.com/embed?url=${encodeURIComponent(vimeoPlayerUrl)}`,
      {
        cache: 'force-cache',
      },
    );
    const json = await noembed.json();
    return json.thumbnail_url as string;
  } catch (e) {
    return null;
  }
}
