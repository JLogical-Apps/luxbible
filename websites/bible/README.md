# Lux Bible — luxbible.app

Marketing site for the Lux Bible app. Built with **Next.js**,
**TypeScript**, and **Tailwind CSS**. No CMS — every page is composed from typed
block components in code and deployed on Vercel.

## Develop

```bash
npm install
npm run dev
```

## Build

```bash
npm run build
```

## Campaign attribution

Compact social links are mapped to Google Analytics campaign fields and
store attribution:

- `?s=fp`: Facebook profile
- `?s=ip`: Instagram profile
- `?s=id`: Instagram direct message
- `?s=ia`: Instagram boosted post
- `?s=tp`: TikTok profile
- `?s=ta`: TikTok boosted post
- `?s=yp`: YouTube profile

Boosted posts use `paid_social` as the medium and `boosted_post` as the campaign.
Direct messages use `direct_message` as the campaign.

## Structure

- `app/` — routes (`page.tsx` = home, `privacy-policy/`, `resources/lxbp/`, `resources/lxn/`, `plans/advent/`).
  Pages are composed by assembling blocks.
- `components/blocks/` — content blocks (Hero pieces, FeatureShowcase, CtaButton,
  AppStoreButtons).
- `components/layout/` — `Page`, `Section`, `SiteHeader`, `SiteFooter`.
- `components/backgrounds/` — dots / grid section backgrounds.
- `components/ui/` — primitives (`Button`, `Carousel`).
- `lib/site.ts` — central config (URLs, social, store links).
- `data/advent.json` — the Advent plan's day titles, for the day shown on `/plans/advent`, taken
  from `content/sources/lux_plans/advent.md`. Refresh it when a day's title changes.
- `public/media/advent/` — the Advent page's phone recordings, made with the app's
  [recording tool](../../apps/bible/tool/screenshots/README.md#demo-recordings-for-reels) and
  encoded to 540px-wide WebM (plus MP4 for the hero loop). `PhoneFrame` lays the bezel over them.
- `public/media/iphone-frame.webp` — Xcode's iPhone 15 Pro Simulator bezel for `PhoneFrame`,
  rendered with `swift scripts/render-iphone-frame.swift public/media/iphone-frame.webp` (needs
  Xcode and `cwebp`). If the screen rect it prints changes, update `PhoneFrame` to match.
- `public/media/` — screenshots, feature demo videos, logos.

## Deploy

Deployed on Vercel as a Next.js site.

The `app.luxbible.app` domain serves `/passage/<OSIS selection>` and `/plans/<plan ID>` from
this project as browser fallbacks for app links. The same routes on the main domain are regular
pages: `/plans/advent` is the public Advent page, and only the app domain sends Android visitors on
to Lux or Google Play. Assign the subdomain to this Vercel project
and serve the association files in `public/.well-known/` from it. Verify both
files are reachable over HTTPS without redirects before treating app links as live.
