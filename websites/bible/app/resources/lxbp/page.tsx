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
    images: '/opengraph-image',
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

const studyExample = `{
  "name": "Hope in Ruth",
  "days": [
    {
      "title": "Naomi comes home empty",
      "passages": ["Ruth.1"],
      "studyNotes": "Naomi leaves Moab with nothing but Ruth, and she can't yet see that Ruth is the gift.\\n\\n### Go Deeper\\n\\n> Where you go I will go.\\n\\nCompare Ruth's promise in [Ruth 1:16-17](Ruth.1.16-Ruth.1.17) with what [Matthew Henry](commentary:matthewHenry/Ruth.1.16-Ruth.1.17) says about it.",
      "reflectionQuestion": "Where might God be providing for you in a way you haven't noticed yet?"
    },
    { "title": "Gleaning in Boaz's field", "passages": ["Ruth.2"] }
  ]
}`;

const progressExample = `{
  "name": "Ruth in 4 Days",
  "targetDate": "2026-12-25",
  "days": [
    { "passages": ["Ruth.1"], "completed": true },
    {
      "passages": ["Ruth.2.1-Ruth.2.12", "Ruth.2.13-Ruth.2.23"],
      "completedPassages": ["Ruth.2.1-Ruth.2.12"]
    },
    { "passages": ["Ruth.3"] },
    { "passages": ["Ruth.4"] }
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
            read and, if you like, a title, study notes, and a reflection
            question. Export any plan from Lux to a <code>.lxbp</code> file to
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

            <p>A file has these top-level fields:</p>

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
              <li>
                <code>targetDate</code> (optional): a suggested end date for
                the plan, covered in{' '}
                <a href="#progress">Progress and target dates</a>.
              </li>
            </ul>

            <p>
              Each day is an object with a <code>passages</code> array. An
              empty array marks a Review &amp; Reflect day, a built-in pause
              with no new reading. A day can also have a title, study notes,
              and a reflection question, covered in{' '}
              <a href="#study-notes">Study notes and reflection questions</a>.
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

            <h2 id="study-notes">Study notes and reflection questions</h2>

            <p>
              Any reading day can carry its own study material. All three
              fields are optional, so a plan can use one, some, or none of
              them, day by day.
            </p>

            <ul>
              <li>
                <code>title</code> (optional, on a day): a short heading shown
                above the day&apos;s readings and at the top of its study
                notes.
              </li>
              <li>
                <code>studyNotes</code> (optional, on a day): notes written in
                Markdown. Lux shows them in a Study Notes tab after the
                day&apos;s passages, with its own checkbox.
              </li>
              <li>
                <code>reflectionQuestion</code> (optional, on a day): one
                question shown in a Reflection Question tab after the study
                notes, with space for a private answer that stays on the
                reader&apos;s device. Readers can skip these or turn them off
                for the whole plan.
              </li>
            </ul>

            <p>
              A day is complete once its passages, study notes, and reflection
              question are all checked off. Review &amp; Reflect days stay a
              single checkbox, so they don&apos;t show study notes or a
              reflection question.
            </p>

            <pre>
              <code>{studyExample}</code>
            </pre>

            <h3>Writing study notes</h3>

            <p>
              Study notes are a JSON string, so each line break is written as{' '}
              <code>\n</code>. Lux reads a small part of Markdown:
            </p>

            <ul>
              <li>
                A blank line (<code>\n\n</code>) starts a new paragraph.
                Lines without one between them join into a single paragraph.
              </li>
              <li>
                A line starting with <code>#</code> and a space, such as{' '}
                <code>### Go Deeper</code>, becomes a heading.
              </li>
              <li>
                Lines starting with <code>&gt;</code> become a quote.
              </li>
              <li>
                <code>**bold**</code>, <code>*italic*</code>, and{' '}
                <code>[links](target)</code> work inside any of these.
              </li>
            </ul>

            <p>
              Lists, tables, images, and HTML aren&apos;t supported and show
              up as plain text.
            </p>

            <h3>Links</h3>

            <p>A link&apos;s target decides what tapping it opens:</p>

            <ul>
              <li>
                A passage, written as an OSIS reference like{' '}
                <code>[Romans 5:1-5](Rom.5.1-Rom.5.5)</code>, opens a preview
                of that passage.
              </li>
              <li>
                A commentary, written as{' '}
                <code>commentary:&lt;name&gt;/&lt;passage&gt;</code>, opens
                that commentary on the passage. The names are{' '}
                <code>tyndale</code>, <code>matthewHenry</code>,{' '}
                <code>jamiesonFaussetBrown</code>, and <code>calvin</code>, as
                in <code>commentary:matthewHenry/Ruth.1.16-Ruth.1.17</code>.
              </li>
              <li>
                A Hebrew or Greek word, written as{' '}
                <code>strong:&lt;verse&gt;/&lt;Strong&apos;s number&gt;</code>,
                opens that word in the verse with its form and meaning, as in{' '}
                <code>strong:Gen.3.15/H2233</code>. When the word appears more
                than once in the verse, add which one, as in{' '}
                <code>strong:Gen.3.15/H2233/2</code>. Words are matched in the
                Berean Standard Bible.
              </li>
            </ul>

            <p>
              Tapping any other link does nothing. That includes web
              addresses, so a plan someone shares with you can&apos;t send you
              to an outside site.
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

            <h2 id="progress">Progress and target dates</h2>

            <p>
              When you export a plan you&apos;re following, Lux can include
              how far you&apos;ve read and the end date you&apos;re pacing
              toward. Both are optional, and a plan without them is just a
              plan.
            </p>

            <ul>
              <li>
                <code>completed</code> (optional, on a day):{' '}
                <code>true</code> marks the whole day as read, including a
                Review &amp; Reflect day.
              </li>
              <li>
                <code>completedPassages</code> (optional, on a day): the
                passages read so far on a day that isn&apos;t finished yet.
                Each one must match one of that day&apos;s{' '}
                <code>passages</code> exactly. Lux ignores any that don&apos;t,
                and counts the day as complete once every passage is listed,
                unless the day also has study notes or a reflection question
                still to finish.
              </li>
              <li>
                <code>completedStudyNotes</code> and{' '}
                <code>completedReflectionQuestion</code> (optional, on a day):{' '}
                <code>true</code> marks the day&apos;s study notes or
                reflection question as done on a day that isn&apos;t finished
                yet. Lux ignores them on a day without study notes or a
                reflection question.
              </li>
              <li>
                <code>targetDate</code> (optional, top level): a date written
                as <code>YYYY-MM-DD</code>.
              </li>
            </ul>

            <pre>
              <code>{progressExample}</code>
            </pre>

            <p>
              When a file has progress, Lux asks whether to continue from it
              or start fresh. Continuing starts the plan with those days and
              passages already checked off, and the plan can&apos;t be edited
              first. When a file has a target date, Lux suggests a Paced pace
              ending on that date, and you can still choose Relaxed or a
              different date.
            </p>

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
                <code>targetDate</code> has to be a real calendar date in{' '}
                <code>YYYY-MM-DD</code> form.
              </li>
              <li>
                <code>title</code>, <code>studyNotes</code>, and{' '}
                <code>reflectionQuestion</code> have to be text. Empty text
                counts as leaving the field out.
              </li>
              <li>
                Nothing outside <code>name</code>, <code>days</code>,{' '}
                <code>color</code>, <code>targetDate</code>,{' '}
                <code>title</code>, <code>passages</code>,{' '}
                <code>studyNotes</code>, <code>reflectionQuestion</code>,{' '}
                <code>completed</code>, <code>completedPassages</code>,{' '}
                <code>completedStudyNotes</code>, and{' '}
                <code>completedReflectionQuestion</code> is recognized; extra
                fields are ignored rather than rejected.
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
