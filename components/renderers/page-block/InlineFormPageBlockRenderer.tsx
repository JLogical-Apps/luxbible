import React from 'react';

import { InlineFormRenderer } from '@/components/renderers/InlineFormRenderer';
import {
  InlineFormPageBlock
} from '@/schema/documents/page-block/inline-form-page-block';

export default function InlineFormPageBlockRenderer({
  pageBlock,
}: {
  pageBlock: InlineFormPageBlock;
}) {
  return <InlineFormRenderer form={pageBlock.inlineForm} />;
}
