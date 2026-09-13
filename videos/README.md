# Lux videos

Root-level Remotion project for Lux video work.

## Facecam videos

`Facecam` is a reusable 1080 × 1920, 30 fps composition with a three-second white Bitter title card, short Bitter caption pages with configurable 7 px outlines at 75% of the canvas height, and muted simulator overlays between 2% and 50% from the top. Each spoken word switches to dark text with a white outline. Isolated overlays fade upward into place and downward away; adjoining overlays crossfade without motion.

Copy `scripts/facecam.example.json` to `src/videos/facecam/jobs/<slug>.manifest.json`, fill in the sources and timing, then run from `videos/`:

```console
node scripts/create-facecam.mjs src/videos/facecam/jobs/<slug>.manifest.json
npx remotion studio --props=src/videos/facecam/jobs/<slug>.json
npx remotion render Facecam out/<slug>.mp4 --props=src/videos/facecam/jobs/<slug>.json
```

Preparation requires FFmpeg, FFprobe, Tesseract, `whisper-cli`, and a local Whisper model. It defaults to `~/.cache/whisper/ggml-base.en.bin`; set `whisperModel` to use another model. Speech stays in place while a 30 fps SDR copy is prepared, including HDR tone mapping. A separate 48 kHz mono 24-bit narration master receives a 75 Hz high-pass filter, gentle 2.2:1 compression, and measured two-pass normalization to -16 LUFS, -1.5 dBTP, and 7 LU loudness range. The composition mutes source audio and plays that master with mono-to-stereo loudness compensation; validate the rendered audio and adjust `narrationVolume` if needed. Captions use Whisper DTW word timing with the same 130 ms lead as the reels project. Review the generated job captions, particularly names and verse references. `transcriptPath` reuses an existing Whisper full JSON transcript; `captionReplacements` corrects exact word spellings before grouping.

All overlay times are seconds in the facecam timeline. A segment's `at` is the playback cue, `sourceTime` is its recording cursor, and optional `playUntil` is the source cursor to stop at, or `"end"`. A segment without `playUntil` holds its source frame. Playback and holds use one continuous frame cursor through the same video renderer, avoiding brightness changes between video and PNG decoders. Prepared stills remain available for OCR. Optional `playbackRate` lets short UI actions fit between spoken cues. PNG, JPEG, and WebP sources are supported; use one hold segment with `sourceTime: 0` for screenshots.

Each highlight supplies exact visible `text`, a `sourceTime` identifying the frame to OCR, and a facecam `start`. Optional `end` removes a marker, `fadeAt` and `fadeSeconds` fade it away before playback resumes, `duration` controls drawing time, `lineDelay` spaces multiline drawing, and `color` sets its color. The shared OCR matcher requires a contiguous phrase and creates one rectangle per text line; it fails rather than guessing coordinates. For repeated text, `region: { "top": 0.5, "bottom": 0.6 }` restricts matching to that normalized vertical range. For dotted underlines, `ocr: { "psm": 11, "minConfidence": 60 }` can exclude false OCR detections while locating the exact text. Markers draw from left to right and persist. Set `focus: { "bottom": 0.61, "fadeAt": 15.5, "fadeSeconds": 0.65 }` on an overlay to darken only the phone above the focus boundary, then ease that gradient away at a spoken cue.

If a stitched HEVC source jitters at take boundaries, set `facecamTakes` to the ordered absolute paths of its original takes. Preparation decodes and normalizes each independently, fits each to the cumulative 30 fps timeline, joins the resulting H.264 video, and preserves the stitched source audio. This avoids reference-frame collisions between independently encoded HEVC takes.

Simulator overlays default to 2% through 50% of the frame height for all facecam videos. Set `style: { "facecamZoom": 1.2 }` to enlarge the facecam by 20%, anchored at the center top; the default is `1`, and the source media stays unchanged. Zoom and crop shifts follow the simulator fades and return to the original full frame when it is hidden. Set `facecamZoomOnlyWithSimulator: false` to keep the crop throughout. Optional `facecamFraming` cues in `style` contain `at`, `zoom`, and normalized source `centerX` to change the crop at camera cuts; optional `offsetY` shifts the crop vertically as a fraction of frame height.

Optional manifest `style` overrides caption size, outline width, character budget, placement, overlay bounds, title duration, and fade duration. For intentional revisions, add `--force`; add `--reuse-media` to reuse prepared sources while refreshing timing, OCR, captions, and props. Reuse media only when sources have not changed.

