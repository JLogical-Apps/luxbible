'use client';

import { useEffect, useRef } from 'react';

import { cn } from '@/lib/utils';

// For seamless loops, unlike Video, which fades out between plays and has a play button.
export default function LoopingVideo({
  webm,
  mp4,
  poster,
  ariaLabel,
  className,
}: {
  webm: string;
  mp4: string;
  poster: string;
  ariaLabel: string;
  className?: string;
}) {
  const videoRef = useRef<HTMLVideoElement>(null);

  useEffect(() => {
    const video = videoRef.current;
    if (!video) return;

    const reducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)');
    const update = () =>
      reducedMotion.matches ? video.pause() : void video.play();
    update();
    reducedMotion.addEventListener('change', update);
    return () => reducedMotion.removeEventListener('change', update);
  }, []);

  return (
    <video
      ref={videoRef}
      className={cn('w-full h-auto', className)}
      style={{ aspectRatio: '16/9' }}
      poster={poster}
      autoPlay
      muted
      loop
      playsInline
      preload="auto"
      aria-label={ariaLabel}
    >
      <source src={webm} type="video/webm" />
      <source src={mp4} type="video/mp4" />
    </video>
  );
}
