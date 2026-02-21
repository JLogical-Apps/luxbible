import { toPlainText } from '@portabletext/react';

import { CustomPortableText } from '@/components/CustomPortableText';
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from '@/components/ui/Accordion';
import { FaqPageBlock } from '@/schema/documents/page-block/faq-page-block';

export default function FaqPageBlockRenderer({
  pageBlock,
}: {
  pageBlock: FaqPageBlock;
}) {
  return (
    <Accordion type="single" collapsible className="w-full max-w-2xl mx-auto">
      {pageBlock.faqs &&
        pageBlock.faqs.map((faq) => (
          <AccordionItem
            key={toPlainText(faq.question)}
            value={toPlainText(faq.question)}
          >
            <AccordionTrigger>
              <span className="font-semibold text-start">
                <CustomPortableText value={faq.question} />
              </span>
            </AccordionTrigger>
            <AccordionContent>
              <CustomPortableText value={faq.answer} />
            </AccordionContent>
          </AccordionItem>
        ))}
    </Accordion>
  );
}
