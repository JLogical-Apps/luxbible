import Feature from '@/components/feature/Feature';
import CollapsibleGrid from '@/components/layout/CollapsibleGrid';
import { DescriptionListPageBlock } from '@/schema/documents/page-block/description-list-page-block';

export default function DescriptionListPageBlockRenderer({
  pageBlock,
}: {
  pageBlock: DescriptionListPageBlock;
}) {
  return (
    <CollapsibleGrid>
      {pageBlock.descriptions.map((description, i) => (
        <Feature
          key={i}
          name={description.name}
          icon={description.icon}
          body={description.body}
          iconColorPalette={pageBlock.iconColorPalette}
        />
      ))}
    </CollapsibleGrid>
  );
}
