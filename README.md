# Lux Bible — luxbible.app

Marketing site for the Lux Bible app. Built with **Next.js (static export)**,
**TypeScript**, and **Tailwind CSS**. No CMS — every page is composed from typed
block components in code and deployed as static files.

## Develop

```bash
npm install
npm run dev
```

## Build (static export)

```bash
npm run build   # outputs a static site to ./out
```

## Structure

- `app/` — routes (`page.tsx` = home, `privacy-policy/`). Pages are composed by
  assembling blocks.
- `components/blocks/` — content blocks (Hero pieces, FeatureShowcase, CtaButton,
  AppStoreButtons).
- `components/layout/` — `Page`, `Section`, `SiteHeader`, `SiteFooter`.
- `components/backgrounds/` — dots / grid section backgrounds.
- `components/ui/` — primitives (`Button`, `Carousel`).
- `lib/site.ts` — central config (URLs, social, store links).
- `public/media/` — screenshots, feature demo videos, logos.

## Deploy

Static `out/` folder — host anywhere. Configured for Cloudflare Pages
(framework preset: **Next.js (Static HTML Export)**, build `npm run build`,
output directory `out`).
