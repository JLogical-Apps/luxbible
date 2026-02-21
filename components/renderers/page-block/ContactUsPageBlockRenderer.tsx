import { IconMail } from '@tabler/icons-react';
import Link from 'next/link';
import React from 'react';

import { CustomPortableText } from '@/components/CustomPortableText';
import { FormRenderer } from '@/components/renderers/FormRenderer';
import MediaRenderer from '@/components/renderers/media/MediaRenderer';
import SocialLinksRenderer from '@/components/renderers/page-block/SocialLinksRenderer';
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/Card';
import { Separator } from '@/components/ui/Separator';
import { ContactUsPageBlock } from '@/schema/documents/page-block/contact-us-page-block';
import { Settings } from '@/schema/documents/singletons/settings';

export default function ContactUsPageBlockRenderer({
  pageBlock,
  settings,
}: {
  pageBlock: ContactUsPageBlock;
  settings: Settings | null;
}) {
  return (
    <div className="flex flex-wrap justify-evenly gap-12 gap-y-16 mx-auto px-2 md:px-6 lg:px-8 items-center">
      <Card className="flex-grow max-w-[800px] basis-[450px]">
        {(pageBlock.title || pageBlock.description) && (
          <CardHeader>
            {pageBlock.title && (
              <CardTitle>
                <CustomPortableText value={pageBlock.title} />
              </CardTitle>
            )}
            {pageBlock.description && (
              <CardDescription>
                <CustomPortableText value={pageBlock.description} />
              </CardDescription>
            )}
          </CardHeader>
        )}
        <CardContent>
          <FormRenderer form={pageBlock.form} />
        </CardContent>
      </Card>
      <div className="max-w-80 flex flex-col justify-stretch gap-4">
        {pageBlock.profilePicture && (
          <>
            <div className="flex flex-col justify-center items-center gap-4">
              <MediaRenderer
                media={pageBlock.profilePicture}
                sizes="80px"
                width={80}
                height={80}
                className="rounded-full"
              />
              {pageBlock.introduction && (
                <p className="">&quot;{pageBlock.introduction}&quot;</p>
              )}
            </div>
            <Separator />
          </>
        )}
        {settings?.email && (
          <div className="flex flex-col items-center">
            <p className="subtitle">Reach Out Directly</p>
            <Link
              className="text-sm text-foreground-soft"
              href={`mailto:${settings.email}`}
            >
              <IconMail className="inline mr-1" />
              {settings.email}
            </Link>
          </div>
        )}
        {(settings?.facebook ||
          settings?.instagram ||
          settings?.twitter ||
          settings?.linkedIn) && (
          <div className="flex flex-col items-center">
            <p className="subtitle">Follow {settings.brandName}</p>
            <div className="flex flex-row gap-2">
              <SocialLinksRenderer
                socialLinks={settings}
                includeEmail={false}
              />
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
