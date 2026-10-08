# Lux stats snapshots

Collects raw stats from every source into a dated, gitignored folder, so later chats can read recent numbers instead of
querying each source again.

```sh
cd tools/stats
dart pub get
dart run bin/collect.dart                       # all sources, last 90 days
dart run bin/collect.dart --source=analytics    # rerun one source; other files from the same day are kept
dart run bin/collect.dart --days 28
```

Output goes to `stats/<yyyy-MM-dd>/` at the repository root. Running again on the same day overwrites that day's files
for the sources collected. Sources run in parallel and fail independently, so one broken credential doesn't block the
rest.

## Files

| File | Source | Contents |
| --- | --- | --- |
| `collection.json` | | When each source was last collected that day, and its error if it failed |
| `socials.json` | `tools/socials/bin/stats.dart --json` | Followers and every post with lifetime views, reach, likes, comments, shares, saves, and average watch time, for TikTok, YouTube, Instagram and Facebook |
| `app-store.json` | `apps/bible/tool/release/store_stats.dart --ios --json` | Apple's daily Discovery and Engagement and Download report rows, standard and detailed (by campaign) |
| `google-play.json` | `apps/bible/tool/release/store_stats.dart --android --json` | Play Console traffic source, country, and install rows |
| `analytics.json` | GA4 Data API | Fixed reports for the Lux App and Lux Website properties, listed in `AnalyticsReport` in [`lib/analytics.dart`](lib/analytics.dart) |
| `crashlytics.json` | Crashlytics API | Top issues and top versions per app and error type |

Notes for reading them:

- App Store rows count impressions and page views as `unique counts` with `event` of `Impression` or `Page view`, and
  downloads as `counts` with `download type` of `First-time download`. Apple hides detailed rows from fewer than 5
  devices.
- GA rows are flat objects keyed by dimension and metric name, covering `90daysAgo` to `yesterday`. Daily rows can't be
  summed into distinct users; use the `*Totals` and `appEventUsers` reports for those. `appCohorts` gives active users by
  first session date and date, which is enough to compute day-N retention. `userEngagementDuration` is in seconds.
- The Lux App property has iOS and Android events from September 3, 2026. Its `web` platform rows are website hits from
  before the Lux Website property existed.
- Social post metrics are lifetime totals, so older posts have had longer to collect views.
- Social posts have no ID, so match a post across snapshots by its `date` plus the start of its `caption`.
- `appDaily` carries `dauPerMau` and `dauPerWau` as 0 to 1 ratios for each day. They stay out of `appTotals` because
  without a date dimension GA sums them and inflates the `activeUsers` requested alongside them.
- Crashlytics only accepts intervals within the last 90 days, so its window is capped at 89.

## Setup

- **Socials and stores** use the credentials those scripts already read: `tools/socials/.env` and
  `apps/bible/tool/release/.env`. Google Play also needs the Play service account to have "View app information and
  download bulk reports" under Users and permissions in Play Console.
- **Google Analytics and Crashlytics** use gcloud Application Default Credentials, the same ones the `analytics` MCP
  server uses. They impersonate `analytics-mcp@lux-bible.iam.gserviceaccount.com`, and `gcloud` must be on `PATH`.
  Crashlytics additionally needs the Firebase Crashlytics API enabled on the `lux-bible` project, and that service
  account needs the Firebase Crashlytics Viewer role. When running `dart` with a workspace-local `HOME` (see the root
  `CLAUDE.md`), also set `CLOUDSDK_CONFIG="/Users/<you>/.config/gcloud"`, or gcloud can't find the credentials.
