# Lux videos

Root-level Remotion project for Lux video work.

## SOAP Bible Study

`SoapBibleStudy` is a 9:16 animated adaptation of the ten-card SOAP Bible Study carousel.

Open Studio with `npm run dev`, select `SoapBibleStudy`, then choose **View > Right Sidebar > Expanded**. The controls appear under **Inspector > Default Props**. The panel controls palette, animation speed, typography scale, product media scale, shader motion, and transition blur. Studio can save those changes back to `src/Root.tsx`.

Simulator recordings live in `public/videos/soap/recordings/`. Observe, Summarize, and Application use their corresponding annotation recordings, with playback starting as the phone animates in. Dig Deeper shows Compare, Key Words, Cross-references, and Commentaries. The first marker and first recording entrance start together. Subsequent recordings begin crossfading when their marker first reaches 50% of its width, with overlapping playback. Every recording plays at normal speed in full. The outgoing scene transition starts immediately after the last recording finishes, with its final frame retained only during the transition. Scene lengths and background transitions follow those timings, including changes to animation speed. The current default composition lasts 1:32.20. Scripture retains its screenshot.

Generic composition, timing, motion, media, and text components live in `src/core/`. Reusable Lux typography, backgrounds, layouts, and product-media treatments live in `src/design/lux/`. Video-specific definitions, scenes, copy, and asset manifests live in `src/videos/<video-id>/`. The SOAP scene registry and timing rules are in `src/videos/soap/video.ts`.

Recording sources are declared in `src/videos/soap/media.ts`. Mediabunny measures their durations automatically in `calculateMetadata`, so replacing a recording updates its scene and composition duration without a corresponding code change.

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
