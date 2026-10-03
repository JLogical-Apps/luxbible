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

1. Write `lib/videos/my_video.dart` pointing at the recording, with `clips: []`. Keep the video in a top-level
   function: hot reload never updates an inline closure, so `runVideo(args, () => Video(...))` would keep showing the
   video as it was at launch.

   ```dart
   void main(List<String> args) => runVideo(args, video);

   Video video() => Video(sources: ['~/Downloads/my_video.MOV'], clips: []);
   ```

   A recording split across several files lists them all, in order. They play back to back as one recording, so
   frame numbers run straight through the joins:

   ```dart
   Video video() => Video(sources: ['~/Downloads/part_1.MOV', '~/Downloads/part_2.MOV'], name: 'my_video', clips: []);
   ```
2. `dart run lib/videos/my_video.dart ingest` — normalizes the source and detects clips.
3. `flutter run -d macos -t lib/videos/my_video.dart` — play clips, trim and rename them. The
   checkboxes mirror the video file's `clips:` list; ticking or unticking one marks the file as out of
   date and offers the updated list to copy. It keeps the file's order and slots new clips in by
   their place in the recording. The focused clip has a caption field for fixing transcription
   mistakes, which saves to `clips.json` as you type.
4. Paste the clips into the Dart file. Hot reload re-reads it, resets the checkboxes to match, and
   rebuilds the preview, as does any other edit to the file, such as a modifier.

In the player, space plays and pauses, ← and → seek 2 s, and `,` and `.` step back and forward one frame.
5. `dart run lib/videos/my_video.dart render`, or the Render button. On macOS, the finished video opens in Finder.

## Framing

Each clip gets a `framing` that decides its zoom and where the head lands, plus a small random zoom seeded by its name.
The head is assumed to be centered in the recording. A clip with a title or media is framed for it automatically:

```dart
Video(
  sources: ['~/Downloads/my_video.MOV'],
  clips: [
    Clip('hook', modifiers: [Title('How I take Bible notes')]), // .title: slight zoom, head centered
    Clip('demo', modifiers: [Media('demo.mp4')]), // .media: more zoom, head below center
    Clip('outro'), // .none: medium zoom, head centered
  ],
)
```

`.at(x, y)` centers the window on a spot in the recording instead, as fractions of its size, with the same zoom as
`.none`. The window stops at the recording's edges, and `.at(0.5, 0.5)` frames like `.none`.

`.media` puts the middle of the face at 75% of the height, below the media. It assumes the face is halfway down the
recording; if it sits higher, give its height as a fraction, and `.media` zooms in further to bring it down to the same
place:

```dart
Video(sources: ['~/Downloads/my_video.MOV'], headY: 0.42, clips: [...])
```

## Titles

A `Title` shows a card of text over its clip, for the whole clip by default. Text wraps on its own, and `\n` forces a
break. `y` moves the card's center, as a fraction of the height (0.25 by default). Titles sharing an `x` and `y` share
one card, one after another, and the card grows a line at a time as they appear. `opacity` fades a title's text. The
same title on consecutive clips reads as one card held across the cut.

A card spans the frame unless it has an `x`. With one, it becomes a label that fits its text, centered at that fraction
of the width, so several can sit side by side:

```dart
Clip('old_enough', modifiers: [
  Title('KJV', x: 0.3, start: .word('KJV')),
  Title('ASV', x: 0.7, start: .word('ASV')),
]),
```

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

## Media

`Video(media: '~/Downloads/my_video')` links a folder of screen recordings and images. A `Media` modifier shows one of
them above the head, fit inside 1% to 56% of the height and the frame's width, and cuts in and out like a title. Captions drop to 82% of the
height on those clips, below the chin. On its own, it plays the file once
over its clips, from its `start` tag to its `end` tag:

```dart
Clip('compare_translations', modifiers: [Media('compare_translations.mp4')]),
Clip('summary_style', modifiers: [Media('write_summary.mp4')]),
Clip('summary_own_words', modifiers: [Media('write_summary.mp4')]), // continues the same playback
```

