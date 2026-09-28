'use client';

import {
  IconBrandAppleFilled,
  IconBrandGooglePlay,
  IconStarFilled,
} from '@tabler/icons-react';
import { useEffect, useRef } from 'react';

export type Testimonial = {
  quote: string;
  name: string;
  store: 'appStore' | 'googlePlay';
  rating: number;
};

const pixelsPerSecond = 45;
const resumeDelayMs = 2000;
const copies = 3;

const stores = {
  appStore: { label: 'App Store', Icon: IconBrandAppleFilled },
  googlePlay: { label: 'Google Play', Icon: IconBrandGooglePlay },
};

function TestimonialCard({ testimonial }: { testimonial: Testimonial }) {
  const { label, Icon } = stores[testimonial.store];

  return (
    <figure className="flex w-72 sm:w-80 shrink-0 flex-col justify-between gap-6 rounded-2xl bg-background-soft p-6">
      <div className="flex flex-col gap-4">
        <div
          className="flex gap-1 text-emphasis"
          aria-label={`${testimonial.rating} out of 5 stars`}
        >
          {Array.from({ length: testimonial.rating }, (_, i) => (
            <IconStarFilled key={i} size={16} />
          ))}
        </div>
        <blockquote className="text-foreground-soft leading-7">
          “{testimonial.quote}”
        </blockquote>
      </div>
      <figcaption className="flex items-center justify-between gap-4 text-sm">
        <span className="font-semibold text-foreground">
          {testimonial.name}
        </span>
        <span className="flex items-center gap-1.5 text-foreground-soft opacity-60">
          <Icon size={16} />
          {label}
        </span>
      </figcaption>
    </figure>
  );
}

export default function Testimonials({
  testimonials,
}: {
  testimonials: Testimonial[];
}) {
  const marqueeRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const marquee = marqueeRef.current;
    if (!marquee) return;

    const isReducedMotion = matchMedia(
      '(prefers-reduced-motion: reduce)',
    ).matches;
    const getCopyWidth = () => marquee.scrollWidth / copies;
    let position = getCopyWidth();
    let resumeAt = 0;
    let isHovered = false;
    let isTouching = false;
    let lastTime: number | undefined;
    let frame: number;
    marquee.scrollLeft = position;

    // Stays in the middle copy so a swipe has a full copy of room either way. Only wrapped while
    // auto-scrolling, since writing scrollLeft mid-swipe cuts off iOS momentum and flickers.
    const wrap = (x: number) => {
      const copyWidth = getCopyWidth();
      if (x < copyWidth) return x + copyWidth;
      if (x >= copyWidth * 2) return x - copyWidth;
      return x;
    };

    const step = (time: number) => {
      const isPaused =
        isReducedMotion || isHovered || isTouching || time < resumeAt;
      if (lastTime !== undefined && !isPaused) {
        position = wrap(
          position + (pixelsPerSecond * (time - lastTime)) / 1000,
        );
        marquee.scrollLeft = position;
      }
      lastTime = time;
      frame = requestAnimationFrame(step);
    };

    const handleScroll = () => {
      // Our own writes land within a pixel of position; anything else came from the user.
      if (Math.abs(marquee.scrollLeft - position) < 1) return;
      position = marquee.scrollLeft;
      resumeAt = performance.now() + resumeDelayMs;
    };
    const handlePointerEnter = (event: PointerEvent) => {
      if (event.pointerType === 'mouse') isHovered = true;
    };
    const handlePointerLeave = () => {
      isHovered = false;
    };
    const handleTouchStart = () => {
      isTouching = true;
    };
    const handleTouchEnd = () => {
      isTouching = false;
      resumeAt = performance.now() + resumeDelayMs;
    };

    marquee.addEventListener('scroll', handleScroll, { passive: true });
    marquee.addEventListener('pointerenter', handlePointerEnter);
    marquee.addEventListener('pointerleave', handlePointerLeave);
    marquee.addEventListener('touchstart', handleTouchStart, { passive: true });
    marquee.addEventListener('touchend', handleTouchEnd);
    marquee.addEventListener('touchcancel', handleTouchEnd);
    frame = requestAnimationFrame(step);

    return () => {
      cancelAnimationFrame(frame);
      marquee.removeEventListener('scroll', handleScroll);
      marquee.removeEventListener('pointerenter', handlePointerEnter);
      marquee.removeEventListener('pointerleave', handlePointerLeave);
      marquee.removeEventListener('touchstart', handleTouchStart);
      marquee.removeEventListener('touchend', handleTouchEnd);
      marquee.removeEventListener('touchcancel', handleTouchEnd);
    };
  }, []);

  return (
    <div className="marquee-fade -mx-8">
      <div ref={marqueeRef} className="marquee">
        {/* Identical copies so scrolling can wrap by one copy's width without a visible jump. */}
        <div className="flex w-max">
          {Array.from({ length: copies }, (_, copy) => (
            <div
              key={copy}
              aria-hidden={copy !== 0}
              className="flex items-stretch gap-4 pr-4"
            >
              {testimonials.map((testimonial) => (
                <TestimonialCard
                  key={testimonial.name}
                  testimonial={testimonial}
                />
              ))}
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
