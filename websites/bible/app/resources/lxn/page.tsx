import { Metadata } from 'next';

import Page from '@/components/layout/Page';
import Prose from '@/components/layout/Prose';
import { site } from '@/lib/site';

const description =
  'How to read and write .lxn files: the plain-JSON notebook format Lux Bible uses to share highlights and notes.';

export const metadata: Metadata = {
  title: 'The .lxn Notebook Format',
  description,
  openGraph: {
    title: 'The .lxn Notebook Format',
    description,
    url: `${site.domain}/resources/lxn`,
    type: 'article',
    images: '/opengraph-image',
  },
};

const basicExample = `{
  "name": "Sermon on the Mount",
  "annotations": [
    {
      "passage": "Matt.5.3-Matt.5.10",
      "style": { "type": "highlight", "color": "yellow" }
    },
    {
      "passage": "Matt.6.33",
      "style": { "type": "wavyUnderline", "color": "red" },
      "note": "Seek first. Everything else follows."
    }
  ]
}`;

const fullExample = `{
  "id": "6f1c2b9e-3a4d-4e8f-9b21-5c7d8e9f0a12",
  "name": "Psalms of Trust",
  "color": "blue",
  "highlightStyles": [
    { "type": "highlight", "color": "green", "label": "Promise" },
    { "type": "outline", "color": "violet", "icon": "prayer", "label": "Prayer" }
  ],
  "annotations": [
    {
      "passage": "Ps.23",
      "style": { "type": "highlight", "color": "green" },
      "note": "Read this one slowly."
    },
    {
      "passage": "Ps.46.1 Ps.46.10",
      "style": { "type": "outline", "color": "violet", "icon": "prayer" }
    },
    {
      "text": {
        "start": "Ps.91.1.0",
        "end": "Ps.91.1.28",
        "translation": "bsb"
      },
      "style": { "type": "highlight", "color": "green" }
    }
  ]
}`;

