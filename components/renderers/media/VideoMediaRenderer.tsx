'use client';

import {
  IconPlayerPauseFilled,
  IconPlayerPlayFilled,
} from '@tabler/icons-react';
import { clsx } from 'clsx';
import { useInView } from 'framer-motion';
import { useCallback, useEffect, useRef, useState } from 'react';

import { VideoMedia } from '@/schema/documents/media/video-media';

export default function VideoMediaRenderer({
  className = 'rounded-2xl',
  media,
  autoPlay = true,
  hidden = false,
}: {
  className?: string;
  media: VideoMedia;
  autoPlay?: boolean;
  hidden?: boolean;
}) {
  const [isHovering, setIsHovering] = useState(false);
  const [isPlaying, setIsPlaying] = useState(autoPlay);
  const [controlHidden, setControlHidden] = useState(false);
  const videoRef = useRef<HTMLVideoElement>(null);
  const isInView = useInView(videoRef);

  const handleClick = useCallback(
    () =>
      videoRef.current?.paused
        ? videoRef.current?.play()
        : videoRef.current?.pause(),
    [videoRef],
  );

  useEffect(() => {
    if (!videoRef.current) {
      return;
    }
    if (hidden || !isInView) {
      videoRef.current.currentTime = 0;
      videoRef.current.pause();
      setControlHidden(true);
    } else if (autoPlay) {
      videoRef.current.currentTime = 0;
      videoRef.current.play();
      setTimeout(() => setControlHidden(false), 100);
    }
  }, [autoPlay, hidden, isInView]);

  const isControlButtonVisible =
    ((isPlaying && isHovering) || !isPlaying) && !controlHidden;

  return (
    <div
      className={clsx(className, `relative cursor-pointer w-auto h-full`)}
      style={{ aspectRatio: media.aspectRatio ?? '16/9' }}
      onClick={handleClick}
      onMouseEnter={() => setIsHovering(true)}
      onMouseLeave={() => setIsHovering(false)}
    >
      <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2">
        <div
          className={clsx(
            'rounded-full p-4 transition',
            isHovering ? 'bg-primary' : 'bg-black/80',
            isControlButtonVisible ? 'opacity-100' : 'opacity-0',
          )}
        >
          {isPlaying ? (
            <IconPlayerPauseFilled
              size={36}
              className={clsx(
                'transition',
                isHovering ? 'text-primary-foreground' : 'text-white',
              )}
            >
              Pause Button
            </IconPlayerPauseFilled>
          ) : (
            <IconPlayerPlayFilled
              size={36}
              className={clsx(
                'transition',
                isHovering ? 'text-primary-foreground' : 'text-white',
              )}
            >
              Play Button
            </IconPlayerPlayFilled>
          )}
        </div>
      </div>
      <video
        ref={videoRef}
        className="auto h-full rounded-2xl"
        autoPlay={autoPlay}
        playsInline
        muted
        loop
        aria-label={media.alt}
        style={{ aspectRatio: media.aspectRatio ?? '16/9' }}
        onPlay={() => setIsPlaying(true)}
        onPause={() => setIsPlaying(false)}
      >
        <source src={media.url} type="video/webm" />
        Your browser does not support the video tag.
      </video>
    </div>
  );
}
