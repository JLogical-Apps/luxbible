import { IconBrandDiscordFilled } from '@tabler/icons-react';
import { Metadata } from 'next';
import { ReactNode } from 'react';

import AdventHeroSubtitle from '@/components/blocks/AdventHeroSubtitle';
import AdventProvider from '@/components/blocks/AdventProvider';
import AdventStatusLabel from '@/components/blocks/AdventStatusLabel';
import AndroidAppRedirect from '@/components/blocks/AndroidAppRedirect';
import CtaButton from '@/components/blocks/CtaButton';
import DownloadCtaButton from '@/components/blocks/DownloadCtaButton';
import DownloadSection from '@/components/blocks/DownloadSection';
import StickyDownloadBar from '@/components/blocks/StickyDownloadBar';
import Page from '@/components/layout/Page';
import Section from '@/components/layout/Section';
import LoopingVideo from '@/components/media/LoopingVideo';
import PhoneFrame from '@/components/media/PhoneFrame';
import Video from '@/components/media/Video';
import {
  adventDayCount,
  adventWeeks,
  getAdventStatus,
  getUpcomingAdvent,
} from '@/lib/advent';
import { adventCampaign } from '@/lib/campaign';
import { lightButtonVars } from '@/lib/palettes';
import { site } from '@/lib/site';

// The dates roll over to next year's Advent after Christmas.
export const revalidate = 86400;

const appUrl = `${site.appDomain}/plans/advent`;
const title = 'Advent Reading Plan';
const description = `Study the people and promises surrounding Jesus’ birth, then explore the work of the Father, Son, and Holy Spirit in a free ${adventDayCount}-day Advent plan.`;
const recordingAspectRatio = '540/1168';

const startSteps = [
  {
    title: 'Download Lux',
    description: "It's free, with no ads and no account to create.",
  },
  {
    title: 'Find Advent',
    description: 'Open Bible Plans and tap +. Advent is right at the top.',
  },
  {
    title: 'Tap Start Plan',
    description:
      'The pace is already set to finish on Christmas Day. Starting late? Lux shows how many days behind you are, so you can read a little extra and catch up.',
  },
];

export const metadata: Metadata = {
  title,
  description,
  alternates: { canonical: '/plans/advent' },
  openGraph: { title, description, url: '/plans/advent' },
  itunes: { appId: site.appStoreId, appArgument: appUrl },
};

function SideBySide({
  media,
  children,
  isMediaFirst = false,
}: {
  media: ReactNode;
  children: ReactNode;
  isMediaFirst?: boolean;
}) {
  return (
    <div className="mx-auto flex max-w-4xl flex-col items-center gap-12 px-2 md:flex-row md:gap-16">
      <div className="w-full flex-1">{children}</div>
      <div className={isMediaFirst ? 'md:order-first' : undefined}>{media}</div>
    </div>
  );
}

