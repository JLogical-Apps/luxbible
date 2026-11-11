import { Metadata } from 'next';

import bannerImage from '@/assets/advent/banner.webp';
import paceImage from '@/assets/advent/pace.webp';
import planCardImage from '@/assets/advent/plan-card.webp';
import studyNotesImage from '@/assets/advent/study-notes.webp';
import AdventCandles from '@/components/blocks/AdventCandles';
import AndroidAppRedirect from '@/components/blocks/AndroidAppRedirect';
import AppStoreButtons from '@/components/blocks/AppStoreButtons';
import DownloadSection from '@/components/blocks/DownloadSection';
import FeatureShowcase from '@/components/blocks/FeatureShowcase';
import OpenInAppLink from '@/components/blocks/OpenInAppLink';
import Page from '@/components/layout/Page';
import Section from '@/components/layout/Section';
import LoopingVideo from '@/components/media/LoopingVideo';
import {
  adventDayCount,
  adventWeeks,
  formatAdventDate,
  getUpcomingAdvent,
} from '@/lib/advent';
import { adventCampaign } from '@/lib/campaign';
import { site } from '@/lib/site';

// The dates roll over to next year's Advent after Christmas.
export const revalidate = 86400;

const appUrl = `${site.appDomain}/plans/advent`;
const title = 'Advent Reading Plan';
const description =
  'Study the people and promises surrounding Jesus’ birth, then explore the work of the Father, Son, and Holy Spirit in a free 27-day Advent plan.';

export const metadata: Metadata = {
  title,
  description,
  alternates: { canonical: '/plans/advent' },
  openGraph: { title, description, url: '/plans/advent' },
  itunes: { appId: site.appStoreId, appArgument: appUrl },
};

export default function AdventPage() {
  const { year, start, end } = getUpcomingAdvent(new Date());

  return (
    <Page>
      <Section
        background="dots"
        align="center"
        titleSize="lg"
        useH1
        tagline={`Advent ${year}`}
        title={
          <>
            Don&apos;t just read the Christmas story.{' '}
            <span className="gradient-heading">Study it.</span>
          </>
        }
        subtitle={`A free reading plan in Lux Bible, with study notes for every day of Advent, from ${formatAdventDate(
          start,
        )} to Christmas Day.`}
        mediaBelow={
          <LoopingVideo
            webm="/media/advent/scene.webm"
            mp4="/media/advent/scene.mp4"
            poster="/media/advent/scene.webp"
            ariaLabel="The Advent plan's scene: three lit candles, a star over a stable, and a night sky starting to warm toward dawn"
            className="rounded-2xl"
          />
        }
      >
        <div className="flex flex-col items-center gap-4">
          <AppStoreButtons
            appStoreUrl={site.appStoreUrl}
            appStoreProviderToken={site.appStoreProviderToken}
            googlePlayUrl={site.googlePlayUrl}
            defaultCampaign={adventCampaign}
          />
          <OpenInAppLink href={appUrl}>
            Already have Lux? Open the plan
          </OpenInAppLink>
        </div>
        <AndroidAppRedirect
          googlePlayUrl={site.googlePlayUrl}
          defaultCampaign={adventCampaign}
        />
      </Section>

      <Section
        id="study-notes"
        align="start"
        title="Study notes for every reading"
        subtitle="Open Study Notes below the day’s passages for short notes and optional resources. The notes and bundled texts are available offline."
      >
        <FeatureShowcase
          features={[
            {
              title: 'Start with the big picture',
              subtitle:
                'Follow the people who waited for the promised Savior. Each day’s Go Deeper note helps you explore a Hebrew or Greek word from the reading.',
              image: studyNotesImage,
            },
            {
              title: 'Explore related resources',
              subtitle:
                'Open related Scripture, commentaries, and historic creeds and confessions in Lux. Selected BibleProject videos are available on YouTube.',
              video: '/media/advent/day-walkthrough.webm',
            },
          ]}
        />
      </Section>

      <Section
        id="follow-along"
        align="start"
        title="Read along until Christmas"
        subtitle="The plan has its own scene that changes as you read, and Lux helps you finish on Christmas Day."
      >
        <FeatureShowcase
          features={[
            {
              title: 'Light a candle each week',
              subtitle:
                'The first reading of each week lights another candle, and every day you finish brings the night a little closer to dawn.',
              image: planCardImage,
            },
            {
              title: 'Finish on Christmas Day',
              subtitle: `Start on the first Sunday of Advent, ${formatAdventDate(
                start,
              )}, and read a day at a time. If you start late, Lux paces the plan to finish on ${formatAdventDate(
                end,
              )} and shows when you're behind.`,
              image: paceImage,
            },
            {
              title: 'Counting down',
              subtitle:
                "In the weeks before Christmas, Advent sits at the top of Start A Bible Plan with a countdown, so it's easy to find.",
              image: bannerImage,
            },
          ]}
        />
      </Section>

      <Section
        id="weeks"
        align="start"
        title="Four weeks, four candles"
        subtitle={`${adventDayCount} days following the promises and witnesses of Jesus’ birth, with a final six-day study of the Trinity.`}
      >
        <div className="mx-auto grid max-w-4xl gap-6 sm:grid-cols-2">
          {adventWeeks.map((week, index) => (
            <div
              key={week.title}
              className="flex flex-col gap-4 rounded-2xl bg-background-soft p-6"
            >
              <AdventCandles
                litCount={index + 1}
                className="h-14 w-auto self-start"
              />
              <div>
                <p className="text-sm font-semibold text-emphasis">
                  Week {index + 1}
                </p>
                <h2 className="font-serif text-xl font-bold">{week.title}</h2>
              </div>
              <p className="text-foreground-soft">{week.description}</p>
              <ul className="mt-auto flex flex-col gap-1 text-sm text-foreground-soft/70">
                {week.passages.map((passage) => (
                  <li key={passage}>{passage}</li>
                ))}
              </ul>
            </div>
          ))}
        </div>
      </Section>

      <DownloadSection defaultCampaign={adventCampaign} />
    </Page>
  );
}
