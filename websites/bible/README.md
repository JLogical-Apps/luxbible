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

Deployed on Vercel as a Next.js site.

The `app.luxbible.app` domain serves `/passage/<OSIS selection>` from this project as a
browser fallback for shared verse links. Assign the subdomain to this Vercel project
and serve the association files in `public/.well-known/` from it. Verify both
files are reachable over HTTPS without redirects before treating app links as live.
