'use client';

import {
  IconPlayerPauseFilled,
  IconPlayerPlayFilled,
} from '@tabler/icons-react';
import { useCallback, useEffect, useRef, useState } from 'react';

import { cn } from '@/lib/utils';

export default function Video({
  src,
  className,
  aspectRatio = '369/742',
  ariaLabel,
  active = true,
}: {
  src: string;
  className?: string;
  aspectRatio?: string;
  ariaLabel?: string;
  active?: boolean;
}) {
  const [isHovering, setIsHovering] = useState(false);
  const [isPlaying, setIsPlaying] = useState(true);
  const [controlHidden, setControlHidden] = useState(true);
  const [inView, setInView] = useState(false);
  const videoRef = useRef<HTMLVideoElement>(null);

  useEffect(() => {
    const el = videoRef.current;
    if (!el) {
      return;
    }
    const observer = new IntersectionObserver(
      ([entry]) => setInView(entry.isIntersecting),
      { threshold: 0 },
    );
    observer.observe(el);
    return () => observer.disconnect();
  }, []);

  useEffect(() => {
    const video = videoRef.current;
    if (!video) {
      return;
    }
    if (!active || !inView) {
      video.currentTime = 0;
      video.pause();
      setControlHidden(true);
    } else {
      video.currentTime = 0;
      void video.play();
      const timeout = setTimeout(() => setControlHidden(false), 100);
      return () => clearTimeout(timeout);
    }
  }, [active, inView]);

  const handleClick = useCallback(() => {
    const video = videoRef.current;
    if (!video) {
      return;
    }
    if (video.paused) {
      void video.play();
    } else {
      video.pause();
    }
  }, []);

  const isControlVisible =
    ((isPlaying && isHovering) || !isPlaying) && !controlHidden;

  return (
    <div
      className={cn('relative w-auto h-full cursor-pointer', className)}
      style={{ aspectRatio }}
      onClick={handleClick}
      onMouseEnter={() => setIsHovering(true)}
      onMouseLeave={() => setIsHovering(false)}
    >
      <div className="absolute top-1/2 left-1/2 z-10 -translate-x-1/2 -translate-y-1/2">
        <div
          className={cn(
            'rounded-full p-4 transition',
            isHovering ? 'bg-emphasis' : 'bg-black/80',
            isControlVisible ? 'opacity-100' : 'opacity-0',
          )}
        >
          {isPlaying ? (
            <IconPlayerPauseFilled
              size={36}
              className={cn(
                'transition',
                isHovering ? 'text-on-emphasis' : 'text-white',
              )}
            />
          ) : (
            <IconPlayerPlayFilled
              size={36}
              className={cn(
                'transition',
                isHovering ? 'text-on-emphasis' : 'text-white',
              )}
            />
          )}
        </div>
      </div>
      <video
        ref={videoRef}
        className="h-full w-auto rounded-2xl"
        autoPlay
        muted
        loop
        playsInline
        preload="metadata"
        aria-label={ariaLabel}
        style={{ aspectRatio }}
        onPlay={() => setIsPlaying(true)}
        onPause={() => setIsPlaying(false)}
      >
        <source src={src} type="video/webm" />
      </video>
    </div>
  );
}
