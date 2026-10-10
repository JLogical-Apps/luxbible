'use client';

import Image, { StaticImageData } from 'next/image';
import { useEffect, useState } from 'react';

import Video from '@/components/media/Video';
import {
  Carousel,
  CarouselApi,
  CarouselContent,
  CarouselItem,
} from '@/components/ui/Carousel';
import { cn } from '@/lib/utils';

export type Feature = {
  title: string;
  subtitle: string;
} & ({ video: string } | { image: StaticImageData });

export default function FeatureShowcase({ features }: { features: Feature[] }) {
  const [selectedIndex, setSelectedIndex] = useState(0);
  const [api, setApi] = useState<CarouselApi>();

  useEffect(() => {
    if (!api) {
      return;
    }
    api.on('select', () => setSelectedIndex(api.selectedScrollSnap()));
  }, [api]);

  if (features.length === 0) {
    return null;
  }

  return (
    <div className="flex flex-col md:flex-row md:items-center gap-4 max-w-screen-md w-full mx-auto">
      <ul className="hidden md:block space-y-4 w-[42rem]">
        {features.map((feature, i) => (
          <li
            key={i}
            className={cn(
              'flex flex-col gap-2 p-6 cursor-pointer items-stretch rounded-2xl transition hover:brightness-150 active:bg-background-soft',
              selectedIndex === i ? 'bg-background-soft' : 'bg-background',
            )}
            onClick={() => setSelectedIndex(i)}
          >
            <p className="font-bold text-lg font-serif text-foreground">
              {feature.title}
            </p>
            <p className="text-foreground-soft font-medium">
              {feature.subtitle}
            </p>
          </li>
        ))}
      </ul>
      <div className="relative w-full h-full">
        {features.map((feature, i) => {
          const visibility = selectedIndex === i ? 'block' : 'hidden';
          return 'video' in feature ? (
            <Video
              key={i}
              src={feature.video}
              ariaLabel={feature.title}
              active={selectedIndex === i}
              className={cn('w-auto h-full max-h-[40rem] mx-auto', visibility)}
            />
          ) : (
            // Sized by width so the space is reserved before the image loads, matching a 40rem-tall video.
            <Image
              key={i}
              src={feature.image}
              alt={feature.title}
              sizes="320px"
              className={cn('w-full max-w-80 h-auto mx-auto', visibility)}
            />
          );
        })}
      </div>
      <Carousel className="block md:hidden w-full" setApi={setApi}>
        <CarouselContent className="space-x-2">
          {features.map((feature, i) => (
            <CarouselItem
              key={i}
              className={cn(
                'p-4 ml-4 basis-3/4 cursor-pointer max-w-80 rounded-2xl transition',
                selectedIndex === i ? 'bg-background-soft' : 'bg-background',
              )}
              onClick={() => api?.scrollTo(i)}
            >
              <p className="font-bold text-lg font-serif text-foreground">
                {feature.title}
              </p>
              <p className="text-foreground-soft">{feature.subtitle}</p>
            </CarouselItem>
          ))}
        </CarouselContent>
      </Carousel>
    </div>
  );
}
