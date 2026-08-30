import {
  IconBrandDiscordFilled,
  IconBrandInstagram,
} from '@tabler/icons-react';
import Image from 'next/image';
import { CSSProperties } from 'react';

import AppStoreButtons from '@/components/blocks/AppStoreButtons';
import AppStoreScreenshots from '@/components/blocks/AppStoreScreenshots';
import CtaButton from '@/components/blocks/CtaButton';
import FeatureShowcase from '@/components/blocks/FeatureShowcase';
import InstagramFeed from '@/components/blocks/InstagramFeed';
import Page from '@/components/layout/Page';
import Section from '@/components/layout/Section';
import { site } from '@/lib/site';

const lightButtonVars = {
  '--emphasis': '200 0% 100%',
  '--emphasis-soft': '240 5% 96%',
  '--on-emphasis': '240 10% 4%',
  '--on-emphasis-soft': '240 6% 10%',
} as CSSProperties;

const instagramPaletteVars = {
  '--emphasis': '336 73% 54%',
  '--emphasis-soft': '323 59% 48%',
  '--on-emphasis': '0 0% 100%',
  '--on-emphasis-soft': '0 0% 100%',
} as CSSProperties;

export default function HomePage() {
  return (
    <Page>
      <Section
        background="dots"
        align="center"
        titleSize="lg"
        useH1
        tagline={site.name}
        title={
          <span className="gradient-heading">
            Scripture Deserves Better Software
          </span>
        }
        subtitle={
          <>
            Powerful study tools. Beautifully designed. Works offline.{' '}
            <span className="gradient-heading">Free forever.</span>
          </>
        }
        mediaBelow={
          <>
            <Image
              src="/media/hero-screenshots.png"
              alt="Lux Bible app screenshots"
              width={1444}
              height={1532}
              priority
              className="hidden md:block mx-auto h-auto w-full rounded-2xl"
            />
            <Image
              src="/media/hero-screenshots-mobile.png"
              alt="Lux Bible app screenshots"
              width={1214}
              height={1583}
              priority
              className="block md:hidden mx-auto h-auto w-full rounded-2xl"
            />
          </>
        }
      >
        <div className="flex flex-center gap-4">
          <CtaButton
            text="Learn More"
            href="#built-for-readers"
            variant="ghost"
          />
          <CtaButton text="Download for Free" href="#download" />
        </div>
      </Section>

      <Section
        id="built-for-readers"
        align="start"
        title="Built for Readers"
        subtitle="A distraction-free Bible experience designed for clarity, speed, and focus."
      >
        <FeatureShowcase
          features={[
            {
              title: 'Read without distraction',
              subtitle:
                'The Bible takes center stage. Toolbars stay out of your way until you need them.',
              video: '/media/videos/read-without-distraction.webm',
            },
            {
              title: 'Follow a Bible plan',
              subtitle:
                'Follow guided Bible plans that give your reading a clear path and a simple next step.',
              video: '/media/videos/bible-plans.webm',
            },
            {
              title: 'Go anywhere, instantly',
              subtitle:
                'Jump to any chapter by typing a reference. Your recent passages and bookmarks are always a tap away. Swipe the toolbar to go back.',
              video: '/media/videos/go-anywhere.webm',
            },
            {
              title: 'Your tools, your way',
              subtitle:
                "Whether you're a note-taker or a deep studier, Lux puts the right tools within reach.",
              video: '/media/videos/toolbars.webm',
            },
          ]}
        />
      </Section>

      <Section
        id="built-for-note-takers"
        align="start"
        title="Built for Note-takers"
        subtitle="Capture what stands out, shape it your way, and keep every insight close at hand."
      >
        <FeatureShowcase
          features={[
            {
              title: 'Annotate verses and phrases',
              subtitle:
                'Add your thoughts to a whole verse or a specific phrase, so the details that matter stay connected to the text.',
              video: '/media/videos/annotate-verses-or-phrases.webm',
            },
            {
              title: 'Make highlights your own',
              subtitle:
                'Give each highlight style a name and a purpose, so the patterns in your reading begin to stand out.',
              video: '/media/videos/highlight-styles.webm',
            },
            {
              title: 'Keep notes in notebooks',
              subtitle:
                'Keep related annotations together in notebooks, and toggle any notebook off when you want to focus on something else.',
              video: '/media/videos/notebooks.webm',
            },
            {
              title: 'See every annotation together',
              subtitle:
                'Review all your notes and highlights in one place, then jump right back to the verse that sparked them.',
              video: '/media/videos/view-annotations.webm',
            },
          ]}
        />
      </Section>

      <Section
        id="built-for-studiers"
        align="start"
        title="Built for Studiers"
        subtitle="Powerful tools. No learning curve."
      >
        <FeatureShowcase
          features={[
            {
              title: 'Dig deeper, right where you are',
              subtitle:
                'Dig into the original language, read trusted commentary, or see relevant cross-references, all in the same place as the text.',
              video: '/media/videos/study-tools.webm',
            },
            {
              title: 'Search the whole Bible',
              subtitle:
                "Search any word, phrase, or Strongs word across the entire Bible. Find the verse you're thinking of in seconds.",
              video: '/media/videos/search.webm',
            },
            {
              title: 'Keep your study in view',
              subtitle:
                'Open a study panel alongside Scripture, so cross-references, commentaries, or the original language stay in view as you read.',
              video: '/media/videos/study-panels.webm',
            },
            {
              title: 'Explore the words behind the text',
              subtitle:
                'Look up words in the built-in lexicon and dictionary to bring context and shed light on Scripture.',
              video: '/media/videos/word-lookup.webm',
            },
          ]}
        />
      </Section>

      <Section
        id="tips-and-updates"
        background="dots"
        align="responsive"
        paletteVars={instagramPaletteVars}
        tagline="Tips and Updates"
        title={
          <>
            Follow along on <span className="gradient-heading">Instagram</span>
          </>
        }
        subtitle="See the latest Lux updates, discover tips and tricks, and get more from your time in Scripture."
      >
        <div className="flex flex-col items-center gap-8">
          <CtaButton
            text="Follow @luxbible.app"
            href={site.social.instagram}
            external
            icon={
              <IconBrandInstagram style={{ width: '1.5em', height: '1em' }} />
            }
          />
          <InstagramFeed />
        </div>
      </Section>

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
            googlePlayUrl={site.googlePlayUrl}
          />
          <AppStoreScreenshots />
        </div>
      </Section>

      <Section
        id="community"
        background="dots"
        align="responsive"
        tagline="Join the Community"
        title={
          <>
            Read together,{' '}
            <span className="gradient-heading">build together</span>
          </>
        }
        subtitle="Behind Lux is a small community of readers and studiers shaping the app one release at a time. Come tell us what's working, what's missing, and what you'd love to see."
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
  );
}