Components, scripts, and the manifest example are tracked. Per-video manifests and jobs under `src/videos/`, media and freeze frames under `public/videos/`, and renders under `out/` follow existing Git ignore rules. Keep these local files for revisions. Set manifest `music: true` to add a chill track about 20 dB below narration, with smooth loop joins and opening/closing fades. The selected `musicSource` is retained for revisions. Background music remains optional for the facecam format.

## SOAP Bible Study

`SoapBibleStudy` is a 9:16 animated adaptation of the ten-card SOAP Bible Study carousel.

Open Studio with `npm run dev`, select `SoapBibleStudy`, then choose **View > Right Sidebar > Expanded**. The controls appear under **Inspector > Default Props**. The panel controls palette, animation speed, typography scale, product media scale, shader motion, and transition blur. Studio can save those changes back to `src/Root.tsx`.

Simulator recordings live in `public/videos/soap/recordings/`. Observe, Summarize, and Application use their corresponding annotation recordings, with playback starting as the phone animates in. Dig Deeper shows Compare, Key Words, Cross-references, and Commentaries. The first marker and first recording entrance start together. Subsequent recordings begin crossfading when their marker first reaches 50% of its width, with overlapping playback. Every recording plays at normal speed in full. The outgoing scene transition starts immediately after the last recording finishes, with its final frame retained only during the transition. Scene lengths and background transitions follow those timings, including changes to animation speed. The current default composition lasts 1:32.20. Scripture retains its screenshot.

Generic composition, timing, motion, media, and text components live in `src/core/`. Reusable Lux typography, backgrounds, layouts, and product-media treatments live in `src/design/lux/`. Video-specific definitions, scenes, copy, and asset manifests live in `src/videos/<video-id>/`. The SOAP scene registry and timing rules are in `src/videos/soap/video.ts`.

Recording sources are declared in `src/videos/soap/media.ts`. Mediabunny measures their durations automatically in `calculateMetadata`, so replacing a recording updates its scene and composition duration without a corresponding code change.

## Question Showcase

`QuestionShowcase` creates compact guided 9:16 videos from a question and one phone screenshot. The question begins centered, docks above the phone, and the screenshot pauses first on the verse before moving into frame and highlighting the requested study text. A custom background image is optional. Without one, the composition uses the dark animated shader palette exposed in its props.

Create a reusable job and copy its assets into the project with:

```console
node scripts/create-question-showcase.mjs \
  --question "What does it mean to cast your burden on God?" \
  --media /absolute/path/to/screenshot.png \
  --verse-highlight "Cast your burden upon the LORD" \
  --study-highlight "To cast our burden upon God, is to rest upon his providence and promise."
```

The command uses OCR to compute one highlight rectangle per matching line. It stops if either exact phrase cannot be located, then prints the generated props file and the exact Remotion render command. Job props live in `src/videos/question-showcase/jobs/`; assets live in `public/videos/question-showcase/`.

Question videos and narrated slideshows use background music from `music/chill` by default, regardless of their background. Use another music style only when specifically requested. The generator chooses the track with the oldest modification time, breaking ties randomly, and keeps the choice on revisions. It copies the source and prepares a normalized, faded WAV covering the full timeline, with crossfades if the track needs to repeat. Music is prepared near -17 LUFS without narration, or at a lower starting level when foreground audio is enabled; listen and adjust `musicVolume` when mixing speech. The job records the original repository-relative `musicSource` alongside the playable public `musicSrc`.

After a final MP4 passes visual and audio checks, run `touch -m` on its original `musicSource` file to record usage. Previews and failed renders do not update usage timestamps.

<p align="center">
  <a href="https://github.com/remotion-dev/logo">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/remotion-dev/logo/raw/main/animated-logo-banner-dark.apng">
      <img alt="Animated Remotion Logo" src="https://github.com/remotion-dev/logo/raw/main/animated-logo-banner-light.gif">
    </picture>
  </a>
</p>

Welcome to your Remotion project!

## Commands

**Install Dependencies**

```console
npm i
```

**Start Preview**

```console
npm run dev
```

**Render video**

```console
npx remotion render
```

**Upgrade Remotion**

```console
npx remotion upgrade
```

## Docs

Get started with Remotion by reading the [fundamentals page](https://www.remotion.dev/docs/the-fundamentals).

## Help

We provide help on our [Discord server](https://discord.gg/6VzzNDwUwV).

## Issues

Found an issue with Remotion? [File an issue here](https://github.com/remotion-dev/remotion/issues/new).

## License

Note that for some entities a company license is needed. [Read the terms here](https://github.com/remotion-dev/remotion/blob/main/LICENSE.md).
