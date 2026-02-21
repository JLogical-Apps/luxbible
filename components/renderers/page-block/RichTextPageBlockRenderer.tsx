import { CustomPortableText } from '@/components/CustomPortableText';
import { RichTextPageBlock } from '@/schema/documents/page-block/rich-text-page-block';

export default function RichTextPageBlockRenderer({
  pageBlock,
}: {
  pageBlock: RichTextPageBlock;
}) {
  return <CustomPortableText value={pageBlock.body} />;
}
