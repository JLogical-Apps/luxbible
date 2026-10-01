# Marketing

How Lux Bible reaches people. Positioning, audience, and principles live in [`product.md`](product.md).
This file covers distribution: the growth thesis, what has been tried and what it taught, and which
channels are worth the effort.

Results here are qualitative on purpose. Numbers go stale and invite false precision, so read current
figures from the sources in [Where to read the numbers](#where-to-read-the-numbers) and record only
the conclusion here. Update a conclusion when the picture changes.

Specific posts, the current content plan, and paid results are kept in a local, gitignored
`marketing-notes.md` next to this file. Read it too when it exists.

## Core Thesis

Lux competes in a saturated market. Almost everyone in the audience already has a Bible app, usually
YouVersion, and uses it by default. The hard part is not awareness that Bible apps exist. It is
giving someone a concrete reason to try a different one.

Most Lux marketing is therefore about switching rather than discovery. Content that names a
frustration the reader already feels does better than content that demonstrates a feature they have
no reason to want yet.

Reach on its own is not the goal. A large view count on content that gives a stranger no reason to
switch produces nothing. Shares, saves, comments, and installs are the signals worth reading.

## Audience Segments

[`product.md`](product.md) describes who Lux is for as a product. These segments matter for
distribution because each is reached a different way.

| Segment | Why they convert | Where they are |
| --- | --- | --- |
| Frustrated mainstream app users | Already feel the problem | Short-form video, Reddit |
| Readers loyal to one translation | Lux bundles their translation offline and free | Facebook groups for that translation |
| Seminary and Bible college students | Cannot afford Logos, need interlinear and Strong's | Language professors, seminary communities |
| Pastors, youth pastors, group leaders | Redistribute to a whole group at once | Reading plan files, direct relationships |
| Non-English readers (nl, de, ru) | Far less competition than English | Store search in those languages |
| Privacy and indie software readers | No account, offline, no tracking | Hacker News, app roundups, r/androidapps |
| Home screen and aesthetics audiences | Verse of the Day widget | Widget-focused content |

## Content Formats

Posts are prepared and published with [`tools/socials`](../../tools/socials/README.md). The posts
themselves and their media are kept locally in `socials/`, which is gitignored.

| Format | Result | Status |
| --- | --- | --- |
| Personal video that takes a position | Best performing by a wide margin, with the largest follower and install gains. | Main focus. |
| Personal how-to video | Did fine, well behind a video that takes a position. | Only with a position at its center. |
| Narrated slideshow | Middling. Decent views and watch time, few shares or saves, and the topic mostly reaches people already interested in study tools. | Stopped. |
| Question reels | Views without engagement. They present a fact and give the viewer nothing to react to. | Stopped. |
| Scripture connection reels | Same as question reels. | Stopped. |
| Release carousel | Reaches existing followers only. | For meaningful releases, as retention rather than acquisition. |
| Capability comparison reels | Untested. Low effort, with the same ingredients as the best performer: a point of disagreement, relevance to the viewer, and a reason to comment. | Next to test. |

The best performer took a position someone could disagree with, was about something the viewer
already owned, and gave people language for a frustration they already had. Feature demonstrations
have none of those properties.

The how-to video narrows this down. It had the same person on camera and was genuinely useful, but
it taught instead of naming a frustration, so there was nothing to disagree with or recognize in
yourself. Being on camera helps, but the position is what made the first one spread.

The idea is to name a frustration the reader already feels, not to attack another app. See
[Guardrails](#guardrails).

### Honest losses

Comparison content is only credible if Lux sometimes loses. The current gaps are listed under
Current Product Limitations in [`features.md`](features.md). Sync across devices is the most
significant one and the most useful to admit openly.

## Channels

### Working

- **Short-form video** on Instagram, TikTok, Facebook, and YouTube Shorts, centered on personal
  videos. The following is still small, so reels are the only format on these platforms with
  meaningful reach to non-followers. Carousels, static posts, and stories reach existing followers
  only and are retention content, not acquisition.
- **Translation-specific Facebook groups.** A post in a group for one translation, such as "Hello
  fellow BSB readers, if you'd like to read the BSB on your phone offline and completely free, take a
  look at Lux," followed by what sets Lux apart from other Bible apps. Posts point readers to the
  Facebook profile bio rather than straight to a store. Comments have been supportive and the posts
  have driven noticeable installs. It works because it leads with something the group already cares
  about, their translation, and answers a concrete need. It only fits translations Lux bundles
  offline; see Offline Bibles in [`features.md`](features.md). Facebook profile traffic shows up as
  the `facebook` / `social_profile` campaign, and it converts to store clicks better than any other
  website source. This is the channel most clearly tied to installs, and it has not run out. Work
  through the groups for each bundled translation one at a time and stay to answer comments. Groups
  for non-English translations fit best where Lux also has an interface in that language, such as
  the Statenvertaling in Dutch, the Lutherbibel or Elberfelder in German, and the Synodal in Russian.
- **Instagram boosts of reels that already performed well organically.** These have sent real store
  traffic and attributed installs on both platforms.
- **Store listings.** Where all high-intent search demand lands, and the highest-leverage surface
  that does not depend on follower count.
- **Marketing site.** See [`websites/bible`](../../websites/bible).
- **Discord.** The community home, not an acquisition channel. It skews toward younger and more
  technical users, so much of the churchgoer audience will not join. There is currently no
  lower-friction way to stay in touch with an interested visitor.

### Not working

- **Boosting reels that underperformed organically.** Site visits with no visible install lift.
- **TikTok boosts.** Site visits comparable to Instagram, but almost none of those visitors went on
  to a store.
- **Cold creator outreach.** The ask gave creators work to do and no reason to do it. Revisit only
  with something to give: a finished video idea, or a reading plan file they can distribute to their
  own audience.

### Next to try

Take on one or two at a time alongside personal videos, in this order.

- **Reading plan files around the church calendar.** Plans import and share as `.lxbp` files, which
  makes a plan a giftable object that carries the app with it. A church, youth group, or creator can
  distribute one to a whole group at once, which also gives creator outreach something to offer.
  Advent, Lent, and Holy Week bring predictable annual demand, and a seasonal plan pairs well with a
  store editorial nomination (see [Store Editorial](#store-editorial)). A plan directory on the site
  is both a download and an SEO surface. Public domain sources include the M'Cheyne plan, the 1662
  daily office, and public domain devotionals such as Spurgeon's *Morning and Evening*. Avoid the
  Revised Common Lectionary, which is copyrighted, and never copy plans out of another app's licensed
  catalog.
- **Reddit.** Bible app recommendation threads are constant and high intent. Requires genuine
  participation rather than link drops.
- **Seminary and Bible college language professors.** A free interlinear with Strong's and
  morphology is a gift to an instructor whose students cannot afford Logos. One syllabus mention
  recurs annually, and reaching professors in the fall lines up with spring syllabi.

### Later

Ordered roughly by expected return.

- **Podcasts.** Small theology, Bible study, and church tech shows need guests, convert far better
  than short-form, and give long warm attention. Easier to book than creator sponsorships.
- **Comparison and alternative pages** on the site. The highest-intent search traffic in the niche
  ("YouVersion alternative", "free Logos alternative", Bible app comparisons). Credibility depends on
  documenting where Lux loses.
- **Non-English store search.** Lux already ships four interface languages. Competition for
  attention in Dutch, German, Russian, and Romanian is far below English.
- **The Verse of the Day widget as its own hook.** Home screen aesthetics is a large audience with no
  interest in Bible study that will install for a good-looking widget.
- **Privacy and indie software communities.** No account, fully offline, no tracking, no ads, and
  open licenses is an unusual combination that travels in those circles.

## Store Editorial

Apple and Google both take featuring nominations directly, and almost nobody submits. Nominate six
to eight weeks before a target moment, tied to a meaningful release rather than a bugfix. Bible apps
are featured around Christmas, Easter, and Lent.

Current strengths: design quality, four localizations, no ads or purchases or account, offline
operation, and a solo developer narrative.

Known gaps that would improve the odds: deeper use of platform technologies such as App Intents and
Shortcuts, an explicit iPad story, an App Preview video on the product pages, and screen reader
support. Ratings volume and technical vitals (crash-free rate, ANRs) are also read as quality
signals.

Lead a nomination with the narrative, not the feature list.

## Attribution

Store links are already tagged. [`lib/campaign.ts`](../../websites/bible/lib/campaign.ts) maps a
short `?s=` source code to a campaign, sets `pt`, `ct`, and `mt` on App Store links, and sets
`referrer` with UTM parameters on Google Play links. Google Analytics receives the same campaign.

This gives aggregate per-campaign install data on both platforms with no third-party SDK, which is
enough to answer which content and which pages drive installs.

### Where to read the numbers

- **Snapshots.** [`tools/stats`](../../tools/stats/README.md) collects the raw data from every source
  below into a dated `stats/<yyyy-MM-dd>/` folder. Read the newest one before querying a source
  directly.
- **Store stats.** From `apps/bible`, run `dart run tool/release/store_stats.dart` (`--days 90`,
  `--ios`, `--android`). It prints daily store traffic and conversion for both stores: App Store
  impressions, product page views, and first-time downloads by source, storefront, and `ct`
  campaign, and Google Play visitors, acquisitions, installs, and uninstalls by traffic source,
  search term, UTM campaign, and country. The script's header covers credentials and permissions.
- **Social stats.** From `tools/socials`, run `dart run bin/stats.dart`. See its
  [README](../../tools/socials/README.md).
- **Google Analytics.** Two properties, both readable through the `analytics` MCP server: "Lux App"
  (`525420474`, in-app events and first opens) and "Lux Website" (`552974802`, sessions, and
  `store_navigation` for store link clicks). Lux App has iOS and Android events from September 3,
  2026; its earlier rows are website hits from a web stream that predates the Lux Website property
  (September 6). Android `first_open` on September 4 and 5 includes existing users re-registering
  after the analytics update, so don't read those days as installs. Every iOS install shows as
  `(direct)` in GA, so use store stats for iOS sources and campaigns. GA site search reads the
  website's `?s=` source code as a search term. Unless site search has been turned off in the web
  stream's enhanced measurement settings, `view_search_results` events are campaign visits, not
  searches.

Deferred deep linking, meaning a link that installs the app and then opens specific content, is
deterministic on Android through the Play install referrer but has no deterministic path on iOS.
The services that offer it work by device fingerprinting, which conflicts with the Private by Design
principle in [`product.md`](product.md). Prefer the `.lxbp` file as the payload, since it survives
installation on both platforms and the cold-launch path already exists. Note that the Play
`referrer` slot is already carrying UTM parameters, so any additional payload has to join that same
string.

## Guardrails

- **Do not build a brand on criticizing YouVersion.** It is a ministry, and this audience reacts
  badly to perceived bitterness toward other believers. Name frustrations rather than opponents.
  Comparing against Logos pricing is fine because it is a commercial product.
- **Do not add tracking or attribution SDKs.** The privacy commitment in [`product.md`](product.md)
  is a stronger marketing asset than any attribution gain, and breaking it quietly would be worse
  than losing the data.
- **Include the losses in any comparison.** Honest Bible app comparisons are rare because almost
  everyone who makes one is selling something. Documenting the gaps is what makes the rest
  believable.
- **Keep testimonials pointed at the reader, not at the developer.** Social proof exists to reduce a
  stranger's risk, so the story is what the person found in Scripture, not that Lux received praise.
  Repeated self-congratulation reads poorly with this audience. Crop usernames, and ask before
  reposting anything from a private message.
- **Turn praise into reviews.** A kind comment has little lasting value. The same person leaving an
  App Store review affects conversion and editorial nomination.
- **Free is the headline, not a footnote.** No ads, no subscriptions, no in-app purchases, no
  account, and full offline operation is unusual enough in this category to lead with.
