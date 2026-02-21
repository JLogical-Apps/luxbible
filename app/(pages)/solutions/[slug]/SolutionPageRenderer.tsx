import PageFooter from '@/components/page/PageFooter';
import PageHeader from '@/components/page/PageHeader';
import PageWrapper from '@/components/page/PageWrapper';
import PageSectionRenderer from '@/components/renderers/PageSectionRenderer';
import { Settings } from '@/schema/documents/singletons/settings';
import { Solution } from '@/schema/documents/solution';
import { linkableImplementations } from '@/schema/interfaces/linkable';
import {
  getPageOverrideFromType,
  getSectionBackgrounds,
} from '@/schema/objects/page-override';
import { instantiate } from '@/schema/sanity-interface';

export default function SolutionPageRenderer({
  solution,
  settings,
}: {
  solution: Solution | null;
  settings: Settings | null;
}) {
  if (!solution) {
    return null;
  }

  const pageOverride = settings
    ? getPageOverrideFromType({
        pageType: 'solution',
        pageOverrides: settings.pageOverrides,
      })
    : undefined;

  const sectionBackgrounds = getSectionBackgrounds(pageOverride);
  const bottomSections = pageOverride?.bottomSections;

  return (
    <PageWrapper
      colorPalette={settings?.colorPalette}
      primaryColorPalette={settings?.primaryColorPalette}
      className="flex flex-col min-h-screen"
    >
      {settings && <PageHeader settings={settings} />}
      <main className="flex-1 flex-grow">
        <PageSectionRenderer
          pageSection={{
            _type: 'oneOffPageSection',
            background: sectionBackgrounds['lead'],
            title: solution.name,
            tagline: 'Solution',
            subtitle: solution.description,
            media: solution.thumbnail,
            mediaAlignment: 'right',
            mediaSize: 'md',
            alignment: 'start',
          }}
          settings={settings}
          index={0}
        />
        {solution.services && solution.services.length > 0 && (
          <PageSectionRenderer
            pageSection={{
              _type: 'oneOffPageSection',
              background: sectionBackgrounds['checkOutTheseServices'],
              title: 'Check Out These Services',
              subtitle: solution.servicesDescription,
              blocks: [
                {
                  _type: 'itemsListPageBlock',
                  items: solution.services.map((service) => ({
                    name: service.name,
                    body: service.description,
                    media: service.thumbnail,
                    cta: {
                      type: 'filled',
                      text: 'Learn More',
                      action: {
                        _type: 'internalUrlAction',
                        linkable: instantiate(service, linkableImplementations),
                      },
                    },
                  })),
                },
              ],
            }}
            settings={settings}
            index={1}
          />
        )}
        {solution.faqs && solution.faqs.length > 0 && (
          <PageSectionRenderer
            pageSection={{
              _type: 'oneOffPageSection',
              background: sectionBackgrounds['faqs'],
              title: 'Frequently Asked Questions',
              blocks: [
                {
                  _type: 'faqPageBlock',
                  faqs: solution.faqs,
                },
              ],
            }}
            settings={settings}
            index={2}
          />
        )}
        {solution.successStories && solution.successStories.length > 0 && (
          <PageSectionRenderer
            pageSection={{
              _type: 'oneOffPageSection',
              background: sectionBackgrounds['successStories'],
              title: 'Check Out These Related Success Stories',
              blocks: [
                {
                  _type: 'itemsListPageBlock',
                  items: solution.successStories.map((story) => ({
                    name: story.name,
                    body: story.description,
                    media: story.thumbnail,
                    cta: {
                      type: 'filled',
                      text: 'Learn More',
                      action: {
                        _type: 'internalUrlAction',
                        linkable: instantiate(story, linkableImplementations),
                      },
                    },
                  })),
                },
              ],
            }}
            settings={settings}
            index={2}
          />
        )}
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
