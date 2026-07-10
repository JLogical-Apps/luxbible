import { IconBrandDiscordFilled } from '@tabler/icons-react';
import Image from 'next/image';
import { CSSProperties } from 'react';

import AppStoreButtons from '@/components/blocks/AppStoreButtons';
import CtaButton from '@/components/blocks/CtaButton';
import FeatureShowcase from '@/components/blocks/FeatureShowcase';
import Page from '@/components/layout/Page';
import Section from '@/components/layout/Section';
import { site } from '@/lib/site';

// "Light Button" palette — a white button with dark text (used for the Discord CTA).
const lightButtonVars = {
  '--emphasis': '200 0% 100%',
  '--emphasis-soft': '240 5% 96%',
  '--on-emphasis': '240 10% 4%',
  '--on-emphasis-soft': '240 6% 10%',
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
              title: 'Highlight, note, remember',
              subtitle:
                'Highlight verses or individual words in any color, and attach notes wherever your thoughts take you.',
              video: '/media/highlights.webm',
            },
            {
              title: 'Search the whole Bible',
              subtitle:
                "Search any word, phrase, or Strongs word across the entire Bible. Find the verse you're thinking of in seconds.",
              video: '/media/search.webm',
            },
          ]}
        />
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
