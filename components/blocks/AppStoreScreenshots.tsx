import Image from 'next/image';

const screenshots = [
  {
    src: '/media/app-store-screenshots/Screenshot 1.png',
    alt: 'Lux Bible reading experience',
  },
  {
    src: '/media/app-store-screenshots/Screenshot 2.png',
    alt: 'Lux Bible search',
  },
  {
    src: '/media/app-store-screenshots/Screenshot 3.png',
    alt: 'Lux Bible bible plans',
  },
  {
    src: '/media/app-store-screenshots/Screenshot 4.png',
    alt: 'Lux Bible annotations',
  },
  {
    src: '/media/app-store-screenshots/Screenshot 5.png',
    alt: 'Lux Bible cross references',
  },
  {
    src: '/media/app-store-screenshots/Screenshot 6.png',
    alt: 'Lux Bible navigation',
  },
  {
    src: '/media/app-store-screenshots/Screenshot 7.png',
    alt: 'Lux Bible study panels',
  },
  {
    src: '/media/app-store-screenshots/Screenshot 8.png',
    alt: 'Lux Bible toolbars',
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
