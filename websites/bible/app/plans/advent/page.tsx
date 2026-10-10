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
  'A free Advent plan in Lux Bible with a short reading and study notes for every day from the first Sunday of Advent to Christmas Day.';

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
        subtitle="Below each day's passages is a Study Notes row. Everything in it is stored in Lux, so it works offline too."
      >
        <FeatureShowcase
          features={[
            {
              title: 'Start with the big picture',
              subtitle:
                'Each day opens with what the passage says and where it sits in the story, followed by short excerpts from the commentaries in Lux, each one credited.',
              image: studyNotesImage,
            },
            {
              title: 'Go deeper without leaving the plan',
              subtitle:
                "Read the day's passage, then tap through to the full commentary, a person's profile, or a dictionary entry, and come right back to the day you're on.",
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
        subtitle={`${adventDayCount} readings that move from the first promises in Genesis to the shepherds in Bethlehem.`}
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
