import Image from 'next/image';

const screenshots = [
  {
    src: '/media/app-store-screenshots/Screenshot 1.png',
    alt: 'Lux Bible interlinear and original language study',
  },
  {
    src: '/media/app-store-screenshots/Screenshot 2.png',
    alt: 'Lux Bible commentaries and dictionaries',
  },
  {
    src: '/media/app-store-screenshots/Screenshot 3.png',
    alt: 'Lux Bible highlights and notes',
  },
  {
    src: '/media/app-store-screenshots/Screenshot 4.png',
    alt: 'Lux Bible linked resources',
  },
  {
    src: '/media/app-store-screenshots/Screenshot 5.png',
    alt: 'Lux Bible reading plans',
  },
  {
    src: '/media/app-store-screenshots/Screenshot 6.png',
    alt: 'Lux Bible translation comparison',
  },
  {
    src: '/media/app-store-screenshots/Screenshot 7.png',
    alt: 'Lux Bible search',
  },
  {
    src: '/media/app-store-screenshots/Screenshot 8.png',
    alt: 'Lux Bible cross references',
  },
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