The Media tab lists the folder's files. Scrub one and tag frames on its timeline, like `study_start` or `study_end`.
Tags save to `lib/videos/<name>.media.json`, the way clips save to `clips.json`, so the Dart file only ever names them.
Every file has two implicit tags: `start`, 10 frames in, and `end`, 10 frames before the last, which skips the janky
frames RocketSim records at each edge. Both can be moved in the tab.

`Play` takes the playhead to a tag, starting at a moment in its clip:

```dart
const sim = 'simulator.mp4';

Clip('lux_study', modifiers: [
  Media(sim, play: [Play('study_start', at: .word('in'))]), // holds on `start` until "in"
]),
Clip('compare_translations', modifiers: [
  Media(sim, play: [Play('study_end', at: .word('study'))]),
]),
Clip('tap_annotate', modifiers: [
  Media(sim, play: [Play('annotate_end', from: 'annotate_start', at: .word('annotate'))]), // jumps first
]),
```

- **The recording sets the pace, never slower than 1x.** A `Play` gets until the next `Play` of that file or the end of
  its run, even across a cut. If the footage fits, it plays at 1x and holds on its tag. If not, it speeds up just
  enough to reach the tag at the end of that stretch. `by:` ends the stretch sooner, and `speed:` fixes the speed.
- **Consecutive clips showing the same file are one run.** Its playhead carries across their cuts. A run with no `Play`
  plays from wherever the playhead is to `end`, fit to the run.
- **Before its first `Play`, the media holds on that play's `from`**, or wherever the playhead is.
- **The playhead also carries across clips that hide the file**, so showing it again later continues where it stopped.
- **Mistakes are loud.** An unknown file or tag, or a `Play` that would run backwards, throws and lists what exists.

`dart run lib/videos/<name>.dart media` lists each file's tags and how the video plays them, including every speed.

An image (`.png`, `.jpg` or `.jpeg`) works the same way, minus the playing: it shows for its stretch of the clip, and
takes no `play:`. `start:` and `end:` swap one image for another partway through:

```dart
Clip('shortcuts', modifiers: [Media('shortcut.png')]),
Clip('phone_features', modifiers: [
  Media('downtime.png', end: .word('app')),
  Media('app_limits.png', start: .word('app')),
]),
```

Images aren't ingested and don't appear in the Media tab. They're read as they are, so editing one in place without
renaming it keeps the old preview.

`mask:` cuts a shape around the media. `.bevel()` rounds its corners and frames it in a black device bezel, for
screenshots that lack the device frame RocketSim records. `radius` and `border` are fractions of the media's width,
0.14 and 0.035 by default, and the media shrinks to fit the bezel in the same space:

```dart
Clip('shortcuts', modifiers: [Media('shortcut.png', mask: .bevel())]),
```

## Zoom

`Zoom` eases the clip's crop into another framing partway through, over 12 frames unless `frames:` says otherwise.
Captions move to the new framing's height as it starts. Give the clip its starting framing, since a `Scatter` or `Media`
would otherwise frame it for media from the start:

```dart
Clip('hook', framing: .title, modifiers: [
  Title('Someone owns the NIV', end: .word('is')),
  Zoom(.media, at: .word('is')),
]),
```

`zoom:` sets the magnification exactly (the framings sit between 1.1 and 1.4), with no random jitter. Together with
`.at`, it zooms into a spot:

```dart
Clip('hook', framing: .title, modifiers: [Zoom(.at(0.4, 0.35), zoom: 1.8, at: .word('is'))]),
```

`ZoomOut` is an entrance: the clip starts `from` (1.15) times further in than its framing, holds until `at`, then eases
out to it over 30 `frames`:

```dart
Clip('hook', framing: .title, modifiers: [ZoomOut(at: .frames(15))]), // holds for half a second
```

Both take an `easing:`, `.quarticInOut` for a `Zoom` and `.cubicInOut` for a `ZoomOut` by default.

## Scatter

