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

## Campaign attribution

Compact social links are mapped to Google Analytics campaign fields and
store attribution:

- `?s=fp`: Facebook profile
- `?s=ip`: Instagram profile
- `?s=ia`: Instagram boosted post
- `?s=tp`: TikTok profile
- `?s=ta`: TikTok boosted post
- `?s=yp`: YouTube profile

Boosted posts use `paid_social` as the medium and `boosted_post` as the campaign.

## Structure

- `app/` — routes (`page.tsx` = home, `privacy-policy/`, `resources/lxbp/`).
  Pages are composed by assembling blocks.
- `components/blocks/` — content blocks (Hero pieces, FeatureShowcase, CtaButton,
  AppStoreButtons).
- `components/layout/` — `Page`, `Section`, `SiteHeader`, `SiteFooter`.
- `components/backgrounds/` — dots / grid section backgrounds.
- `components/ui/` — primitives (`Button`, `Carousel`).
- `lib/site.ts` — central config (URLs, social, store links).
- `public/media/` — screenshots, feature demo videos, logos.

## Deploy

Deployed on Vercel as a static Next.js site. The `npm run build` command exports
the site to the `out/` directory.