export default function LxnFormatPage() {
  return (
    <Page>
      <div className="container max-w-4xl py-16 lg:py-20 xl:py-24">
        <header className="mx-auto max-w-3xl">
          <p className="font-semibold text-foreground-soft">Resources</p>
          <h1 className="title-lg mt-3">The .lxn Notebook Format</h1>
          <p className="subtitle mt-6">
            <code>.lxn</code> is a Lux notebook written as plain JSON: a name, a
            color, and the highlights, underlines, and notes inside it. Export
            any notebook from Lux to a <code>.lxn</code> file to share it or
            move it to another device, or write one by hand.
          </p>
        </header>

        <div className="mx-auto mt-12 max-w-3xl">
          <Prose>
            <p>
              This page is the full spec. A file exported from Lux includes
              every annotation in the notebook along with its note, so only
              share it with people you&apos;d want to read your notes.
            </p>

            <h2>File structure</h2>

            <p>A file has these top-level fields:</p>

            <ul>
              <li>
                <code>name</code> (required): the notebook&apos;s display name.
              </li>
              <li>
                <code>annotations</code> (required): the notebook&apos;s
                annotations, which can be an empty array.
              </li>
              <li>
                <code>color</code> (optional): <code>red</code>,{' '}
                <code>orange</code>, <code>yellow</code>, <code>green</code>,{' '}
                <code>blue</code>, <code>violet</code>, or <code>stone</code>.
                Lux uses <code>stone</code> when this is left out.
              </li>
              <li>
                <code>id</code> (optional): a string that identifies the
                notebook, covered in <a href="#importing">Importing into Lux</a>
                . Exports of the Default notebook leave it out.
              </li>
              <li>
                <code>highlightStyles</code> (optional): names for the styles
                the annotations use, covered in <a href="#styles">Styles</a>.
              </li>
            </ul>

            <p>
              Each annotation has a <code>style</code>, an optional{' '}
              <code>note</code>, and exactly one of <code>passage</code> or{' '}
              <code>text</code> saying what it marks.
            </p>

            <pre>
              <code>{basicExample}</code>
            </pre>

            <h2>Marking verses</h2>

            <p>
              <code>passage</code> marks whole verses with an OSIS reference,
              the same way <a href="/resources/lxbp">.lxbp plans</a> do:{' '}
              <code>Matt.5</code> for a chapter, <code>Matt.5.3</code> for a
              verse, or <code>Matt.5.3-Matt.5.10</code> for a range. Separate
              several references with spaces, as in{' '}
              <code>Ps.46.1 Ps.46.10</code>, to mark them as one annotation.
              Verse annotations appear in every translation.
            </p>

            <h2>Marking words</h2>

            <p>
              <code>text</code> marks part of a verse in one translation. It has
              three fields:
            </p>

            <ul>
              <li>
                <code>translation</code>: the Lux ID of the translation the
                words come from, such as <code>bsb</code>, <code>kjv</code>, or{' '}
                <code>web</code>.
              </li>
              <li>
                <code>start</code>: where the marked words begin, written as{' '}
                <code>Book.Chapter.Verse.Offset</code>. The offset counts
                characters from the start of that verse&apos;s text, beginning
                at 0.
              </li>
              <li>
                <code>end</code>: where they stop, in the same form. The
                character at the end offset isn&apos;t included, and the end can
                be in a later verse.
              </li>
            </ul>

            <p>
              Word annotations only appear while reading their translation.
              Offsets depend on the exact text Lux shows, so these are easiest
              to create in Lux and export rather than write by hand.
            </p>

            <h2 id="styles">Styles</h2>

            <p>
              Every annotation&apos;s <code>style</code> is an object with:
            </p>

            <ul>
              <li>
                <code>type</code> (required): <code>highlight</code>,{' '}
                <code>outline</code>, <code>straightUnderline</code>,{' '}
                <code>dashedUnderline</code>, <code>doubleUnderline</code>,{' '}
                <code>wavyUnderline</code>, or <code>transparent</code>.
              </li>
              <li>
                <code>color</code> (required): one of the notebook colors above.
              </li>
              <li>
                <code>icon</code> (optional): <code>heart</code>,{' '}
                <code>star</code>, <code>lightbulb</code>, <code>question</code>
                , <code>exclamation</code>, <code>key</code>, <code>flag</code>,{' '}
                <code>quote</code>, <code>command</code>, <code>prayer</code>,{' '}
                <code>crown</code>, <code>church</code>, <code>fire</code>,{' '}
                <code>water</code>, <code>leaf</code>, <code>sun</code>,{' '}
                <code>music</code>, <code>person</code>, <code>place</code>, or{' '}
                <code>time</code>.
              </li>
            </ul>

            <p>
              <code>highlightStyles</code> gives styles a name. Each entry is a
              style object with an added <code>label</code>. When an imported
              annotation uses a labeled style the reader doesn&apos;t have yet,
              Lux adds it to their highlight styles.
            </p>

            <h2>A complete example</h2>

            <p>
              A notebook with its own ID, two named styles, a note, a verse
              annotation marking two separate verses, and a word annotation in
              the Berean Standard Bible:
            </p>

            <pre>
              <code>{fullExample}</code>
            </pre>

            <h2 id="importing">Importing into Lux</h2>

            <p>
              Open a <code>.lxn</code> file with Lux, share it to Lux, or choose
              Import Notebook from the menu on Your Notebooks. Lux shows the
              notebook first, then lets you import it as a new notebook or merge
              it into one you already have. When the file&apos;s <code>id</code>{' '}
              matches one of your notebooks, that notebook is chosen for you.
            </p>

            <ul>
              <li>
                An annotation is skipped when you already have one with the same{' '}
                <code>passage</code> or <code>text</code>, style, and note, in
                any notebook.
              </li>
              <li>Imported annotations are dated to when you import them.</li>
              <li>
                A new notebook keeps the file&apos;s <code>id</code> unless one
                of your notebooks already uses it, so importing a later export
                of the same notebook can find it again.
              </li>
              <li>
                Merging adds annotations and styles only. It doesn&apos;t change
                the existing notebook&apos;s name or color.
              </li>
            </ul>

            <h2>Rules at a glance</h2>

            <ul>
              <li>
                <code>name</code> can&apos;t be empty or only whitespace.
              </li>
              <li>
                Each annotation needs a <code>style</code> and exactly one of{' '}
                <code>passage</code> or <code>text</code>.
              </li>
              <li>Every reference must resolve to real, existing Scripture.</li>
              <li>
                A <code>text</code> annotation&apos;s <code>end</code>{' '}
                can&apos;t come before its <code>start</code>.
              </li>
              <li>
                Types, colors, icons, and translations must be one of the values
                Lux recognizes.
              </li>
              <li>
                Unknown fields are ignored, but a single invalid annotation
                makes Lux reject the whole file.
              </li>
            </ul>
          </Prose>
        </div>
      </div>
    </Page>
  );
}
