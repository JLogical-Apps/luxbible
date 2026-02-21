import PageFooter from '@/components/page/PageFooter';
import PageHeader from '@/components/page/PageHeader';
import PageWrapper from '@/components/page/PageWrapper';
import PageSectionRenderer from '@/components/renderers/PageSectionRenderer';
import { Service } from '@/schema/documents/service';
import { Settings } from '@/schema/documents/singletons/settings';
import { linkableImplementations } from '@/schema/interfaces/linkable';
import {
  getPageOverrideFromType,
  getSectionBackgrounds
} from '@/schema/objects/page-override';
import { instantiate } from '@/schema/sanity-interface';

export default function ServicePageRenderer({
  service,
  settings
}: {
  service: Service | null;
  settings: Settings | null;
}) {
  if (!service) {
    return null;
  }

  const pageOverride = settings
    ? getPageOverrideFromType({
      pageType: 'service',
      pageOverrides: settings.pageOverrides
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
            title: service.name,
            tagline: 'Service',
            subtitle: service.description,
            media: service.thumbnail,
            mediaAlignment: 'right',
            mediaSize: 'md',
            alignment: 'start'
          }}
          settings={settings}
          index={0}
        />
        <PageSectionRenderer
          pageSection={{
            _type: 'oneOffPageSection',
            background: sectionBackgrounds['whatIOffer'],
            title: 'What I Offer',
            subtitle: `Here's a glimpse into the toolkit and approach I bring to every ${service.name.toLowerCase()} project:`,
            blocks: [
              {
                _type: 'featureListPageBlock',
                features: service.features
              }
            ]
          }}
          settings={settings}
          index={1}
        />
        {service.successStories && service.successStories.length > 0 &&
          <PageSectionRenderer
            pageSection={{
              _type: 'oneOffPageSection',
              background: sectionBackgrounds['successStories'],
              title: 'Check Out These Related Success Stories',
              blocks: [
                {
                  _type: 'itemsListPageBlock',
                  items: service.successStories.map((story) => ({
                    name: story.name,
                    body: story.description,
                    media: story.thumbnail,
                    cta: {
                      type: 'filled',
                      text: 'Learn More',
                      action: {
                        _type: 'internalUrlAction',
                        linkable: instantiate(story, linkableImplementations)
                      }
                    }
                  }))
                }
              ]
            }}
            settings={settings}
            index={2}
          />}
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
