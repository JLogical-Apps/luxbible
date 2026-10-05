# Technical Reference

## Scope

This file records architectural constraints, data boundaries, and external services that are important when changing Lux. Implementation details that can be read directly from the code or `pubspec.yaml` should not be duplicated here.

## Application

- Flutter application
- Shared Bible models, translation asset paths, and Bible provider integration points live in `packages/lux` for reuse across Lux apps. Each app supplies its own Bible providers, declares and bundles its own translation assets, and owns the rendering behavior appropriate to that product.
- The shared interactive passage renderer and loader, passage controller, verse-range selection logic, chapter paging, passage preview structure, loading-error presentation, and chapter selector live in `packages/lux`. Each app overrides `luxReaderConfigurationProvider`; Lux Bible uses its reactive configuration to map user settings, annotations, notes, footnotes, translation fallback, and study callbacks into the shared product-neutral widgets.
- Supported targets: iPhone, iPad, and Android
- Both mobile targets ship one Verse of the Day home screen widget; see [Home Screen Widgets](#home-screen-widgets)
- Responsive study layout changes at 700 logical pixels of available width
- No intentionally supported macOS, Apple Vision, desktop, or web build
- Web remains exploratory and is not currently configured

## User Data

Lux does not have accounts or authentication.

User state is serialized locally and includes:
- Last reading position and recent passages
- Active and preferred Bibles
- Toolbar and appearance configuration
- Bookmarks
- Annotations and notes
- Notebooks and highlight styles
- Reading-plan progress
- Study panels
- Audio preferences
- Onboarding and tutorial state

Native platforms persist this state in a local `user.json` file in application support storage. There is no cloud sync, cloud backup, or server-side user-content storage.

Lux resolves Dutch, German, and Russian device locales to their matching language and every other device locale to English. Localized defaults such as the active Bible list and highlight-style labels are derived from that resolved language until the user customizes them. The selected translation is persisted independently so changing the app language does not change it.

Reading-plan progress is keyed by string IDs. Included IDs remain the existing `BiblePlanType.name` values; `user.json` retains the `planProgressByType` key without a migration. Progress whose definition is unavailable is ignored when plans are hydrated. Completed status is not stored: a plan is completed when any of its history entries has every day complete. The former `completedPlans` key in `user.json` is ignored and dropped on the next save.

Each `BiblePlanProgress` started now has a UUID `instanceId` created when the plan starts, so a restarted plan gets a new one. Progress saved before this field existed has no `instanceId`, and `HydratedBiblePlanProgress.instanceId` falls back to the plan ID, which is deterministic across launches, so no `Migration` entry is needed. Annotations store an optional `planDay` (`BiblePlanDayId`: `instanceId` plus zero-based `dayIndex`). `BiblePlanReadPage` publishes its day through the keep-alive `viewedBiblePlanDayProvider` while mounted, and new annotations read it when created, which covers every creation path (selection toolbar, long-press shortcuts, and sheets on the root navigator) without threading the day through each action.

Each `BiblePlanProgress` stores a `pace`: `BiblePlanPace.relaxed()` or `BiblePlanPace.paced()` with only an ISO `endDate`. Progress saved before pace existed decodes as relaxed without a migration. On-track status is derived rather than stored: `HydratedBiblePlanProgress.daysAheadOfPace` is the number of days from `naturalEndDate` to the pace's `endDate`. Calendar-day math uses `getDaysUntil` over UTC dates so daylight saving changes don't shift counts.

Plan history uses separate `bible_plan_history/<instanceId>.json` files in application support, each holding a `BiblePlanHistoryEntry` with the plan ID, its full `BiblePlanProgress` (including any reminder), and an `endedAt` time. Stopped and finished runs are distinguished by whether every day is complete rather than by a stored field. `biblePlanHistoryProvider` loads these like custom definitions and owns moving a stopped or finished run to history and resuming it, so a run is always moved between `user.json` and history rather than copied. The file name uses `HydratedBiblePlanProgress.instanceId`, so a legacy run without an `instanceId` is stored under its plan ID and keeps its annotation links. Resuming replaces the plan's entry in `planProgressById` in place, preserving its order, after archiving any active run of that plan. Archived reminders are not scheduled because schedules derive only from active progress. Newly completed plan days, for analytics and the reminder discovery prompt, only count when the previous progress has the same `instanceId`, so swapping in a resumed run does not register its existing completions.

Custom definitions use separate `bible_plans/<uuid>.json` files in application support. `customBiblePlansProvider` loads each file independently, preserves malformed files, and exposes synchronous `create(plan)` returning a UUID and `delete(id)` persistence operations. Definition deletion is separate from user progress; the Start A Bible Plan page deletes a custom plan's history alongside its definition. `includedBiblePlansProvider` and the combined `biblePlansProvider` are keyed by string IDs. Included metadata derives from `BiblePlanType.getById(id)`; display names use `plan.getDisplayName(id)` and custom origin derives from custom-provider membership.

`BiblePlan.tryFromJson` guards decoding and model validation. Plans require a non-whitespace name, 1 through 365 days, at least one reading, valid OSIS passages, and no exact duplicate selections within a day. Empty days are reflection days. Optional `BiblePlanColor` has six hues; `colorOverride` serializes under `color`, and the resolved `color` getter retains the name-based fallback for unchanged included assets. Thumbnails accept a display name and effective color independently of identity.

Manual creation keeps its draft in page-local hook state and uses the shared `FindInBibleSheet` with the host passage-selection configuration. Exact `VerseSelection` values identify duplicate, reorder, move, and removal operations. Import accepts either a native file selection or pasted JSON and sends both sources through the same guarded `BiblePlan` decoder before feeding the shared name, color, and review steps. Book-and-duration creation reads the existing local BSB models through `localBibleProvider`. Its default duration rounds the selected chapter count proportionally against the whole Bible's 365-day duration. Its widget-independent generator flattens actual BSB verses from the selected books, classifies chapter, section, and non-poetic whole-verse paragraph starts, and recalculates the remaining verse target after every cut. Before creating passages, canonical references absent from BSB are assigned to the preceding available verse in the same chapter, or to the first available verse when the chapter begins with an omission. Generated slices are split into chapter-scoped `VerseSelection` passages, so chapter boundaries, unselected books, and nonadjacent books are never bridged. Create with AI builds a clipboard prompt from the user's description, the landed `BiblePlan` JSON shape, `BookType` OSIS identifiers, `BiblePlanColor` values, and validation constraints, then reuses the guarded import path. Its import action stays disabled until that prompt is copied and resets when the description changes. Lux does not call an AI service. Creation persists through `customBiblePlansProvider`, then starts the UUID-keyed plan through the existing user state. Discovery derives every plan's scope from its passage books, independently of Search location filters.

Portable `.lxbp` files use `BiblePlan` JSON directly and retain the existing OSIS `VerseSelection` serialization. There is no wrapper or format version. Sharing uses the native share surface with an in-memory file, while downloading uses the platform save dialog. Both use a sanitized `.lxbp` filename and substitute an included plan's localized display name in the exported definition without changing the stored asset. Optional null colors remain omitted, and IDs, progress, reminders, and Bible text are outside the serialized definition. iOS declares the custom filename extension and uniform type so the native picker can filter it. Android document providers can expose an unrecognized custom MIME type through a `.bin` cache copy, so import validates the selected file's contents rather than its temporary filename.

Every native handoff into Dart -- plan files, passage links, and widget taps -- shares one launch-link bridge per platform: a method channel that buffers the value that launched Lux until Dart asks for it, then pushes later ones as they arrive. Each handoff supplies only the rule for recognizing its own URL. Android ignores the launch intent when a task is restored from Recents, because it was already handled when it first started the task. Dart mirrors this with one launch-link channel wrapper, so each service only decides what to do with a value, and every service fetches its launch value once the first frame is up. Android's audio service can start Dart without an activity, and the native side of these channels only registers when the activity attaches, so Dart waits for the app to resume before calling them.

iOS registers the `.lxbp` document type and receives file URLs through its scene delegate. Android accepts open and single-file share intents for the custom, JSON, and generic binary MIME types in a separate, invisible `BiblePlanOpenActivity`, which checks the document name for the `.lxbp` extension, reads the file, and starts the `singleTask` main activity from Lux's own package with the contents as an extra. The Files app launches its handler inside its own task, so without that hop Lux would open as a second copy inside Files. Each platform reads the file and passes its contents through a method channel, buffering a cold-launch file until Flutter is ready. Flutter's automatic deep-link routing is disabled on both platforms because native file handling owns these incoming URLs. A file received by a running app opens the import page above its current page; a cold launch builds the Bible Plans stack beneath it. The same guarded decoder used by the in-app picker validates the contents before opening the later creation steps.

Verse sharing uses HTTPS links on `app.luxbible.app` with an OSIS `VerseSelection` in `/passage/<selection>`. The native Android and iOS entry points send matching links to Flutter, including cold-launch links and, on iOS, the URL the website's Smart App Banner passes when it opens Lux, where the selection is validated and opened in the reader. The app subdomain must serve the passage fallback page and platform association files. Android's `assetlinks.json` must use the Google Play app-signing certificate fingerprint when the domain is configured.

The published format reference lives at `https://www.luxbible.app/resources/lxbp` in the `websites/bible` Next.js site. The creation flow renders `.lxbp` mentions in the import hints as links through `url_launcher`, and the copied AI prompt cites the same URL.

The nullable highlight-style override is serialized under the existing `highlightStyles` key. This preserves previously customized or migrated labels while allowing a missing value to resolve to localized defaults.

## Privacy and Telemetry

Lux uses Firebase Analytics for aggregate usage measurement and Firebase Crashlytics for crash and non-fatal error reporting. Collection is disabled in debug builds. Reports carry the app's lifecycle state, and connectivity failures such as requests made while offline are not reported. Lux does not set Analytics or Crashlytics user IDs and does not send user-created Bible study content as telemetry.

Every navigable page implements a typed route contract with a stable, content-free path. The shared navigation helpers derive their nullable return type from the destination widget and assign that path to `RouteSettings`; `FirebaseAnalyticsObserver` records it as the screen name. The Bible page is generated through the same helper as the app's initial route, so it carries its own path rather than the framework's default name. Routes remount their page subtree when the locale changes so pages using localized model formatting refresh without requiring a builder at every call site. Dialog and sheet routes rerun their existing builders when the locale changes while preserving modal state and scroll behavior. Paths never include Bible references, search terms, plan names, or local record IDs.

The Bible page is the navigator's only root and is never replaced, so an entry point that lands the user somewhere in the app pops back to that root and pushes the pages it wants above it, naming only those pages. The root is left untouched, keeping its reading position and scroll exactly where the user left them. This needs no record of the current stack and no route matching.

A passage requested from outside the reader's widget tree -- a shared link, a Verse of the Day notification or widget tap, a passage preview -- is raised as a navigation request on a shared service rather than routed back through a callback. The Bible body listens for requests, dismisses whatever sits above the root, and moves the reader to the passage. Entry points therefore need no reference to the reader, and a preview opened from one of them can still send the user into the text.

Custom events cover audio playback starts, plan starts (including resuming a run from history), plan-day completions, incoming `.lxbp` file opens, searches, verse shares, shared passage link opens, Verse of the Day taps, Verse of the Day widget taps, notification taps, toolbar changes, community-link presses, Rate Lux presses, native review requests, onboarding lifecycle actions, and onboarding step completions. The events have fixed names. Onboarding step completions and skips include a `step` parameter with the fixed name of the completed or skipped checklist step; no other event has parameters. Plan and toolbar events are derived from successful persisted user-state transitions so canceled actions are not counted. An incoming file-open event records the handoff even when the file contents fail validation. Search events do not contain the query, plan events do not identify the plan or its reading content, and share and passage-link events do not identify the passage. A verse share is counted unless the user dismisses the share sheet, since some platforms cannot report the chosen target.

Advertising-related collection is disabled. Android removes the Advertising ID permission and disables Advertising ID collection. Apple builds use the Analytics dependency without IDFA support and disable IDFV collection. Both platforms deny ad storage, ad user data, and ad-personalization consent signals. Analytics and Crashlytics still generate random app-installation identifiers required for measurement and crash deduplication.

Android retains Firebase Analytics' Google Play Install Referrer integration. Campaign source, medium, and name can be passed from fixed website source codes through the Play Store referrer and associated with aggregate installation analytics. This does not enable the Advertising ID or Android ad-services attribution permissions. The website reports store-navigation events and configures its Google Analytics page view with the equivalent campaign fields while leaving the compact source code visible in the URL. The `/passage/<selection>` fallback page only loads when the app did not claim the link, which can still happen with Lux installed, for example in an in-app browser. On Android it replaces the page with an `intent://` URL for the same passage restricted to the Lux package, so Chrome opens Lux when it is installed and otherwise follows the intent's `browser_fallback_url` to Google Play. A web page cannot detect whether an iOS app is installed, so iOS does not redirect; the page declares an `apple-itunes-app` Smart App Banner whose app argument is the passage URL. Its URL has no source code, so the Play fallback and the store buttons fall back to a fixed passage-share campaign (`lux_bible` / `share` / `passage_share`), passed to Google Play through the referrer and to the App Store as the `passage-share` campaign token. An explicit source code in the URL still takes precedence.

Lux does not include advertising SDKs, authentication, or cloud storage of user content. Firebase Core and Firebase App Check also attest requests to the API.Bible proxy.

Bible plan reminders use scheduled local notifications. They do not use Firebase Messaging or a remote push service. Lux allocates up to 14 dated one-shot notifications across reminder-enabled plans, giving each plan an equal rolling horizon while staying within native pending-notification limits alongside Verse of the Day. Completing a plan day removes that date from the desired schedule so the generic notification service cancels it and starts the next reading's reminders on the following local date. Bible plan state is projected into app-level local notification schedule models, while the generic notification service declaratively reconciles those schedules without depending on Bible plan types. Tapping a plan notification routes through the Bible Plans stack to the earliest incomplete passage, or safely back to Bible Plans when the plan is unavailable, complete, or at a review day.

Verse of the Day uses the same local-notification service with its own Android channel. It creates dated one-shot notifications over a fourteen-day rolling horizon rather than a fixed recurring body, because the passage and effective translation can vary by date. A notification payload retains the scheduled date so its tap opens that date's preview. Its fourteen notifications plus the Bible-plan notification allocation do not exceed iOS's 64 pending-notification limit.

Authorization availability is tracked separately for the app, the Android Bible Plan Reminders channel, and the Android Verse of the Day channel. App-level disablement affects both reminder controls; a disabled channel affects only its matching reminder type. Persisted times and discovery answers are never cleared for an unavailable app or channel. The app restores Android schedules after reboot or app replacement and reconciles all persisted schedules at startup and after returning from system settings. Reconciliation replaces same-ID pending requests and removes stale IDs only when a reminder is disabled or its scheduling inputs change.

## Home Screen Widgets

Both mobile targets ship one Verse of the Day home screen widget. iOS embeds a WidgetKit extension, `VerseOfTheDayWidgetExtension`, bundled as `app.luxbible.app.VerseOfTheDayWidget`, supporting the small, medium, and large families that StandBy also uses. Android registers a single resizable `AppWidgetProvider`, four cells by two by default. Neither platform offers a Lock Screen or accessory widget.

Neither widget holds Bible data or resolves anything. The app precomputes a rolling fourteen-day horizon of entries, each already carrying its formatted reference, effective translation title, and verse text, and pushes them as one JSON payload over an `app.luxbible.app/widgets` method channel. iOS writes it to the `group.app.luxbible.app` app group, which both the app and the extension are entitled to and which must also exist in the Apple Developer account for a signed build to succeed. Android writes it to a private `SharedPreferences` file, because the widget runs in the app's own process. Every write redraws the widget.

The reminders and the widget resolve their horizons through one shared helper over the existing per-date provider, each projecting the result into its own entries; a date that cannot be loaded is dropped from both. Every field of a widget entry is required on both platforms, so a payload left behind by an older install whose shape has since changed reads as nothing and the widget shows its empty state rather than blanks. The whole horizon is exposed as one comparable payload, so the synchronizer only writes when something actually changed. The app rewrites it whenever its inputs change and reconciles it again on resume, alongside the notification schedules. The horizon is independent of the notification horizon, which is instead bounded by iOS's pending-notification limit.

Each platform serves the current local day out of that horizon and falls back to a prompt to open Lux once it runs out. WidgetKit does this with a timeline carrying one entry per day. Android has no timeline, so every redraw schedules the next one for local midnight through `AlarmManager`, and the provider additionally refreshes on the system time, time zone, and locale broadcasts.

Widget chrome, limited to the gallery name, description, and empty state, is localized natively for English, Dutch, German, and Russian: in the extension's string catalog on iOS, and in string resources on Android. Every passage-derived string is supplied by the app, so both follow the same resolved language. Both widgets use system fonts rather than the app's bundled reading fonts and mirror the shared zinc palette. iOS declares its background through the iOS 17 widget container so StandBy can remove it; Android adopts the launcher's own widget corner radius from API 31 and scales the passage down before truncating it, since one layout has to cover every size the widget can be resized to.

Taps open `luxbible://verse-of-the-day?date=<yyyy-MM-dd>`. A link without a valid date opens today's passage. Either way it returns to the Bible page and presents the passage preview sheet above it, the same destination a Verse of the Day notification opens. Both entry points route through one shared destination, so they cannot drift apart; each supplies only its own date parsing and analytics event. iOS declares the scheme and receives the URL through a Flutter scene life-cycle delegate registered before the generated plugin registrant, so a widget tap that cold-launches Lux is seen before another plugin can claim the scene connection. Android's widget targets the launcher activity explicitly, so the scheme is never advertised in the manifest.

## Offline and Online Boundaries

### Fully Bundled

The following are bundled with the app and work offline:

- BSB
- MSB
- CSB
- KJV
- ASV
- WEB
- SV
- NLD1939
- ELB1905
- LUT1912
- SYNO
- FOB
- Martin
- RVG
- LXX
- TR
- BYZ
- SR
- OSHB
- Strong's Greek and Hebrew lexicon
- Tyndale Open Bible Dictionary articles and maps
- Tyndale Open Study Notes commentary, people profiles, and theme articles
- Matthew Henry commentary
- John Calvin commentary
- Jamieson-Fausset-Brown commentary
- OpenBible cross-reference data
- Reading-plan schedules
- Verse of the Day schedule
- Verse of the Day source passages from the bundled Daily Light data
- Search of local Bible text
- Annotations, notebooks, bookmarks, and settings

Bundled sources with alternate versification use Lux's KJV-compatible references in their OSIS `osisID` values and
retain the source translation's reference in `origin`. When multiple source verses correspond to one Lux verse, they
share the normalized reference and are combined when the chapter is read. This is used by LXX, FOB, Martin, NLD1939,
LUT1912, and SYNO.

Bundled translations are stored as one JSON asset per book. Ordinary reading decodes a book on demand and reuses it
for every chapter in that book. Full-text search and Strong's concordance assemble the complete local Bible only when
those whole-corpus features are opened.

Bundled commentaries are also stored as one JSON asset per book and decoded on demand. Their structured content keeps
book summaries, book introductions, Calvin's book-level Arguments, chapter outlines, and verse-linked sections
distinct. Summaries and introductions are omitted from the JSON when empty, so only Tyndale's assets carry a
summary. Section titles are derived from the book in the UI rather than stored. Only verse-linked sections participate in linked-panel
synchronization, though summaries and introductions still take part in header navigation. They and outlines remain
positioned at verse 1 until their linked commentary reaches the top.
Commentary sections contain normalized `RichContent` blocks rather than source-specific XML classes. Paragraph blocks retain
semantic presentation such as quotations, poetry, headings, and attribution, while table blocks retain their rows and
cells. The bundled explicit outlines are all scoped to one chapter, although each outline item can target any verse
range supported by `VerseSelection`. Linked Commentary panels precalculate every item extent so their scroll range and
scrollbar remain stable throughout the chapter.

Tyndale Open Study Notes (CC BY-SA 4.0), shown in the app as Tyndale Study Notes, is generated by `tools/content/lib/tyndale_commentary.dart` from
`content/sources/commentary/tyndale/`. Its `StudyNotes.xml` becomes verse-linked sections, `BookIntros.xml` becomes
the book introduction, and `BookIntroSummaries.xml` becomes the book summary. The summary drops its "The Book of …"
title paragraph and turns each Purpose/Author/Date/Setting heading and body pair into one paragraph led by the bold
label. `Profiles.xml` and `ThemeNotes.xml` become the People and Themes articles described below.
Sections are keyed by the chapter of their first verse, like the other commentaries, so a range that crosses chapters
appears only in its starting chapter. Within a chapter they are ordered
by start verse with the wider range first, and notes with an identical range share one section. The generator maps
Tyndale's book codes to OSIS, repairs truncated cross-chapter links from their display text, drops links to Tyndale
items Lux does not bundle, folds the NLT-only 3 John 15 and Revelation 12:18 into the previous verse, and fails on any
reference it cannot resolve. Notes separate their sub-points with bullets, which become separate paragraphs. Quoted NLT wording is bold and the divine name is written as LORD.

Tyndale's Scripture links, book codes, and inline formatting are converted by the shared
`tools/content/lib/tyndale.dart`, which the commentary generator, `tools/content/lib/tyndale_articles.dart`, and
`tools/content/lib/tyndale_dictionary.dart` all use. Besides the repairs above, it normalizes hrefs that use en dashes
or colons as separators, partial-verse letters such as `6:6b`, or a repeated range end, turns verse lists such as
`Ps.115.10,12` into multi-span selections that continue in the previous reference's chapter unless the display text
names another, as in "Pss 17:7, 98:1" for `Ps.17.7,98`, clamps a range end past its chapter to the
chapter's last verse, and keeps links to deuterocanonical books as plain text.

Passage-linked content has no generic resource model. Each kind of content is its own list of items, each item has its
own linked passages, and Linked Resources filters each relevant list for items with a passage that overlaps the
selection. The lists share only the `LinkedResource` mixin, which ranks items by their narrowest overlapping passage and
matches title searches. People and themes share one `Article` shape: an ID, a title, a body of the same `RichContent` blocks commentary
uses, and a list of `VerseSelection` passages. `generate_articles_json.dart` writes them as one minified list per kind
to `assets/people/tyndale.json` and `assets/themes/tyndale.json`, which are decoded on first use and kept in memory.
Items are classified by source file because `ThemeNotes.xml` marks one theme with the Profile type name. An article's
ID is the source item name, its title paragraph is dropped, and its passages are the source anchor passage followed by
every link in its "Passages for Further Study" paragraph, without duplicates. The further-study title and list are not
kept in the body. Overlap compares every verse a passage covers, so a range that crosses chapters matches in each of
them, unlike commentary sections, which are keyed by their starting chapter. There is no link index; the lists are
filtered whenever the selection or visible verses change.

The Tyndale Open Bible Dictionary (CC BY-SA 4.0) uses the same `Article` shape without passages, so it is never
loaded for Linked Resources. `generate_dictionary_json.dart` writes all 6,010 articles from
`content/sources/dictionary/tyndale/Articles/` to `assets/dictionary/tyndale.json` (about 10 MB), which is decoded the
first time the Dictionary, a dictionary link, or Search needs it. The title paragraph and the asterisks that
mark terms missing from the NLT are dropped. Cross-references become `dictionary:<id>` links that open the linked
article, and in-article outline anchors become plain text. Included text boxes and charts become `box` content blocks
holding their paragraphs and tables, and included maps become `bibleMap` blocks that show the map inline. Pictures are
omitted because the open release has only their captions. Articles, Textboxes.xml, and Charts.xml disagree on the case
of some included names (`AbrahamSBosom` for `AbrahamsBosom`), so includes and map aliases are matched case-insensitively.
The generator keeps the few links it cannot resolve as plain text and lists them, rather than failing.

The dictionary's maps are their own list of `BibleMap` items: an ID, a title, an optional caption, and passages. The
image path is derived from the ID as `assets/maps/tyndale/<id>.webp`. `content/sources/dictionary/tyndale/maps.json`
is the hand-curated source, with one entry per image, the Maps.xml entry names that use it as aliases, a checked
caption, and the passages the map illustrates; `generate_maps_json.dart` validates it and writes
`assets/maps/tyndale.json`. The WebP images are rasterized once from the PDFs by
`tools/content/python/maps/rasterize_tyndale_maps.py`, about 9 MB in total. Maps are shown on a light background in
dark mode because inverting the grayscale print art turns its relief shading into a negative.

### Online Bible Text

These translations are loaded online when they are not available from the device cache:

- AMP through the YouVersion Platform
- NASB95 through the YouVersion Platform
- NIV through the YouVersion Platform
- NRT through the YouVersion Platform
- HTB through the YouVersion Platform
- HFA through the YouVersion Platform
- NTR through the YouVersion Platform
- NLT through API.Bible
- NKJV through API.Bible

API.Bible requests go through `scripture.luxbible.app` and use Firebase App Check. YouVersion passages are requested from the YouVersion Platform.

Successfully loaded online chapters are stored as individual files in the operating system's application-cache
directory. Cache entries are shared by all chapter consumers, scoped by translation and chapter, and remain valid for
fourteen days. Expired or malformed entries are removed when accessed. Cache failures do not replace the original
network result or error, and the operating system may reclaim cache files earlier when it needs storage.

The bundled CSB license expires on August 24, 2028. Requests after that calendar date fail before the local asset is loaded. Its source DBL bundle and generated runtime asset remain local and gitignored so the licensed text is not distributed through GitHub.

### Audio

BSB and KJV audio is streamed from `audio.luxbible.app`. Audio is not bundled for offline playback.

## Bible Roles

### Study Bibles

BSB and KJV are Lux's two study Bibles. Their runtime data includes the alignment needed for:

- Strong's numbers
- Greek or Hebrew inflections
- Morphology
- Transliteration
- Interlinear ordering
- Word-level lexical breakdown

When a feature requires study data while an online or non-study Bible is active, Lux uses the user's most recently selected BSB or KJV study Bible where appropriate.

### Original-Language Bibles

Lux includes these original-language reading texts:

- LXX: Septuagint, Rahlfs
- TR: Textus Receptus, Stephens 1550
- BYZ: Robinson-Pierpont Byzantine Textform 2005
- SR: Statistical Restoration Greek New Testament
- OSHB: Open Scriptures Hebrew Bible

They are standalone reading texts. They do not expose the same word-aligned interlinear experience as BSB and KJV.

### Testament-Limited Bibles

- LXX and OSHB contain the Old Testament.
- TR, BYZ, and SR contain the New Testament.

When a testament-limited Bible does not contain the current book, Lux falls back to the user's preferred original-language Bible for that testament.

## Translation Capabilities

Capabilities vary by translation:

- Study and interlinear: BSB, KJV
- Audio: BSB, KJV
- Synthetic BSB headings: KJV, ASV, WEB
- Footnotes: BSB, MSB, KJV, ASV, WEB, AMP, NASB95, NIV, CSB, NLT, NKJV, HFA, NTR
- Red letters: BSB, MSB, KJV, WEB, AMP, NASB95, NIV, CSB, NLT, NKJV
- Native headings: BSB, MSB, Martin, NRT, AMP, NASB95, NIV, CSB, NLT, NKJV, HFA, NTR
- Paragraph formatting: all except OSHB, SV, Martin, NRT, ELB1905, LUT1912, NLD1939, FOB, and SYNO

## Study Data Sources

- Cross-references: OpenBible cross-reference mapping
- Dictionary and maps: Tyndale Open Bible Dictionary
- Lexicon: Strong's Greek and Hebrew dictionaries
- Commentaries: Tyndale Open Study Notes, Matthew Henry, John Calvin, and Jamieson-Fausset-Brown
- People and themes: Tyndale Open Study Notes profiles and theme articles
- Reading plans: schedules from public-domain and licensed sources recorded in the in-app licenses, with source-level corrections documented alongside imported data
- Verse of the Day: the first morning passage for each calendar date from Jonathan Bagster's public-domain *Daily Light on the Daily Path*, distributed as CrossWire's Daily SWORD module. The source schedule is offline; the displayed passage uses the selected translation when it can be loaded and otherwise falls back to the selected Study Bible for that passage.

The app's license registry is authoritative for detailed attribution and redistribution terms.

## Search Boundaries

Word and phrase search operates on one Bible at a time:

- If the active Bible is local, Lux searches that Bible.
- If the active Bible is online, Lux searches the user's most recently selected BSB or KJV study Bible.
- Strong's-number search uses the selected study Bible.

Word and phrase searches preserve an adjacent ordered sequence. The word-matching mode is local Search page state and
is not serialized with the user. It compares each search term as a whole word, the start of a word, or any part of a
word. Strong's-number matching remains exact.

Displayed numbers participate in word and phrase search with their grouping commas preserved. Formatted and
unformatted forms, such as `5,233` and `5233`, are not normalized to one another.

Search does not download or index online translations and does not search all active translations simultaneously.

## Responsive Layout

- Below 700 logical pixels of available width, study panels dock below the Bible and can be resized up to 75 percent of the screen height.
- At 700 logical pixels and above, study panels appear to the right of the Bible in a 4:3 reading-to-panel layout.
- Orientation alone does not determine placement.

## Current Architectural Limitations

- No account system
- No cross-device sync
- No user-data export
- No cloud backup
- No web target configuration
- No offline audio downloads
- No full-text annotation-note search
- Custom-plan creation drafts are not persisted, and saved custom plans cannot be edited

## Shared selection components

Lux provides `FindInBibleSheet` for passage selection with an explicit selection configuration and the shared reader configuration for preview rendering. Memory uses it for verse and range selection, including whole-chapter selection from navigation and preview. `PassageSelectionPreview` handles chapter loading and rendering separately. Ordinary reader navigation retains its existing behavior; whole-chapter actions require `PositionSelectorBody.onSelectEntireChapter`.

`BookSelectionSections` and `BookSelectionSummary` accept selected books and a change callback for controlled module steps. `BookSelectionSheet` adds sheet state, search, configurable Clear, and optional required selection. Testament and optional Whole Bible checkboxes derive from complete book coverage. Search and Annotations keep selected books directly and use this sheet without the separate Whole Bible row; empty selection remains unrestricted. Book-based custom-plan creation uses the separate Whole Bible section and requires at least one selected book.
