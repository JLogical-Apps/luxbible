# Reels

A code-defined short-form video editor and renderer. A video is a Dart file; the Flutter app is a
preview wrapper on top of it.

For the project's vision, design constraints and current state, read [`CONTEXT.md`](CONTEXT.md).

## Vocabulary

- **Take** — one attempt at saying a line, detected as a speech span in the recording.
- **Clip** — a named moment in the video, holding every take of it. The last take is the keeper, and
  it is what renders.

`lib/videos/<name>.clips.json` holds clip names and take boundaries, and the UI writes it.
`lib/videos/<name>.dart` holds which clips play, in what order. Re-trimming in the UI never touches
your code; reordering clips never touches a frame number.

## Workflow

1. Write `lib/videos/my_video.dart` pointing at the recording, with `clips: []`.
2. `dart run lib/videos/my_video.dart ingest` — normalizes the source and detects clips.
3. `flutter run -d macos -t lib/videos/my_video.dart` — play clips, trim and rename them. The
   checkboxes mirror the video file's `clips:` list; ticking or unticking one marks the file as out of
   date and offers the updated list to copy. It keeps the file's order and slots new clips in by
   their place in the recording. The focused clip has a caption field for fixing transcription
   mistakes, which saves to `clips.json` as you type.
4. Paste the clips into the Dart file. Hot reload re-reads it, resets the checkboxes to match, and
   rebuilds the preview.
5. `dart run lib/videos/my_video.dart render`, or the Render button.

## Framing

Each clip gets a `framing` that decides its zoom and where the head lands, plus a small random zoom seeded by its name.
The head is assumed to be centered in the recording. A clip with a title is framed for it automatically:

```dart
Video(
  src: '~/Downloads/my_video.MOV',
  clips: [
    Clip('hook', modifiers: [Title('How I take Bible notes')]), // .title: slight zoom, head centered
    Clip('demo', framing: .media), // more zoom, head below center
    Clip('outro'), // .none: medium zoom, head centered
  ],
)
```

## Titles

A `Title` shows a card of text over its clip, for the whole clip by default. Text wraps on its own, and `\n` forces a
break. `y` moves the card's center, as a fraction of the height (0.25 by default). Titles sharing a `y` share one card,
one after another, and the card grows a line at a time as they appear. `opacity` fades a title's text. The same title
on consecutive clips reads as one card held across the cut.

```dart
Clip('hook', modifiers: [Title('How I take Bible notes')]),
Clip('process_intro', modifiers: [Title('My\nprocess', y: 0.2)]),
Clip('goal_definition', modifiers: [
  Title('Goals:'),
  Title('Absorb Truth', start: .word('absorb')), // appears when "absorb" lights up in the captions
  Title('Apply It', start: .word('apply')),
  Title('Hold Myself Accountable', start: .frames(120), end: .clipEnd), // or a frame offset into the clip
]),
Clip('missing_accountability', modifiers: [
  Title('Goals:', opacity: 0.5),
  Title('Hold Myself Accountable'),
]),
```

Prefer `.word` over `.frames`: it stays on the word when the clip is retrimmed. `dart run lib/videos/<name>.dart captions`
lists each clip's words.

The editor's copied clip list doesn't include modifiers, so re-add titles after pasting it.

## Commands

```sh
dart run lib/videos/<name>.dart ingest   # normalize + detect clips
dart run lib/videos/<name>.dart clips    # list detected clips
dart run lib/videos/<name>.dart captions # list caption words and their start times
dart run lib/videos/<name>.dart render   # render to out/<name>.mp4
```

Rendering is pure Dart — `package:reels/reels.dart` has no Flutter in its import graph. The Flutter
UI is reachable only through a conditional export on `dart.library.ui`, so the same video file works
under both `dart run` and `flutter run`.

## Ingest

The source is normalized once into a **master**: rotation applied, HDR tone-mapped to SDR bt709,
constant 30fps, at native resolution so per-clip zooms stay sharp. iPhone footage is typically 10-bit
HLG / Dolby Vision and variable frame rate — without this pass, frame numbers lie and colors shift.

Derived artifacts live in `.cache/<name>/` (gitignored, safely deletable). Each is written to a `*.partial-<pid>.*`
file and renamed when finished, so an interrupted ingest resumes instead of reusing a truncated file:

| File | Purpose |
| --- | --- |
| `source.json` | size of the source at ingest, to catch a swapped recording |
| `master.mp4` | normalized source, whose video is what render reads |
| `proxy.mp4` | 960px preview copy |
| `audio.wav` | mono 16k, used for silence detection |
| `voice_*.wav` | processed 48k mono voice, the audio every view plays; keyed by the processing chain |
| `subtitles_*.ass` | burned-in captions and titles, keyed by their content |
| `preview_*.mp4` | stitched previews, keyed by clip list, framing, subtitles and voice |

Clips are detected with `silencedetect` at −40 dB over 1.0 s, padded by 0.1 s for breathing room.
Each detected span becomes its own clip with a single take; grouping repeated attempts into one clip
is still to come.

Each take is then transcribed with `whisper-cli` (with DTW word timestamps), one invocation per take, and the sentence is
written into `clips.json`. Requires `brew install whisper-cpp` and a model at
`~/.cache/whisper/ggml-base.en.bin`. Raw word-level output is cached under
`.cache/<name>/transcripts/`.

Once ingested, the source recording can be deleted: render and preview only read the cache. If the
source is replaced with a different file under the same name, ingest refuses to run, since `clips.json`
frame numbers would point into the wrong footage.

Spans that transcribe to nothing were breath or movement rather than speech; they are dropped and
the remaining clips renumbered, but only on first detection. Regenerating `clips.json` therefore
renumbers auto-generated names — harmless once clips are named meaningfully, and loud if not.

## Scope

Minimal on purpose: clips, trimming, captions, titles, voice processing, framing, preview, render. Captions are always
on, in one fixed style, and come from each clip's `text` in `clips.json`. Titles are the only modifier so far, in one
fixed style. The voice gets one fixed processing chain. No overlays, keyframes or music yet; those attach to `Clip` as
modifiers. See [`CONTEXT.md`](CONTEXT.md) for how captions and titles are drawn and what that means for the rest.
