import Image from 'next/image';

export default function ArticleImage({
  sources,
  alt,
  caption,
}: {
  sources: [string] | [string, string];
  alt: string;
  caption: string;
}) {
  const isDouble = sources.length === 2;

  return (
    <figure
      className={`not-prose clear-both mx-auto my-9 w-full ${
        isDouble ? 'max-w-[28.375rem]' : 'max-w-[13.6875rem]'
      }`}
    >
      <div className={isDouble ? 'grid grid-cols-2 gap-4' : ''}>
        {sources.map((src, index) => (
          <Image
            key={`${src}-${index}`}
            src={src}
            alt={alt}
            width={441}
            height={883}
            sizes={isDouble ? '(max-width: 480px) 45vw, 219px' : '219px'}
            className="h-auto w-full"
            unoptimized
          />
        ))}
      </div>
      <figcaption className="mt-4 text-center text-sm leading-6 text-foreground-soft">
        {caption}
      </figcaption>
    </figure>
  );
}
