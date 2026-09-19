import { Metadata } from 'next';

import Page from '@/components/layout/Page';
import Prose from '@/components/layout/Prose';
import { site } from '@/lib/site';

const description =
  'How to read and write .lxbp files: the plain-JSON Bible reading plan format used by Lux Bible.';

export const metadata: Metadata = {
  title: 'The .lxbp Bible Plan Format',
  description,
  openGraph: {
    title: 'The .lxbp Bible Plan Format',
    description,
    url: `${site.domain}/resources/lxbp`,
    type: 'article',
  },
};

const basicExample = `{
  "name": "The Beatitudes",
  "days": [
    { "passages": ["Matt.5.1-Matt.5.12"] },
    { "passages": ["Matt.5.13-Matt.5.16"] },
    { "passages": [] }
  ]
}`;

const fullExample = `{
  "name": "Ruth & Psalm 119",
  "color": "green",
  "days": [
    { "passages": ["Ruth.1", "Ps.119.1-Ps.119.88"] },
    { "passages": ["Ruth.2", "Ps.119.89-Ps.119.176"] },
    { "passages": ["Ruth.3"] },
    { "passages": ["Ruth.4"] },
    { "passages": [] }
  ]
}`;

export default function LxbpFormatPage() {
  return (
    <Page>
      <div className="container max-w-4xl py-16 lg:py-20 xl:py-24">
        <header className="mx-auto max-w-3xl">
          <p className="font-semibold text-foreground-soft">Resources</p>
          <h1 className="title-lg mt-3">The .lxbp Bible Plan Format</h1>
          <p className="subtitle mt-6">
            <code>.lxbp</code> is a Bible reading plan written as plain JSON:
            a name, a color, and a list of days, each holding the passages to
            read. Export any plan from Lux to a <code>.lxbp</code> file to
            share it, or write one by hand, no app required.
          </p>
        </header>

        <div className="mx-auto mt-12 max-w-3xl">
          <Prose>
            <p>
              This page is the full spec. It&apos;s short enough to read in a
              couple of minutes, and precise enough that an AI assistant can
              read it too, so you can point ChatGPT, Claude, or another
              assistant at this URL and ask it to write a plan for you.
            </p>

            <h2>File structure</h2>

            <p>A file has three top-level fields:</p>

            <ul>
              <li>
                <code>name</code> (required): the plan&apos;s display name.
              </li>
              <li>
                <code>days</code> (required): 1 to 365 day objects, in reading
                order.
              </li>
              <li>
                <code>color</code> (optional): <code>red</code>,{' '}
                <code>orange</code>, <code>yellow</code>, <code>green</code>,{' '}
                <code>blue</code>, or <code>violet</code>. Lux picks a color
                automatically when this is left out.
              </li>
            </ul>

            <p>
              Each day is an object with a <code>passages</code> array. An
              empty array marks a Review &amp; Reflect day, a built-in pause
              with no new reading.
            </p>

            <pre>
              <code>{basicExample}</code>
            </pre>

            <h2>Writing passages</h2>

            <p>
              Passages use OSIS references: <code>Matt.5</code> for a whole
              chapter, <code>Matt.5.3</code> for a single verse, or{' '}
              <code>Matt.5.3-Matt.5.10</code> for a range. A range repeats the
              full reference on both ends, even within the same chapter.
            </p>

            <p>
              Book identifiers follow the standard OSIS abbreviations, such
              as <code>Gen</code>, <code>Ruth</code>, <code>Ps</code>,{' '}
              <code>Matt</code>, and <code>Rev</code>. Every reference has to
              point at real Scripture, and a day can&apos;t list the same
              passage twice, though the same passage can reappear on a later
              day.
            </p>

            <h2>A complete example</h2>

            <p>
              A five-day plan pairing the book of Ruth with Psalm 119, split
              in half across two days. It demonstrates a day with more than one passage, a
              verse range, and a closing Review &amp; Reflect day:
            </p>

            <pre>
              <code>{fullExample}</code>
            </pre>

            <h2>Rules at a glance</h2>

            <ul>
              <li>
                <code>name</code> can&apos;t be empty or only whitespace.
              </li>
              <li>
                <code>days</code> needs between 1 and 365 entries.
              </li>
              <li>At least one day in the plan needs a passage.</li>
              <li>
                A day&apos;s <code>passages</code> array can&apos;t repeat the
                same reference.
              </li>
              <li>Every reference must resolve to real, existing Scripture.</li>
              <li>
                Nothing outside <code>name</code>, <code>days</code>,{' '}
                <code>color</code>, and <code>passages</code> is recognized;
                extra fields are ignored rather than rejected.
              </li>
            </ul>

            <h2>Using a plan in Lux</h2>

            <p>
              In Lux, open Bible Plans and choose Create Custom Plan. From
              there you can import a <code>.lxbp</code> file, paste its
              contents directly, or hand the plan&apos;s description to an AI
              assistant and let it write the file for you.
            </p>
          </Prose>
        </div>
      </div>
    </Page>
  );
}
