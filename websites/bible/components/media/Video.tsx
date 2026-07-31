'use client';

import {
  IconPlayerPauseFilled,
  IconPlayerPlayFilled,
} from '@tabler/icons-react';
import { useCallback, useEffect, useRef, useState } from 'react';

import { cn } from '@/lib/utils';

const loopFadeDuration = 260;
const controlDismissDelay = 1000;

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
  const [isLoopFading, setIsLoopFading] = useState(false);
  const videoRef = useRef<HTMLVideoElement>(null);
  const loopFadeStartedAtRef = useRef<number>();
  const loopRestartTimeoutRef = useRef<ReturnType<typeof setTimeout>>();
  const controlDismissTimeoutRef = useRef<ReturnType<typeof setTimeout>>();
  const shouldDismissControlAfterPlayRef = useRef(false);

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
    clearTimeout(loopRestartTimeoutRef.current);
    clearTimeout(controlDismissTimeoutRef.current);
    loopFadeStartedAtRef.current = undefined;
    shouldDismissControlAfterPlayRef.current = false;
    setIsLoopFading(false);
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

  useEffect(
    () => () => {
      clearTimeout(loopRestartTimeoutRef.current);
      clearTimeout(controlDismissTimeoutRef.current);
    },
    [],
  );

  const beginLoopFade = useCallback(() => {
    if (loopFadeStartedAtRef.current) {
      return;
    }
    loopFadeStartedAtRef.current = performance.now();
    setIsLoopFading(true);
  }, []);

  const handleTimeUpdate = useCallback(() => {
    const video = videoRef.current;
    if (!video || !Number.isFinite(video.duration)) {
      return;
    }
    if (video.duration - video.currentTime <= loopFadeDuration / 1000) {
      beginLoopFade();
    }
  }, [beginLoopFade]);

  const handleEnded = useCallback(() => {
    beginLoopFade();
    const fadeElapsed = performance.now() - (loopFadeStartedAtRef.current ?? 0);
    const restartDelay = Math.max(0, loopFadeDuration - fadeElapsed);
    loopRestartTimeoutRef.current = setTimeout(() => {
      const video = videoRef.current;
      if (!video) {
        return;
      }
      video.currentTime = 0;
      void video.play();
      loopFadeStartedAtRef.current = undefined;
      setIsLoopFading(false);
    }, restartDelay);
  }, [beginLoopFade]);

  const handleClick = useCallback(() => {
    const video = videoRef.current;
    if (!video) {
      return;
    }
    if (video.paused) {
      shouldDismissControlAfterPlayRef.current = true;
      void video.play();
    } else {
      clearTimeout(controlDismissTimeoutRef.current);
      shouldDismissControlAfterPlayRef.current = false;
      setControlHidden(false);
      video.pause();
    }
  }, []);

  const handlePlay = useCallback(() => {
    setIsPlaying(true);
    if (!shouldDismissControlAfterPlayRef.current) {
      return;
    }
    shouldDismissControlAfterPlayRef.current = false;
    clearTimeout(controlDismissTimeoutRef.current);
    controlDismissTimeoutRef.current = setTimeout(
      () => setControlHidden(true),
      controlDismissDelay,
    );
  }, []);

  const isControlVisible =
    ((isPlaying && isHovering) || !isPlaying) &&
    !controlHidden &&
    !isLoopFading;

  return (
    <div
      className={cn('relative w-auto h-full cursor-pointer', className)}
      style={{ aspectRatio }}
      onClick={handleClick}
      onMouseEnter={() => {
        setIsHovering(true);
        setControlHidden(false);
      }}
      onMouseLeave={() => setIsHovering(false)}
    >
      <div
        className={cn(
          'pointer-events-none absolute inset-0 z-20 rounded-2xl bg-background transition-opacity duration-300 ease-out',
          isLoopFading ? 'opacity-100' : 'opacity-0',
        )}
      />
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
        playsInline
        preload="metadata"
        aria-label={ariaLabel}
        style={{ aspectRatio }}
        onPlay={handlePlay}
        onPause={() => setIsPlaying(false)}
        onTimeUpdate={handleTimeUpdate}
        onEnded={handleEnded}
      >
        <source src={src} type="video/webm" />
      </video>
    </div>
  );
}
