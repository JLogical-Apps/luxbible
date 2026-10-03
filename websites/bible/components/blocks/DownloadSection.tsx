import { ReactNode } from 'react';

import AppStoreButtons from '@/components/blocks/AppStoreButtons';
import Section from '@/components/layout/Section';
import { site } from '@/lib/site';

export default function DownloadSection({
  children,
}: {
  children?: ReactNode;
}) {
  return (
    <Section
      id="download"
      contained
      align="responsive"
      title={
        <>
          Download Lux for <span className="gradient-heading">Free</span>
        </>
      }
      subtitle={site.description}
    >
      <div className="flex flex-col gap-12">
        <AppStoreButtons
          appStoreUrl={site.appStoreUrl}
          appStoreProviderToken={site.appStoreProviderToken}
          googlePlayUrl={site.googlePlayUrl}
        />
        {children}
      </div>
    </Section>
  );
}
