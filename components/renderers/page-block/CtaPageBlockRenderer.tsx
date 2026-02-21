import CtaRenderer from '@/components/renderers/CtaRenderer';
import { CtaPageBlock } from '@/schema/documents/page-block/cta-page-block';

export default function CtaPageBlockRenderer({
  pageBlock,
}: {
  pageBlock: CtaPageBlock;
}) {
  if (!pageBlock.ctas) {
    return null;
  }

  return (
    <div className="flex flex-center gap-4">
      {pageBlock.ctas.map((cta, i) => (
        <CtaRenderer key={i} cta={cta} />
      ))}
    </div>
  );
}
