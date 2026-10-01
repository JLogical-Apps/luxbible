# Reels — Context

Read this before changing the reels tool. `README.md` covers how to *use* it; this file covers what
it is for and where it currently stands.

## The problem this replaces

Jake records one long take containing many attempts at each line, then cuts a short-form reel from
the keepers. The previous workflow was Remotion + AI: every edit, however small, meant asking an
agent to rewrite React components. The videos are highly templated, so most of that work should be
code, not conversation.

## Vision

A video is a Dart file. The Flutter app is a preview wrapper around a pure-Dart core; hot reload
gives instant feedback on edits Jake makes himself.

```dart
void main(List<String> args) => runVideo(args, video);

Video video() => Video(
  src: '~/Downloads/IMG_7193.MOV',
  clips: [Clip('intro_hook'), Clip('problem_distractions')],
);
```

Non-negotiables that shape the design:

- **Rendering is pure Dart.** `package:reels/reels.dart` must never pull Flutter into its import
  graph. The UI reaches the same `render()` the CLI does. A conditional export on `dart.library.ui`
  (`src/launch/launch.dart`) lets one video file serve both `dart run` and `flutter run`.
- **Video files import only `package:reels/reels.dart`.** No Flutter types in the DSL surface.
- **The builder is a top-level function.** `main()` does not re-run on hot reload, so `runVideo` takes
  `VideoBuilder` and the app calls it during `build`. Passing a `Video` by value freezes it against hot reload, and so
  does an inline closure: the VM keeps running a closure's old code after a reload, where a top-level function's
  tear-off picks up the new body.
- **Derived media is disposable.** Everything in `.cache/` can be deleted and rebuilt, as long as the
  source still exists. Existence is the only freshness check, so every cache write goes through
  `cached()` (`src/paths.dart`), which renames a `*.partial-<pid>.*` file into place on success.

## Vocabulary

- **Take** — one attempt at saying a line, detected as a speech span in the recording.
- **Clip** — a named moment in the video, holding every take of it. **The last take is the keeper**;
  that is what renders. Nothing selects a non-final take, by design.
- `lib/videos/<name>.clips.json` is tool-owned: clip names, takes, boundaries, transcripts. The UI
  writes it.
- `lib/videos/<name>.dart` is human-owned: which clips, in what order, and their modifiers.

This split is deliberate. Re-trimming in the UI never touches code; reordering never touches a frame
number. A renamed clip produces a loud `UnknownClipException` listing valid names, rather than
silently wrong footage.

**There is exactly one timing mechanism.** Every frame number lives in the JSON. `Clip` carries no
trim offsets. Do not reintroduce a second place where timing can live. Modifiers time themselves with `ClipTime`
(`src/model/modifier.dart`), which is always relative to its clip: `.clipStart`, `.clipEnd`, `.frames(n)` from the
clip's start, or `.word('absorb')`, when that word lights up in the captions. Prefer `.word`: it follows the speech
when the clip is retrimmed, where a frame offset drifts.

## Current state

Working and verified end to end on real footage:

- Ingest: rotation, HDR→SDR tone-mapping, CFR normalization, native-resolution master, 960px proxy
- Clip detection via `silencedetect`, one take per clip
- Transcription via `whisper-cli`, one transcript per take
- Preview: proxy opened once, seek per clip; stitched preview for the full video, opened at the
  focused clip
- Render: ffmpeg trim+concat, frame-exact (each clip is seeked half a frame early and cut by frame
  count, since an exact seek loses the first frame to float error), 1080×1920 delivery
- Caption editing: the focused clip's text is editable in the UI, or by hand in `clips.json`
- Captions burned into preview and render, in the style of the Remotion facecam videos
- Voice processing: one processed track per recording, heard in the Clips view, preview and render
- Framing: a slightly random zoom per clip that places the head for a title, media or nothing, which a `Zoom` can
  ease into another framing partway through
- Titles: a card of text over a clip, growing a line at a time as titles sharing it appear, timed to the clip or its
  caption words, cut in and out with no animation
- Media: screen recordings from a linked folder, tagged in the Media tab, played over clips at a speed fit to the words
  they're timed to, cut in and out with no animation
