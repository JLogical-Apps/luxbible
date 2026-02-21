import PageFooter from '@/components/page/PageFooter';
import PageHeader from '@/components/page/PageHeader';
import PageWrapper from '@/components/page/PageWrapper';
import PageSectionRenderer from '@/components/renderers/PageSectionRenderer';
import { Page } from '@/schema/documents/page';
import { Settings } from '@/schema/documents/singletons/settings';
import { getPageOverrideFromType } from '@/schema/objects/page-override';

export interface PageProps {
  page: Page | null;
  settings: Settings | null;
}

export function PageRenderer({ page, settings }: PageProps) {
  const bottomSections = settings
    ? getPageOverrideFromType({
        pageType: 'page',
        pageOverrides: settings.pageOverrides,
      })?.bottomSections
    : undefined;

  return (
    <PageWrapper
      colorPalette={page?.colorPalette ?? settings?.colorPalette}
      primaryColorPalette={settings?.primaryColorPalette}
      className="flex flex-col min-h-screen bg-background text-foreground"
    >
      {settings && <PageHeader settings={settings} />}
      <main className="flex-1 flex-grow">
        {page?.content &&
          page.content.map((content, i) => (
            <PageSectionRenderer
              key={i}
              pageSection={content}
              index={i}
              settings={settings}
            />
          ))}
        {bottomSections &&
          bottomSections.map((section, i) => (
            <PageSectionRenderer
              key={i}
              pageSection={section}
              index={i}
              settings={settings}
            />
          ))}
      </main>
      {settings && <PageFooter settings={settings} />}
    </PageWrapper>
  );
}

export default PageRenderer;