`Scatter` shows images from the media folder whose names match a pattern, where `*` matches anything. They appear one
at a time in natural order (`comment_2` before `comment_10`), the first at `start` and the last at `by`. The rate
they come at eases up over the first second, then holds until the last one lands. They pile up above the head until
`end`, each turned up to 6°. Each one tries 64 random spots and takes the one that covers the most empty space, so the
pile fills evenly, and may hang a fifth of its width off either side. Spots and turns are seeded by the file's name, so
they're stable across renders; rename files to reorder or reroll them. Images are drawn at 0.9x, shrunk to fit 65% of the width.

```dart
Clip('hook', modifiers: [Scatter('comment_*.jpg', start: .word('is'), by: .word("it's not as"))]),
```

Like `Media`, a clip with a `Scatter` is framed for media unless `framing:` says otherwise.

`sound:` plays a sound effect from the media folder as each image appears. It starts from its first sound, so leading
silence in the file doesn't make it late. `volume` is in dB, -10 by default.

```dart
Scatter('comment_*.jpg', start: .word('is'), sound: Sound('pop.mp3')),
```

## Music

`Music` plays a track from the media folder under the whole video, lined up so its `cue` lands `at` a moment in the clip
it's on (the clip's start by default). If the cue is further into the track than that moment is into the video, the
track starts partway through; otherwise it waits. It fades out over the video's last second. `volume` is in dB, -20 by
default. A video has at most one.

```dart
Clip('two_sources', modifiers: [Music('kulakovka.mp3', cue: Duration(seconds: 30))]), // 0:30 lands on this cut
```

## Commands

```sh
dart run lib/videos/<name>.dart ingest   # normalize + detect clips
dart run lib/videos/<name>.dart clips    # list detected clips
dart run lib/videos/<name>.dart captions # list caption words and their start times
dart run lib/videos/<name>.dart media    # list media tags and how the video plays them
dart run lib/videos/<name>.dart render   # render to out/<name>.mp4 and reveal it in Finder
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
| `source.json` | size of each source at ingest, to catch a swapped or added recording |
| `master.mp4` | normalized sources joined into one, whose video is what render reads |
| `proxy.mp4` | 960px preview copy |
| `audio.wav` | mono 16k from the master, used for silence detection |
| `voice_*.wav` | processed 48k mono voice, the audio every view plays; keyed by the processing chain |
| `media/<file>_*.mov` | each media file as ProRes 4444 with alpha, at 30fps and 1280px tall; keyed by its size and date |
| `media/<file>_*.mp4` | the same frames as H.264, 960px tall, for the Media tab's player |
| `media/<file>_*.frames` | the media file's frame count |
| `subtitles_*.ass` | burned-in captions and titles, keyed by their content |
| `preview_*.mp4` | stitched previews, keyed by the ffmpeg command that builds them |

Clips are detected with `silencedetect` at −40 dB over 1.0 s, padded by 0.1 s for breathing room.
Each detected span becomes its own clip with a single take; grouping repeated attempts into one clip
is still to come.

Each take is then transcribed with `whisper-cli` (with DTW word timestamps), one invocation per take, and the sentence is
written into `clips.json`. Requires `brew install whisper-cpp` and a model at
`~/.cache/whisper/ggml-base.en.bin`. Raw word-level output and each take's sound onsets are cached under
`.cache/<name>/transcripts/`.

Once ingested, the source recordings can be deleted: render and preview only read the cache. If a
source is replaced with a different file under the same name, or the list of sources changes, ingest refuses to run, since `clips.json`
frame numbers would point into the wrong footage.

Spans that transcribe to nothing were breath or movement rather than speech; they are dropped and
the remaining clips renumbered, but only on first detection. Regenerating `clips.json` therefore
renumbers auto-generated names — harmless once clips are named meaningfully, and loud if not.

## Scope

Minimal on purpose: clips, trimming, captions, titles, media, voice processing, framing, preview, render. Captions are
always on, in one fixed style, and come from each clip's `text` in `clips.json`. Titles, media, zooms and
scatters are the only visual modifiers so far, each in one fixed style. Media shows videos and still images, and `Scatter` piles up
images. The voice gets one fixed processing chain, and music and sound effects a fixed gain each. See
[`CONTEXT.md`](CONTEXT.md) for how captions, titles and media are drawn and what that means for the rest.
