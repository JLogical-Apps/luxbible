# Technical Reference

## Scope

This file records architectural constraints, data boundaries, and external services that are important when changing Lux. Implementation details that can be read directly from the code or `pubspec.yaml` should not be duplicated here.

## Application

- Flutter application
- Shared Bible models, translation asset paths, and Bible provider integration points live in `packages/lux` for reuse across Lux apps. Each app supplies its own Bible providers, declares and bundles its own translation assets, and owns the rendering behavior appropriate to that product.
- The shared interactive passage renderer and loader, passage controller, verse-range selection logic, chapter paging, passage preview structure, loading-error presentation, and chapter selector live in `packages/lux`. Each app overrides `luxReaderConfigurationProvider`; Lux Bible uses its reactive configuration to map user settings, annotations, notes, footnotes, translation fallback, and study callbacks into the shared product-neutral widgets.
- Supported targets: iPhone, iPad, and Android
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

Lux resolves Dutch and Russian device locales to their matching language and every other device locale to English. Localized defaults such as the active Bible list and highlight-style labels are derived from that resolved language until the user customizes them. The selected translation is persisted independently so changing the app language does not change it.

Reading-plan progress is keyed by string IDs and completed plan IDs are strings. Included IDs remain the existing `BiblePlanType.name` values; `user.json` retains the `planProgressByType` and `completedPlans` keys without a migration. The user notifier ignores progress and completed IDs whose definitions are unavailable when loading saved state. The filtered state is persisted on the next user update.

Custom definitions use separate `bible_plans/<uuid>.json` files in application support. `customBiblePlansProvider` loads each file independently, preserves malformed files, and exposes synchronous `create(plan)` returning a UUID and `delete(id)` persistence operations. Definition deletion is separate from user progress and completed status. `includedBiblePlansProvider` and the combined `biblePlansProvider` are keyed by string IDs. Included metadata derives from `BiblePlanType.getById(id)`; display names use `plan.getDisplayName(id)` and custom origin derives from custom-provider membership.

`BiblePlan.tryFromJson` guards decoding and model validation. Plans require a non-whitespace name, 1 through 365 days, at least one reading, valid OSIS passages, and no exact duplicate selections within a day. Empty days are reflection days. Optional `BiblePlanColor` has six hues; `colorOverride` serializes under `color`, and the resolved `color` getter retains the name-based fallback for unchanged included assets. Thumbnails accept a display name and effective color independently of identity.

Manual creation keeps its draft in page-local hook state and uses the shared `FindInBibleSheet` with the host passage-selection configuration. Exact `VerseSelection` values identify duplicate, reorder, move, and removal operations. Import accepts either a native file selection or pasted JSON and sends both sources through the same guarded `BiblePlan` decoder before feeding the shared name, color, and review steps. Book-and-duration creation reads the existing local BSB models through `localBibleProvider`. Its default duration rounds the selected chapter count proportionally against the whole Bible's 365-day duration. Its widget-independent generator flattens actual BSB verses from the selected books, classifies chapter, section, and non-poetic whole-verse paragraph starts, and recalculates the remaining verse target after every cut. Before creating passages, canonical references absent from BSB are assigned to the preceding available verse in the same chapter, or to the first available verse when the chapter begins with an omission. Generated slices are split into chapter-scoped `VerseSelection` passages, so chapter boundaries, unselected books, and nonadjacent books are never bridged. Create with AI builds a clipboard prompt from the user's description, the landed `BiblePlan` JSON shape, `BookType` OSIS identifiers, `BiblePlanColor` values, and validation constraints, then reuses the guarded import path. Its import action stays disabled until that prompt is copied and resets when the description changes. Lux does not call an AI service. Creation persists through `customBiblePlansProvider`, then starts the UUID-keyed plan through the existing user state. Discovery derives every plan's scope from its passage books, independently of Search location filters.

Portable `.lxbp` files use `BiblePlan` JSON directly and retain the existing OSIS `VerseSelection` serialization. There is no wrapper or format version. Sharing uses the native share surface with an in-memory file, while downloading uses the platform save dialog. Both use a sanitized `.lxbp` filename and substitute an included plan's localized display name in the exported definition without changing the stored asset. Optional null colors remain omitted, and IDs, progress, reminders, and Bible text are outside the serialized definition. iOS declares the custom filename extension and uniform type so the native picker can filter it. Android document providers can expose an unrecognized custom MIME type through a `.bin` cache copy, so import validates the selected file's contents rather than its temporary filename.

The published format reference lives at `https://www.luxbible.app/resources/lxbp` in the `websites/bible` Next.js site. The creation flow renders `.lxbp` mentions in the import hints as links through `url_launcher`, and the copied AI prompt cites the same URL.

The nullable highlight-style override is serialized under the existing `highlightStyles` key. This preserves previously customized or migrated labels while allowing a missing value to resolve to localized defaults.

## Privacy and Telemetry

Lux uses Firebase Analytics for aggregate usage measurement and Firebase Crashlytics for crash and non-fatal error reporting. Collection is disabled in debug builds. Lux does not set Analytics or Crashlytics user IDs and does not send user-created Bible study content as telemetry.

Every navigable page implements a typed route contract with a stable, content-free path. The shared navigation helpers derive their nullable return type from the destination widget and assign that path to `RouteSettings`; `FirebaseAnalyticsObserver` records it as the screen name. Routes remount their page subtree when the locale changes so pages using localized model formatting refresh without requiring a builder at every call site. Dialog and sheet routes rerun their existing builders when the locale changes while preserving modal state and scroll behavior. Paths never include Bible references, search terms, plan names, or local record IDs.

