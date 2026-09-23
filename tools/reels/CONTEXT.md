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
void main(List<String> args) => runVideo(args, () => const Video(
  src: '~/Downloads/IMG_7193.MOV',
  clips: [Clip('intro_hook'), Clip('problem_distractions')],
));
```

Non-negotiables that shape the design:

- **Rendering is pure Dart.** `package:reels/reels.dart` must never pull Flutter into its import
  graph. The UI reaches the same `render()` the CLI does. A conditional export on `dart.library.ui`
  (`src/launch/launch.dart`) lets one video file serve both `dart run` and `flutter run`.
- **Video files import only `package:reels/reels.dart`.** No Flutter types in the DSL surface.
- **The builder is a closure.** `main()` does not re-run on hot reload, so `runVideo` takes
  `VideoBuilder` and the app calls it during `build`. Passing a `Video` by value freezes the clip
  list against hot reload.
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
- Framing: a static, slightly random zoom per clip that places the head for a title, media or nothing
- Titles: a card of text over a clip, growing a line at a time as titles sharing it appear, timed to the clip or its
  caption words, cut in and out with no animation
- CLI: `ingest`, `clips`, `captions`, `render`

Not built yet: take grouping, and every other modifier (media, music, animated zoom).

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
timeline, and `stitch` draws it after scaling, so the preview (540×960) and the render (1080×1920)
come from the same file and the same renderer. Editing a caption or title changes the file's hash, which is
part of the preview key, so the preview rebuilds.

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
  against the waveform: a word that follows a pause takes the nearest unclaimed sound onset (`silencedetect` at
  −40 dB with 40 ms pauses, ignoring sounds under 60 ms as clicks), and the rest keep DTW minus its usual 50 ms lag.
  On `bible_notes` that snapped about a third of the words, including every take's first. Each word then lights up
  `captionLeadMs` before its onset. Word ends come from the next word's onset, since whisper's own end times drift
  late.
- The canvas is assumed to be 1080×1920, matching a 9:16 source.

## Titles

`Clip('hook', modifiers: [Title('How I take Bible notes')])` shows a card for the clip's whole duration. `start:` and
`end:` narrow that with a `ClipTime`, and `opacity:` fades the title's text. Titles cut in and out with no animation, so
the same title on consecutive clips reads as one card held across the cut. A clip with a title gets `.title` framing
unless `framing:` overrides it.

Titles sharing a `y` share one card, one title after another, centered on that `y` as if every title were showing.
Each title keeps its rows from the start, and the card covers only the rows showing, so it grows as titles appear
without any text moving. `goal_definition` in `bible_notes` builds a list this way, revealing each line with
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
- **Framing derives from modifiers.** A `Title` gives `.title`. Media doesn't exist yet, so `framing: .media` is set by
  hand, and an explicit `framing:` always wins.
- **It is a plain ffmpeg `crop` per clip**, scaled to the output size before the concat, since every concat input must
  match. The crop is in fractions, so the proxy preview and the master render frame identically; the preview is a
  little soft from upscaling the proxy. Captions don't move with the framing yet, so `media` puts them over the chin.

## The constraint that governs what comes next

Animated zoom, media overlays with masks, and moving titles are where ffmpeg filters get awkward. Either
they are expressed as ffmpeg filter graphs too, or frames move to Flutter: decoding via ffmpeg into
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
