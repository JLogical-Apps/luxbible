import Feature from '@/components/feature/Feature';
import CollapsibleGrid from '@/components/layout/CollapsibleGrid';
import { FeatureListPageBlock } from '@/schema/documents/page-block/feature-list-page-block';

export default function FeatureListPageBlockRenderer({
  pageBlock,
}: {
  pageBlock: FeatureListPageBlock;
}) {
  return (
    <CollapsibleGrid>
      {pageBlock.features.map((feature, i) => (
        <Feature
          key={i}
          name={feature.name}
          icon={feature.icon}
          body={feature.body}
          iconColorPalette={pageBlock.iconColorPalette}
        />
      ))}
    </CollapsibleGrid>
  );
}