- Scatter: images from the linked folder, appearing one at a time above the head, each where it covers the most empty
  space, piling up
- Music and sound effects: one track under the whole video, synced to a moment in a clip, and a sound as each
  scattered image appears
- CLI: `ingest`, `clips`, `captions`, `media`, `render`

Not built yet: take grouping and images as `Media`.

### Transcription

Requires `whisper-cli` (`brew install whisper-cpp`) and a model at `~/.cache/whisper/`. Takes are
transcribed **individually**, not as one pass over the recording. This matters: run across the whole
audio, whisper smears word timings across the silences between takes — it reported a single word
spanning 2.6 s when that span was mostly silence. A take has no long pause inside it by
construction, so per-take timings come out realistic. Cost is about 0.4 s per take.

Raw whisper output is cached under `.cache/<name>/transcripts/<start>-<end>.dtw.json`, keyed by frame
range, so re-running is instant. Ingest only transcribes takes with no `text`, so a trimmed take keeps
its sentence and gets fresh word timings on demand the first time `getCaptions` sees its new range.

**The sentence in `clips.json` is the caption, and it is hand-editable.** Word-level timings live only
in the whisper cache, so `getCaptions` maps the edited sentence back onto whisper's words
(`Transcript.corrected`): an edit distance alignment where a corrected word takes the timing of the
word it replaced, inserted words share a neighbour's span, and deleted words' time goes to the word
before them. Ingest never overwrites a take that already has text, so edits are safe from re-runs.

Silence detection finds spans of *sound*, so some of them turn out to be breath or movement rather
than speech. Those transcribe to an empty string and are **dropped, and the rest renumbered**, but
only on first detection while every name is still auto-generated. `img_7193` went 39 → 33 this way,
`deleted_the_bible` 55 → 53. `clips.json` is not written until that first transcription finishes, so
a failed first run re-detects rather than leaving silent spans that can no longer be dropped.

Whisper sometimes hallucinates on a noise span instead of returning nothing (`bible_notes` opened with
"Okay. Okay. Thank you."). The empty-string check can't catch those; drop them by hand when grouping.

Because that renumbers, deleting `clips.json` and regenerating can invalidate `Clip('clip_07')`
references in a video file that still uses auto-generated names. The failure is loud — an
`UnknownClipException` listing every valid name — and it stops being possible once clips are named
meaningfully, since real names are stable.

## Captions