export default function AdventPage() {
  const { year, start, days } = getUpcomingAdvent(new Date());

  return (
    <AdventProvider
      year={year}
      start={start.getTime()}
      days={days}
      initialStatus={getAdventStatus(new Date(), start, days.length)}
    >
      <Page>
        <Section
          id="hero"
          background="dots"
          align="center"
          titleSize="lg"
          useH1
          tagline={
            <span className="inline-flex items-center gap-2 rounded-full bg-background-soft px-3 py-1 text-sm">
              <span className="h-2 w-2 rounded-full bg-emphasis" />
              <AdventStatusLabel />
            </span>
          }
          title={
            <>
              Don&apos;t just read the Christmas story.{' '}
              <span className="gradient-heading">Study it.</span>
            </>
          }
          subtitle={<AdventHeroSubtitle />}
          mediaBelow={
            <PhoneFrame className="mx-auto w-72 sm:w-80">
              <LoopingVideo
                webm="/media/advent/advent-hero.webm"
                mp4="/media/advent/advent-hero.mp4"
                poster="/media/advent/advent-hero.webp"
                aspectRatio={recordingAspectRatio}
                ariaLabel="The Advent plan in Lux Bible, with stars twinkling and clouds drifting over its night scene"
                className="h-full object-cover"
              />
            </PhoneFrame>
          }
        >
          <div id="hero-download" className="flex flex-col items-center gap-4">
            <DownloadCtaButton
              appStoreUrl={site.appStoreUrl}
              appStoreProviderToken={site.appStoreProviderToken}
              googlePlayUrl={site.googlePlayUrl}
              defaultCampaign={adventCampaign}
            />
            <p className="text-sm text-foreground-soft/70">
              Free · No ads · No account
            </p>
          </div>
          <AndroidAppRedirect
            googlePlayUrl={site.googlePlayUrl}
            defaultCampaign={adventCampaign}
          />
        </Section>

        <Section
          id="start"
          align="start"
          title="How to Start"
          subtitle="Once Lux is on your phone, Advent is a few taps away."
        >
          <SideBySide
            media={
              <PhoneFrame className="w-72">
                <Video
                  src="/media/advent/advent-start.webm"
                  aspectRatio={recordingAspectRatio}
                  ariaLabel="Starting the Advent plan from Start A Bible Plan in Lux"
                  className="h-full w-full"
                />
              </PhoneFrame>
            }
          >
            <ol className="flex flex-col gap-4">
              {startSteps.map((step, index) => (
                <li
                  key={step.title}
                  className="flex gap-4 rounded-2xl bg-background-soft p-6"
                >
                  <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-emphasis text-sm font-semibold text-on-emphasis">
                    {index + 1}
                  </span>
                  <div>
                    <p className="font-serif text-lg font-bold">{step.title}</p>
                    <p className="mt-1 text-foreground-soft">
                      {step.description}
                    </p>
                  </div>
                </li>
              ))}
            </ol>
          </SideBySide>
        </Section>

        <Section
          id="topics"
          align="start"
          title="What You'll Study"
          subtitle="Each day has a short reading, study notes with a word from the Hebrew or Greek, and a question to reflect on."
        >
          <SideBySide
            isMediaFirst
            media={
              <PhoneFrame className="w-72">
                <Video
                  src="/media/advent/advent-day.webm"
                  aspectRatio={recordingAspectRatio}
                  ariaLabel="Reading a day of the Advent plan in Lux, from the passage to the study notes, a Greek word, and the reflection question"
                  className="h-full w-full"
                />
              </PhoneFrame>
            }
          >
            <ol className="flex flex-col gap-6">
              {adventWeeks.map((week) => (
                <li key={week.title}>
                  <p className="text-sm font-semibold text-foreground-soft/70">
                    Days {week.firstDay}–{week.lastDay}
                  </p>
                  <p className="mt-1 font-serif text-lg font-bold">
                    {week.title}
                  </p>
                  <p className="mt-1 text-foreground-soft">
                    {week.description}
                  </p>
                </li>
              ))}
            </ol>
          </SideBySide>
        </Section>

        <DownloadSection
          defaultCampaign={adventCampaign}
          subtitle="Lux is free, with no ads and no account, and the Advent plan works offline."
        />

        <Section
          id="community"
          background="dots"
          align="responsive"
          tagline="Join the Community"
          title={
            <>
              Read together,{' '}
              <span className="gradient-heading">reflect together</span>
            </>
          }
          subtitle="Every day ends with a question to reflect on. Join the Lux Discord to read how others are answering and share your own."
        >
          <div className="flex flex-center gap-4">
            <CtaButton
              text="Join the Discord"
              href={site.discordUrl}
              external
              paletteVars={lightButtonVars}
              icon={
                <IconBrandDiscordFilled
                  style={{ width: '1.5em', height: '1em' }}
                />
              }
            />
          </div>
        </Section>
      </Page>
      <StickyDownloadBar
        title="Advent Reading Plan"
        subtitle={<AdventStatusLabel />}
        showAfterId="hero-download"
        defaultCampaign={adventCampaign}
      />
    </AdventProvider>
  );
}
