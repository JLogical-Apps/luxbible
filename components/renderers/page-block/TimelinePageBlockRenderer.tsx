import { CustomPortableText } from '@/components/CustomPortableText';
import IconRenderer from '@/components/renderers/IconRenderer';
import ColorPaletteWrapper from '@/components/util/ColorPaletteWrapper';
import { TimelinePageBlock } from '@/schema/documents/page-block/timeline-page-block';

export default function TimelinePageBlockRenderer({
  pageBlock,
}: {
  pageBlock: TimelinePageBlock;
}) {
  return (
    <div className="max-w-2xl space-y-8 mx-auto">
      {pageBlock.items.map((item, i) => (
        <div key={i} className="relative pl-16">
          <div className="text-base text-start font-semibold leading-7 text-foreground">
            <ColorPaletteWrapper
              colorPalette={pageBlock.iconColorPalette}
              prefix="primary"
              includeBackground={false}
            >
              <div
                className="absolute left-0 top-0 flex h-10 w-10 items-center justify-center rounded-lg bg-primary text-primary-foreground"
                aria-hidden="true"
              >
                <IconRenderer icon={item.icon} size={1.5} />
              </div>
              <div
                className="absolute left-5 top-12 bottom-0 w-0.5 rounded-full bg-foreground-soft/20"
                aria-hidden="true"
              />
            </ColorPaletteWrapper>
            <CustomPortableText value={item.name} />
          </div>
          <div className="mt-2 text-start text-base leading-7 text-foreground-soft">
            <CustomPortableText value={item.body} />
          </div>
        </div>
      ))}
    </div>
  );
}
