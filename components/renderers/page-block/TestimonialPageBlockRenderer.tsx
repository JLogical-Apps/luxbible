import { CustomPortableText } from '@/components/CustomPortableText';
import CollapsibleGrid from '@/components/layout/CollapsibleGrid';
import MediaRenderer from '@/components/renderers/media/MediaRenderer';
import { TestimonialPageBlock } from '@/schema/documents/page-block/testimonial-page-block';

export default function TestimonialPageBlockRenderer({
  pageBlock,
}: {
  pageBlock: TestimonialPageBlock;
}) {
  return (
    <CollapsibleGrid>
      {pageBlock.testimonials.map((testimonial, i) => (
        <div
          key={i}
          className="flex flex-col items-center p-6 bg-white shadow-lg rounded-lg"
        >
          <MediaRenderer
            media={testimonial.profilePicture}
            className="rounded-full border-2 border-gray-200 object-cover"
            width={100}
            height={100}
            style={{
              aspectRatio: '100/100',
              objectFit: 'cover',
            }}
          />
          <p className="mt-4 text-xl font-semibold">{testimonial.name}</p>
          <p className="text-sm">
            <CustomPortableText value={testimonial.title} />
          </p>
          <p className="mt-4 text-center text-foreground-soft">
            &quot;
            <CustomPortableText value={testimonial.quote} />
            &quot;
          </p>
        </div>
      ))}
    </CollapsibleGrid>
  );
}
