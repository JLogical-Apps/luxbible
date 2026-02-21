import { CustomPortableText } from '@/components/CustomPortableText';
import CollapsibleGrid from '@/components/layout/CollapsibleGrid';
import CtaRenderer from '@/components/renderers/CtaRenderer';
import MediaRenderer from '@/components/renderers/media/MediaRenderer';
import {
  Card,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from '@/components/ui/Card';
import { ItemsListPageBlock } from '@/schema/documents/page-block/items-list-page-block';

export default function ItemsListPageBlockRenderer({
  pageBlock,
}: {
  pageBlock: ItemsListPageBlock;
}) {
  return (
    <CollapsibleGrid>
      {pageBlock.items.map((item, i) => (
        <Card key={i} className="">
          <MediaRenderer
            className="rounded-b-none rounded-t-2xl"
            media={item.media}
            sizes="500px"
            width={500}
            height={333}
          />
          <CardHeader>
            <CardTitle>
              <CustomPortableText value={item.name} />
            </CardTitle>
            <CardDescription>
              <CustomPortableText value={item.body} />
            </CardDescription>
          </CardHeader>
          <CardFooter>
            <CtaRenderer cta={item.cta} />
          </CardFooter>
        </Card>
      ))}
    </CollapsibleGrid>
  );
}
