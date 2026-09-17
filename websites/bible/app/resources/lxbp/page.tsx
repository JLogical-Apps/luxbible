import { Metadata } from 'next';

import Page from '@/components/layout/Page';
import Prose from '@/components/layout/Prose';
import { site } from '@/lib/site';

export const metadata: Metadata = {
  title: 'The .lxbp Bible Plan Format',
  description:
    'A short reference for the .lxbp Bible plan file format used by Lux Bible, with the file structure and examples.',
  openGraph: {
    title: 'The .lxbp Bible Plan Format',
    description:
      'A short reference for the .lxbp Bible plan file format used by Lux Bible, with the file structure and examples.',
    url: `${site.domain}/resources/lxbp`,
    type: 'article',
  },
};

const basicExample = `{
  "name": "Romans in 30 Days",
  "days": [
    { "passages": ["Rom.1"] },
    { "passages": ["Rom.2"] },
    { "passages": [] }
  ]
}`;

const fullExample = `{
  "name": "Psalms and Proverbs in 90 Days",
  "color": "violet",
  "days": [
    { "passages": ["Ps.1", "Prov.1.1-Prov.1.7"] },
    { "passages": ["Ps.2-Ps.3"] },
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
            A <code>.lxbp</code> file is a Bible reading plan saved as plain
            JSON. Lux can import one, and any plan can be exported to share.
          </p>
        </header>

        <div className="mx-auto mt-12 max-w-3xl">
          <Prose>
            <h2>File structure</h2>

            <p>A file has three top-level fields:</p>

            <ul>
              <li>
                <code>name</code> (required): the plan&apos;s display name.
              </li>
              <li>
                <code>days</code> (required): 1 to 365 day objects in reading
                order.
              </li>
              <li>
                <code>color</code> (optional): <code>red</code>,{' '}
                <code>orange</code>, <code>yellow</code>, <code>green</code>,{' '}
                <code>blue</code>, or <code>violet</code>.
              </li>
            </ul>

            <p>
              Each day holds a <code>passages</code> array. An empty array is a
              Review &amp; Reflect day.
            </p>

            <pre>
              <code>{basicExample}</code>
            </pre>

            <h2>Passages</h2>

            <p>
              Passages use OSIS references: <code>Rom.1</code> for a chapter,{' '}
              <code>Rom.1.16</code> for a verse, or{' '}
              <code>Rom.1.16-Rom.1.17</code> for a range. Ranges repeat the book
              identifier on both sides.
            </p>

            <p>
              Book identifiers are the usual OSIS abbreviations, such as{' '}
              <code>Gen</code>, <code>Ps</code>, <code>Matt</code>,{' '}
              <code>Rom</code>, and <code>Rev</code>. A day can list several
              passages, and a plan needs at least one reading. References must
              exist, and a day cannot repeat the same passage.
            </p>

            <h2>Example</h2>

            <pre>
              <code>{fullExample}</code>
            </pre>

            <p>
              This plan sets a color, pairs two passages on day 1, uses a
              chapter range on day 2, and makes day 3 a reflection day.
            </p>

            <p>
              In Lux, open Bible Plans and choose Create Custom Plan to import a{' '}
              <code>.lxbp</code> file, paste its contents, or have your own AI
              generate one.
            </p>
          </Prose>
        </div>
      </div>
    </Page>
  );
}
