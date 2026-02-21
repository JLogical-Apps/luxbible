import React from 'react';

import { FormRenderer } from '@/components/renderers/FormRenderer';
import { FormPageBlock } from '@/schema/documents/page-block/form-page-block';

export default function FormPageBlockRenderer({
  pageBlock,
}: {
  pageBlock: FormPageBlock;
}) {
  return <FormRenderer form={pageBlock.form} />;
}
