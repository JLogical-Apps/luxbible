import PageFooter from '@/components/page/PageFooter';
import PageHeader from '@/components/page/PageHeader';
import PageWrapper from '@/components/page/PageWrapper';
import PageSectionRenderer from '@/components/renderers/PageSectionRenderer';
import { Project } from '@/schema/documents/project';
import { Settings } from '@/schema/documents/singletons/settings';
import {
  getPageOverrideFromType,
  getSectionBackgrounds,
} from '@/schema/objects/page-override';

export default function ProjectPageRenderer({
  project,
  settings,
}: {
  project: Project | null;
  settings: Settings | null;
}) {
  if (!project) {
    return null;
  }

  const pageOverride = settings
    ? getPageOverrideFromType({
        pageType: 'project',
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
            title: project.name,
            tagline: 'Project',
            subtitle: project.description,
            ctas: project.link
              ? [
                  {
                    text: 'Check It Out',
                    type: 'filled',
                    action: {
                      _type: 'externalUrlAction',
                      url: project.link,
                      newTab: true,
                    },
                  },
                ]
              : [],
            media: project.thumbnail,
            mediaAlignment: 'right',
            mediaSize: 'md',
            alignment: 'start',
          }}
          settings={settings}
          index={0}
        />
        <PageSectionRenderer
          pageSection={{
            _type: 'oneOffPageSection',
            background: sectionBackgrounds['insights'],
            title: 'Project Insights',
            body: project.insights,
          }}
          settings={settings}
          index={1}
        />
        {project.testimonial && (
          <PageSectionRenderer
            pageSection={{
              _type: 'oneOffPageSection',
              background: sectionBackgrounds['testimonial'],
              title: 'What the Founder Thinks',
              blocks: [
                {
                  _type: 'testimonialPageBlock',
                  testimonials: [project.testimonial],
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
