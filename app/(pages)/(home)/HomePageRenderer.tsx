import PageFooter from '@/components/page/PageFooter';
import PageHeader from '@/components/page/PageHeader';
import PageWrapper from '@/components/page/PageWrapper';
import PageSectionRenderer from '@/components/renderers/PageSectionRenderer';
import { HomePage } from '@/schema/documents/singletons/home';
import { Settings } from '@/schema/documents/singletons/settings';

export interface HomePageProps {
  homePage: HomePage | null;
  settings: Settings | null;
}

export function HomePageRenderer({ homePage, settings }: HomePageProps) {
  // Default to an empty object to allow previews on non-existent documents
  const { content } = homePage ?? {};

  return (
    <PageWrapper
      colorPalette={homePage?.colorPalette ?? settings?.colorPalette}
      primaryColorPalette={settings?.primaryColorPalette}
      className="flex flex-col min-h-screen bg-background text-foreground"
    >
      {settings && <PageHeader settings={settings} />}
      <main className="flex-1 flex-grow">
        {content &&
          content.map((content, i) => (
            <PageSectionRenderer
              key={i}
              pageSection={content}
              index={i}
              settings={settings}
            />
          ))}
      </main>
      {settings && <PageFooter settings={settings} />}
    </PageWrapper>
  );
}

export default HomePageRenderer;
