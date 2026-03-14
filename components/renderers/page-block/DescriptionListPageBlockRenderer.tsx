'use client';

import { clsx } from 'clsx';
import { useEffect, useState } from 'react';

import { CustomPortableText } from '@/components/CustomPortableText';
import MediaRenderer from '@/components/renderers/media/MediaRenderer';
import {
  Carousel,
  CarouselApi,
  CarouselContent,
  CarouselItem,
} from '@/components/ui/Carousel';
import { DescriptionListPageBlock } from '@/schema/documents/page-block/description-list-page-block';

export default function DescriptionListPageBlockRenderer({
  pageBlock,
}: {
  pageBlock: DescriptionListPageBlock;
}) {
  const [selectedIndex, setSelectedIndex] = useState(0);
  const [api, setApi] = useState<CarouselApi>();

  useEffect(() => {
    if (!api) {
      return;
    }

    api.on('select', () => {
      setSelectedIndex(api.selectedScrollSnap());
    });
  }, [api]);

  if (!pageBlock.descriptions || pageBlock.descriptions.length == 0) {
    return null;
  }

  return (
    <div className="flex flex-col lg:flex-row lg:items-center gap-4">
      <ul className="hidden lg:block space-y-4 w-[35rem]">
        {pageBlock.descriptions.map((description, i) => (
          <li
            key={i}
            className={clsx(
              'flex flex-col gap-2 p-6 cursor-pointer items-stretch rounded-2xl hover:brightness-95 active:bg-background-soft',
              selectedIndex === i ? 'bg-background-soft' : 'bg-background',
            )}
            onClick={() => setSelectedIndex(i)}
          >
            <p className="font-bold text-lg font-serif text-foreground">
              <CustomPortableText value={description.title} />
            </p>
            <p className="text-foreground-soft font-medium">
              <CustomPortableText value={description.subtitle} />
            </p>
          </li>
        ))}
      </ul>
      <div className="relative w-full h-full">
        {pageBlock.descriptions.map((description, i) => (
          <MediaRenderer
            key={i}
            media={description.media}
            className={clsx(
              'w-full h-auto',
              selectedIndex === i ? 'block' : 'hidden',
            )}
            hidden={selectedIndex !== i}
          />
        ))}
      </div>
      <Carousel className="block lg:hidden w-full" setApi={setApi}>
        <CarouselContent className="space-x-2">
          {pageBlock.descriptions.map((description, i) => (
            <CarouselItem
              key={i}
              className={clsx(
                'p-4 ml-4 basis-3/4 cursor-pointer max-w-80 brightness-[98%] rounded-2xl transition',
                selectedIndex === i ? 'bg-background-soft' : 'bg-background',
              )}
              onClick={() => api?.scrollTo(i)}
            >
              <p className="font-bold text-lg font-serif text-foreground">
                <CustomPortableText value={description.title} />
              </p>
              <p className="text-foreground-soft">
                <CustomPortableText value={description.subtitle} />
              </p>
            </CarouselItem>
          ))}
        </CarouselContent>
      </Carousel>
    </div>
  );
}
