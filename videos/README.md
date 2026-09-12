# Lux videos

Root-level Remotion project for Lux video work.

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