Custom events cover audio playback starts, plan starts, plan-day completions, searches, Verse of the Day taps, notification taps, toolbar changes, community-link presses, Rate Lux presses, native review requests, and onboarding lifecycle actions. The events have fixed names and no parameters. Plan and toolbar events are derived from successful persisted user-state transitions so canceled actions are not counted. Search events do not contain the query, and plan events do not identify the plan or its reading content.

Advertising-related collection is disabled. Android removes the Advertising ID permission and disables Advertising ID collection. Apple builds use the Analytics dependency without IDFA support and disable IDFV collection. Both platforms deny ad storage, ad user data, and ad-personalization consent signals. Analytics and Crashlytics still generate random app-installation identifiers required for measurement and crash deduplication.

Android retains Firebase Analytics' Google Play Install Referrer integration. Campaign source, medium, and name can be passed from fixed website source codes through the Play Store referrer and associated with aggregate installation analytics. This does not enable the Advertising ID or Android ad-services attribution permissions. The website reports store-navigation events and configures its Google Analytics page view with the equivalent campaign fields while leaving the compact source code visible in the URL.

Lux does not include advertising SDKs, authentication, or cloud storage of user content. Firebase Core and Firebase App Check also attest requests to the API.Bible proxy.

Bible plan reminders use scheduled local notifications. They do not use Firebase Messaging or a remote push service. Lux allocates up to 14 dated one-shot notifications across reminder-enabled plans, giving each plan an equal rolling horizon while staying within native pending-notification limits alongside Verse of the Day. Completing a plan day removes that date from the desired schedule so the generic notification service cancels it and starts the next reading's reminders on the following local date. Bible plan state is projected into app-level local notification schedule models, while the generic notification service declaratively reconciles those schedules without depending on Bible plan types. Tapping a plan notification routes through the Bible Plans stack to the earliest incomplete passage, or safely back to Bible Plans when the plan is unavailable, complete, or at a review day.

Verse of the Day uses the same local-notification service with its own Android channel. It creates dated one-shot notifications over a fourteen-day rolling horizon rather than a fixed recurring body, because the passage and effective translation can vary by date. A notification payload retains the scheduled date so its tap opens that date's preview. Its fourteen notifications plus the Bible-plan notification allocation do not exceed iOS's 64 pending-notification limit.

Authorization availability is tracked separately for the app, the Android Bible Plan Reminders channel, and the Android Verse of the Day channel. App-level disablement affects both reminder controls; a disabled channel affects only its matching reminder type. Persisted times and discovery answers are never cleared for an unavailable app or channel. The app restores Android schedules after reboot or app replacement and reconciles all persisted schedules at startup and after returning from system settings. Reconciliation replaces same-ID pending requests and removes stale IDs only when a reminder is disabled or its scheduling inputs change.

## Offline and Online Boundaries

### Fully Bundled

The following are bundled with the app and work offline:

- BSB
- CSB
- KJV
- ASV
- SV
- NLD1939
- ELB1905
- LUT1912
- FOB
- Martin
- RVG
- LXX
- TR
- BYZ
- SR
- OSHB
- Strong's Greek and Hebrew lexicon
- Easton's Bible Dictionary
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
and LUT1912.

Bundled translations are stored as one JSON asset per book. Ordinary reading decodes a book on demand and reuses it
for every chapter in that book. Full-text search and Strong's concordance assemble the complete local Bible only when
those whole-corpus features are opened.

Bundled commentaries are also stored as one JSON asset per book and decoded on demand. Their structured content keeps
book introductions, Calvin's book-level Arguments, chapter outlines, and verse-linked sections distinct. Only
verse-linked sections participate in linked-panel synchronization; introductions and outlines remain positioned at
verse 1 until their linked commentary reaches the top.
Commentary sections contain normalized content blocks rather than source-specific XML classes. Paragraph blocks retain
semantic presentation such as quotations, poetry, headings, and attribution, while table blocks retain their rows and
cells. The bundled explicit outlines are all scoped to one chapter, although each outline item can target any verse
range supported by `VerseSelection`. Linked Commentary panels precalculate every item extent so their scroll range and
scrollbar remain stable throughout the chapter.

### Online Bible Text

These translations are loaded online when they are not available from the device cache:

- AMP through the YouVersion Platform
- NASB95 through the YouVersion Platform
- NIV through the YouVersion Platform
- NRT through the YouVersion Platform
- HTB through the YouVersion Platform
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
- Synthetic BSB headings: KJV, ASV
- Footnotes: BSB, KJV, ASV, AMP, NASB95, NIV, CSB, NLT, NKJV
- Red letters: BSB, KJV, AMP, NASB95, NIV, CSB, NLT, NKJV
- Native headings: BSB, Martin, NRT, AMP, NASB95, NIV, CSB, NLT, NKJV
- Paragraph formatting: all except OSHB, SV, Martin, NRT, ELB1905, and LUT1912

## Study Data Sources

- Cross-references: OpenBible cross-reference mapping
- Dictionary: Easton's Bible Dictionary
- Lexicon: Strong's Greek and Hebrew dictionaries
- Commentaries: Matthew Henry, John Calvin, and Jamieson-Fausset-Brown
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
