import {
  IconBrandDiscordFilled,
  IconBrandInstagram,
} from '@tabler/icons-react';
import Image from 'next/image';
import { CSSProperties } from 'react';

import AppStoreButtons from '@/components/blocks/AppStoreButtons';
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
          <CtaButton text="Learn More" href="#built-to-read" variant="ghost" />
          <CtaButton text="Download for Free" href="#download" />
        </div>
      </Section>

      <Section
        id="built-to-read"
        align="start"
        title="Built to Read"
        subtitle="A distraction-free Bible experience designed for clarity, speed, and focus."
      >
        <FeatureShowcase
          features={[
            {
              title: 'Read without distraction',
              subtitle:
                'The Bible takes center stage. Toolbars stay out of your way until you need them.',
              video: '/media/read-without-distraction.webm',
            },
            {
              title: 'Follow a plan, one day at a time',
              subtitle:
                'Build a steady reading rhythm with Bible plans that guide you through Scripture, one meaningful passage at a time.',
              video: '/media/go-anywhere.webm',
            },
            {
              title: 'Go anywhere, instantly',
              subtitle:
                'Jump to any chapter by typing a reference. Your recent passages and bookmarks are always a tap away. Swipe the toolbar to go back.',
              video: '/media/go-anywhere.webm',
            },
            {
              title: 'Your tools, your way',
              subtitle:
                "Whether you're a note-taker or a deep studier, Lux puts the right tools within reach.",
              video: '/media/your-tools.webm',
            },
          ]}
        />
      </Section>

      <Section
        align="start"
        title="Built to Write"
        subtitle="Capture what stands out, shape it your way, and keep every insight close at hand."
      >
        <FeatureShowcase
          features={[
            {
              title: 'Annotate verses and phrases',
              subtitle:
                'Add your thoughts to a whole verse or a specific phrase, so the details that matter stay connected to the text.',
              video: '/media/highlights.webm',
            },
            {
              title: 'Make highlights your own',
              subtitle:
                'Choose highlight styles that fit the way you read and make important words and passages easy to find again.',
              video: '/media/highlights.webm',
            },
            {
              title: 'Keep notes in notebooks',
              subtitle:
                'Organize annotations into notebooks for studies, sermons, questions, and everything else you want to return to.',
              video: '/media/your-tools.webm',
            },
            {
              title: 'See every annotation together',
              subtitle:
                'Review all your notes and highlights in one place, then jump right back to the verse that sparked them.',
              video: '/media/search.webm',
            },
          ]}
        />
      </Section>

      <Section
        align="start"
        title="Built to Study"
        subtitle="Powerful tools. No learning curve."
      >
        <FeatureShowcase
          features={[
            {
              title: 'Dig deeper, right where you are',
              subtitle:
                'Dig into the original language, read trusted commentary, or see relevant cross-references, all in the same place as the text.',
              video: '/media/dig-deeper.webm',
            },
            {
              title: 'Search the whole Bible',
              subtitle:
                "Search any word, phrase, or Strongs word across the entire Bible. Find the verse you're thinking of in seconds.",
              video: '/media/search.webm',
            },
            {
              title: 'Keep your study in view',
              subtitle:
                'Open a study panel alongside Scripture, so cross-references, commentary, and word details stay in view as you read.',
              video: '/media/dig-deeper.webm',
            },
            {
              title: 'Explore the words behind the text',
              subtitle:
                'Look up words in the built-in lexicon and dictionary to bring context and meaning closer to the passage.',
              video: '/media/dig-deeper.webm',
            },
          ]}
        />
      </Section>

      <Section
        background="dots"
        align="responsive"
        paletteVars={instagramPaletteVars}
        tagline="Learn More"
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
        <AppStoreButtons
          appStoreUrl={site.appStoreUrl}
          googlePlayUrl={site.googlePlayUrl}
        />
      </Section>

      <Section
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
