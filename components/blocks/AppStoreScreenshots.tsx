import Image from 'next/image';

const screenshots = [
  {
    src: '/media/app-store-screenshots/read-scripture.png',
    alt: 'Lux Bible reading experience',
  },
  {
    src: '/media/app-store-screenshots/bible-plans.png',
    alt: 'Lux Bible reading plans',
  },
  {
    src: '/media/app-store-screenshots/annotations.png',
    alt: 'Lux Bible annotations',
  },
  {
    src: '/media/app-store-screenshots/study-tools.png',
    alt: 'Lux Bible study tools',
  },
  { src: '/media/app-store-screenshots/search.png', alt: 'Lux Bible search' },
  { src: '/media/app-store-screenshots/lexicon.png', alt: 'Lux Bible lexicon' },
  { src: '/media/app-store-screenshots/lexicon.png', alt: 'Lux Bible lexicon' },
  { src: '/media/app-store-screenshots/lexicon.png', alt: 'Lux Bible lexicon' },
];

export default function AppStoreScreenshots() {
  return (
    <div className="-mx-4 overflow-x-auto px-4 pb-3 md:-mx-6 md:px-6">
      <div className="flex w-max gap-4 snap-x snap-mandatory">
        {screenshots.map((screenshot) => (
          <Image
            key={screenshot.src}
            src={screenshot.src}
            alt={screenshot.alt}
            width={1284}
            height={2778}
            sizes="(min-width: 1024px) 192px, (min-width: 640px) 176px, 160px"
            className="w-40 shrink-0 snap-center rounded-2xl shadow-xl sm:w-44 lg:w-48"
          />
        ))}
      </div>
    </div>
  );
}