Captions are burned in by libass (ffmpeg's `ass` filter), not composited in Flutter. `writeSubtitles`
(`src/render/ass.dart`) turns every clip's corrected transcript, plus its titles, into one ASS file on the output
timeline, and the stitch draws it after scaling, so the preview (540×960) and the render (1080×1920)
come from the same file and the same renderer. Editing a caption or title changes the file's hash, and with it
the file's path in the ffmpeg command, so the preview rebuilds.

Event times aim half a frame before their frame (`getAssTime`). ASS times are centiseconds, and rounding a frame's own
timestamp can land just after it, which showed an event a frame late.

The look copies the Remotion facecam captions in `videos/src/templates/facecam/WordCaptions.tsx`:
uppercase Bitter Black, white with a dark outline, the spoken word inverted, centered at 75% of the
height, pages of at most 4 words and 22 characters that break after `.!?` or a 600 ms pause. There is
deliberately no customization API yet; the constants live at the top of `captions.dart`.

- `fonts/Bitter-Black.ttf` is a static weight-900 instance of `apps/bible/fonts/Bitter-VariableFont_wght.ttf`
  (fonttools `varLib.instancer`). libass can't select a weight from the variable font, whose default
  instance is Thin.
- ASS `Fontsize` is the font's Windows ascent + descent (1.631 em for Bitter), not the CSS em, so the
  Remotion 72 px is 117 here.
- Word onsets start as whisper DTW timestamps (`--dtw`). Plain token offsets were off by up to ~180 ms per word. But
  with `base.en`, DTW itself runs 50-300 ms late and unevenly. It is worst on a take's first word, often landing on its
  second syllable ("Taking" at the "-king"), so a fixed lead can't fix it. `Transcript.snapped` corrects onsets
  against the waveform: a word that follows a pause takes the nearest unclaimed sound onset from up to 300 ms before it
  (`silencedetect` at −40 dB with 40 ms pauses, ignoring sounds under 60 ms as clicks), and the rest keep DTW minus its usual 50 ms lag.
  On `bible_notes` that snapped about a third of the words, including every take's first. Each word then lights up
  `captionLeadMs` before its onset. A 200 ms window missed "transformed" in `hook`, which started 270 ms before its DTW time.
  Onsets are cached beside the transcript as `<start>-<end>.onsets_<settings>.json`, keyed by the detection settings. Word ends come from the next word's onset, since whisper's own end times drift
  late.
- **Captions stay inside their clip.** A word lights up no earlier than its clip's first frame, and a page ends by the
  end of its last word's clip. Without that, every cut showed the old caption over the new shot for a frame, since the
  next clip's first word rarely lights up exactly on the cut, and it read as the cut itself being a frame off.
- The canvas is assumed to be 1080×1920, matching a 9:16 source.

## Titles

`Clip('hook', modifiers: [Title('How I take Bible notes')])` shows a card for the clip's whole duration. `start:` and
`end:` narrow that with a `ClipTime`, and `opacity:` fades the title's text. Titles cut in and out with no animation, so
the same title on consecutive clips reads as one card held across the cut. A clip with a title gets `.title` framing
unless `framing:` overrides it.

Titles sharing an `x` and `y` share one card, one title after another, centered on that `y` as if every title were
showing. Each title keeps its rows from the start, and the card covers only the rows showing, so it grows as titles
appear without any text moving.

Without an `x`, a card spans the frame, inset 82 px from each side. With one, it becomes a label: centered on `x`, as
wide as the card's widest row plus padding, and wrapping only at the widest card that keeps that inset on its nearer
side. The width comes from every row, not just the ones showing, so a growing label never changes width. Nothing stops
labels overlapping, so space them by eye. `goal_definition` in `bible_notes` builds a list this way, revealing each line with
`.word(...)`. Since the card is shared, `opacity` fades only its title's text, never the card.

A `.word` phrase is matched on letters and digits alone, against the first occurrence in the clip's corrected captions;
give more words (`.word('to apply')`) to pick a later one. A phrase that isn't there throws `UnknownPhraseException`
with the clip's captions, and `dart run <video> captions` lists every word with its time.

The look copies the Remotion title card in `videos/src/templates/facecam/FacecamVideo.tsx`: 60 px Bitter Black on an
off-white card inset 82 px from each side, with a 1.1 line height, centered at 25% of the height by default. The
constants live at the top of `src/render/titles.dart`.

- **Dart wraps the text, not libass.** The card is an ASS vector drawing, sized from the line count, so both must agree
  on where lines break. `FontMetrics` (`src/render/font_metrics.dart`) reads advances from the font's `cmap` and `hmtx`
  tables and wraps greedily; `\n` in the text forces a break. Kerning is ignored, which only errs towards wrapping
  early. Each line is its own event, since libass spaces lines by ascent + descent (1.63 em), far looser than 1.1.
- The editor's copied clip list writes each clip's name and explicit framing only, so pasting it drops modifiers.

## Media

`Video(media: ...)` links a folder, and `Media('file.mp4')` shows one of its recordings over a clip. README.md covers
the `Media`/`Play` API; this is how it works.

**Media timing follows the clips' timing split.** The Media tab owns `lib/videos/<name>.media.json`, a map from filename
to named tags. Tags are frame numbers in the normalized file, and only the JSON holds them. The Dart file names tags and
times each `Play` with a `ClipTime`, so re-tagging never touches code, and retrimming a clip keeps a `Play` on its word.
`start` and `end` are implicit, 10 frames in from each edge, since RocketSim recordings open and close on a few janky
frames. They are stored only once moved.

**Resolution is pure** (`getMediaSegments`, `src/render/media.dart`). Each file's appearances are grouped into runs of
consecutive clips, each `Play` gets a window up to the next one, its `by:`, or the end of the run, and the result is a
list of `MediaSegment`s on the output timeline: play `from`→`to` at a speed, or hold one frame. The speed is
`max(1, frames ÷ window)`, so the recording is always shown in full. The playhead position carries across runs, but a
window never stretches across a gap. `dart run <video> media` prints every segment.

- **RocketSim records HEVC with alpha, and ffmpeg 7 drops the alpha layer**, which leaves the area around the device
  black. Media ingest (`src/ffmpeg/media.dart`) has AVFoundation's `avconvert` convert each file to ProRes 4444, which
  keeps the alpha. ffmpeg then fixes it to 30fps, since simulator recordings are variable frame rate and tags need
  stable frame numbers, and scales it to 1280px tall. The intermediate is large (~170 MB per 5 s) and is deleted
  straight away.
- **Normalized files are keyed by the source's size and modification date**, not its name, so re-recording a file
  rebuilds it on the next visit to the Media tab or the next render. Its tags stay, since they're keyed by name, so they
  may need nudging. Its frame count is cached beside it, since probing 13 files took a second on every visit.
- **Each segment is its own ffmpeg input**, seeked half a frame early like the clips, then
  `trim → setpts=/speed → fps → tpad=clone → trim` to get exactly its frame count. It's overlaid on the scaled concat at
  its output time, before the `ass` filter, so captions draw over it. `overlay` drops a stream's last frame at its EOF,
  which flickered the media off for a frame at every segment boundary, so each segment runs one frame long and
  `enable='between(n,...)'` cuts it to its stretch. concat stamps the main stream in microseconds, which can land a
  frame a microsecond before a segment's exact start, so overlay found no media frame yet and blanked it; `setpts=N`
  after concat makes both sides exact frame counts. It's centered from 1% to 56% of the height, larger than the
  Remotion `SimulatorOverlay`. The recordings bring their own rounded device frame, so there's no mask.
- **The tab plays an H.264 copy of the normalized file.** The bundled libmpv can't decode ProRes (see Voice), and would
  spin forever on it. The copy has the same frames and timestamps, so its frame numbers are the ones render uses. Seeks
  aim a quarter frame in, and the position is read back by flooring, so the frame shown and the frame reported agree.

## Scatter

`Scatter` (`src/render/scatter.dart`) resolves to one `ScatterImage` per file on the output timeline, each overlaid
after the media and before the `ass` filter. It's built for a pile of comment screenshots over a hook.

- **Images aren't ingested.** Each is a single-frame ffmpeg input, scaled in the graph and overlaid with `enable`;
  overlay repeats a stream's last frame once it ends, so one frame is enough. The Media tab doesn't list them. Each
  plan probes their sizes with ffprobe, in parallel.
- **Placement is chosen in Dart, greedily** (`getScatterCenters`). In order, each image tries 64 spots seeded by its
  filename and takes the one whose rotated bounds cover the most still-empty cells of a 20 px grid over the band (2% to
  56% of the height). Independent random spots left whole rows empty; on the last frame of the hook this took the band
  from 61% covered to 76%, with no block of a 6×6 split under 18%. 24 spots got the same total but left a corner at 1%.
  What's left is bounded by the images' total area. An image may hang a fifth of its width off either side. Dart passes
  the center and the unrotated width, and the overlay centers whatever size `rotate` produced.
- **Seeds put their salt first** (`x3 comment_1.jpg`): FNV-1a barely mixes a final character, and with the salt last
  every image landed on the diagonal, its `x` nearly equal to its `y`.
- **Scale is per image.** Each is drawn at 0.9x and shrunk to fit 65% of the width, so text size varies between wide
  and narrow screenshots. Keeping images narrower than the frame gives every one sideways room; at 90% the wide ones
  filled it and all stacked in the middle.
- **Rotation** is `rotate` with `c=none` on RGBA, which grows the frame to fit and leaves the corners clear.
- **Appearance times ease.** The first image appears at `start` and the last at `by`. In between, the rate smoothsteps
  up over 1 s (the whole span if it's shorter), then holds until the last image, stopping abruptly. Each image appears on the
  first frame whose share of that curve's area reaches its share of the images (`getRampedFraction`).

## Music and sound effects

`getMusicCue` and `getScatterSounds` (`src/render/audio.dart`) place each sound on the output timeline in seconds, and
`getAudioMix` (`src/render/stitch.dart`) mixes them into the concat's voice. Audio files live in the media folder, which
the Media tab ignores since it lists only videos.

- **Mixed in stereo at 48 kHz.** The mono voice is copied to both sides with `pan`; letting `aformat` upmix it would
  lower it 3 dB. `amix` runs with `normalize=0`, since by default it divides every input by the input count. Then the
  voice's own limiter settings catch any peak the extra audio pushes past it. A video with no music or sounds keeps the
  bare voice track.
- **Music seeks with `-ss` and places with `adelay`**, whichever the cue needs, and `amix=duration=first` ends it with
  the voice. Checked against the source track, the music came out sample-aligned.
- **Sound effects drop leading silence** (`silenceremove` at -50 dB), since a pop file can open on 150 ms of nothing,
  4 frames late. Each is its own input, like each scattered image; all 13 pops on `niv_is_owned` landed within 1 ms of
  their image.
- Audio inputs are keyed by path in the preview cache, like images, so replacing a file in place keeps the old preview.
- `-t` on the output hung ffmpeg 7 with this many inputs once it reached the limit, so test a stretch by rendering the
  whole preview, not by cutting the output short.

## Preview cache

A preview is keyed by a hash of its whole ffmpeg command (`StitchPlan.getArgs`), which `render` runs too, with the
master and the delivery codec. Anything that changes what's drawn, or how, changes the command, so the key can't miss
a setting the way a hand-picked one did: an earlier key listed crops and zoom changes but not `ZoomOut.from`, and kept
serving the old preview. Inputs appear by path, so they need content-keyed names: subtitles and the voice track hash
their content, and media is keyed by size and date. Images in a `Scatter` are named as they are, so editing one in
place without renaming it keeps the old preview.

On the Preview tab, every hot reload (`useReloadCount`) asks for the preview again. The key makes that cheap when
nothing drawn changed, and playback only restarts at the focused clip when the file did change.

## Voice

Ingest runs the master's audio through one fixed chain (`src/ffmpeg/voice.dart`) into
`.cache/<name>/voice_<hash>.wav`, 48 kHz mono: FFT noise reduction, 80 Hz high-pass, −2.5 dB at 250 Hz, +2.5 dB at
4.5 kHz, 3:1 compression, de-essing, then a fixed gain to −16 LUFS and a limiter. Jake picked it by ear over the
Remotion chain in `videos/scripts/narration-audio.mjs`. The filename hashes the chain, so editing it rebuilds the track
and every preview. It takes about 8 s for a 5-minute recording.

- **Processed once, over the whole recording, not per cut.** Every filter only looks at the last ~100 ms, and the
  gain is a constant, so cutting after processing sounds the same as processing after cutting. Loudness is measured
  over every take, rejected ones included; `bible_notes` still landed at −16.1 LUFS on the stitched cut.
- **A fixed gain, not loudnorm's second pass.** Raw iPhone speech peaks ~20 dB above its loudness, so loudnorm's linear
  mode can't reach −16 without clipping and silently falls back to dynamic level-riding. The Remotion script never
  noticed, so its narration was probably dynamic all along.
- **Delay matters.** `afftdn` delays its output by 1200 samples (25 ms at 48 kHz) and `alimiter` by its attack unless
  `latency=true`. The chain trims and pads the first, and was verified sample-aligned with the master. Re-check the
  alignment when adding a filter.
- **The player can't do this live.** mpv could apply the chain as an `af` filter, but the libmpv bundled by
  `media_kit_libs_macos_video` is built with `--disable-all` and only `overlay` and `equalizer`. The Clips view instead
  attaches the processed track to the proxy as an external audio track (`AudioTrack.uri`), and `stitch` reads its audio
  from the same file, so all three views hear identical audio.
- The output is mono. The Remotion composition's √½ `narrationVolume` compensated for how it played mono and doesn't
  apply here.

## Framing

Each clip is cropped to one fixed window (`src/model/framing.dart`), chosen by its `Framing`:

| Framing | Used when | Base zoom | Head lands at |
| --- | --- | --- | --- |
| `title` | a title is shown above | 1.10× | the center |
| `media` | media is shown above | 1.40× | 70% of the height |
| `none` | nothing else is shown | 1.20× | the center |

- **The head is assumed to be at the center of the source.** Crops are always centered horizontally, and only move
  vertically to place the head. Aiming at the measured head position was tried and dropped: at low zooms the crop hit
  the source's edge and landed the head off center, which looked worse than a centered zoom. Record centered.
- **The crop is clamped vertically to the source**, so the head only reaches its target height when the zoom allows it.
  `media` needs 1.40× to move a centered head to 70%, which its base zoom is. Lifting the head above center was
  tried for `none` and was too tight a zoom.
- **Each clip adds 0–10% zoom**, from an FNV hash of its name: stable across runs and reordering, rerolled by a
  rename. A clip within 4% of the previous clip's zoom, when both put the head in the same place, is pushed just far
  enough away, since near-identical zooms on either side of a cut read as a glitch. `title` and `none` count as the
  same place.
- **Framing derives from modifiers.** `Media` or `Scatter` gives `.media`, over a `Title`'s `.title`, and an explicit
  `framing:` always wins. It is the framing a clip starts in.
- **It is a plain ffmpeg `crop` per clip**, scaled to the output size before the concat, since every concat input must
  match. The crop is in fractions, so the proxy preview and the master render frame identically; the preview is a
  little soft from upscaling the proxy.
- **A `ZoomOut` is an entrance.** The clip starts at its own crop zoomed `from` times further, and a change at `at`
  eases out to its crop.
- **A `Zoom` eases into another framing.** Its target crop gets the same name-seeded jitter as the clip's own, and the
  next clip's neighbour check compares against where the clip ends.
- **A clip with zooms goes through `perspective`** (`src/render/zoom.dart`), with `eval=frame` and its four corners set
  to the crop window's, so it samples between pixels. `crop` fixes its size when the graph is built, and `zoompan`
  snaps the window to whole source pixels: on the 540 px proxy a slowing zoom stepped 1, 1, 0, 1, 0 px a frame, which
  read as the video stuttering against the zoom. A tracked edge moved 4.1, 1.6, 4.1, 1.5 px a frame under zoompan and
  0.2, 0.3, 0.4, 0.5... under perspective. It costs ~24 ms a frame on the 4K master, only on zooming clips.
- **Each crop value is one expression over the clip's frame**: the start value plus each change's difference, eased
  over its frames. perspective's `in` counts from 1. Wrap each eased term in parentheses: an unparenthesized
  `1-pow(...)` multiplied out as `delta*1 - pow(...)` and once ran the entrance backwards.
- **Captions follow the framing.** They sit at 75% of the height, or 82% on `media` framing, whose head at 70% would put
  them over the chin. The height is chosen per caption event, by the framing at its start, so a page spanning a cut or
  the start of a zoom moves with the framing.

## The constraint that governs what comes next

Animated zoom, masked or moving media, and moving titles are where ffmpeg filters get awkward. (Static media overlays
work fine as a filter graph.) Either they are expressed as ffmpeg filter graphs too, or frames move to Flutter: decoding via ffmpeg into
`ui.Image`, compositing offscreen, reading back with `toImage()`/`toByteData()`, and piping raw frames
to an encoder. That readback path is unproven and historically the rough edge for offscreen rendering
on Impeller/macOS, and it would take render out of `dart run`. **Spike it before designing those
modifier APIs**: measure ms/frame at 1080×1920 over ~100 frames and confirm colors survive the round
trip. Preview and render must share one renderer, or they will drift.

## Source footage gotchas

iPhone recordings are 4K HEVC 10-bit, Dolby Vision 8.4 / HLG, variable frame rate, with a −90°
display-matrix rotation. Consequences, all handled in `src/ffmpeg/ingest.dart`:

- Frame numbers are meaningless until VFR is normalized to CFR.
- Naive SDR conversion shifts color noticeably; `zscale`+`tonemap` is worth its cost.
- Rotation means the decoded frame is portrait (2160×3840) even though ffprobe reports 3840×2160.

Ingest costs ~9 minutes and ~1.2 GB per 5-minute recording. It is cached and one-time.

## Conventions

Matches the repo: `flutter_hooks` for state, `page_width: 120`, `always_use_package_imports`.
macOS app sandbox is disabled in both entitlements files — a sandboxed app cannot exec `ffmpeg` at
all, so this is required, not a shortcut.
