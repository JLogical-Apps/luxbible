# Technical Reference

## Scope

This file records architectural constraints, data boundaries, and external services that are important when changing Lux. Implementation details that can be read directly from the code or `pubspec.yaml` should not be duplicated here.

## Application

- Flutter application
- Shared Bible models, translation asset paths, and local providers live in `packages/lux` for reuse across Lux apps. Each app declares and bundles its own translation assets and owns the rendering behavior appropriate to that product.
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

The nullable highlight-style override is serialized under the existing `highlightStyles` key. This preserves previously customized or migrated labels while allowing a missing value to resolve to localized defaults.

## Privacy and Telemetry

Lux does not include:

- Analytics
- Behavioral tracking
- Crash reporting
- Advertising SDKs
- Authentication

Firebase Core and Firebase App Check are present to attest requests to the API.Bible proxy. Their presence does not represent Firebase Analytics, Crashlytics, or cloud storage of user content.

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
share the normalized reference and are combined when the chapter is read. This is used by LXX, FOB, Martin, and
NLD1939.

Bundled translations are stored as one JSON asset per book. Ordinary reading decodes a book on demand and reuses it
for every chapter in that book. Full-text search and Strong's concordance assemble the complete local Bible only when
those whole-corpus features are opened.

### Online Bible Text

These translations are loaded online when they are not available from the device cache:

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
- Footnotes: BSB, KJV, ASV, NASB95, NIV, CSB, NLT, NKJV
- Red letters: BSB, KJV, NASB95, NIV, CSB, NLT, NKJV
- Native headings: BSB, Martin, NRT, NASB95, NIV, CSB, NLT, NKJV
- Paragraph formatting: all except OSHB, SV, Martin, and NRT

## Study Data Sources

- Cross-references: OpenBible cross-reference mapping
- Dictionary: Easton's Bible Dictionary
- Lexicon: Strong's Greek and Hebrew dictionaries
- Commentaries: Matthew Henry, John Calvin, and Jamieson-Fausset-Brown
- Reading plans: schedules from public-domain and licensed sources recorded in the in-app licenses
- Verse of the Day: the first morning passage for each calendar date from Jonathan Bagster's public-domain *Daily Light on the Daily Path*, distributed as CrossWire's Daily SWORD module. The source schedule is offline; the displayed passage uses the selected translation when it can be loaded and otherwise falls back to the selected Study Bible for that passage.

The app's license registry is authoritative for detailed attribution and redistribution terms.

## Search Boundaries

Word and phrase search operates on one Bible at a time:

- If the active Bible is local, Lux searches that Bible.
- If the active Bible is online, Lux searches the user's most recently selected BSB or KJV study Bible.
- Strong's-number search uses the selected study Bible.

Word and phrase searches preserve an adjacent ordered sequence. The persisted word-matching mode compares each search
term as a whole word, the start of a word, or any part of a word. Strong's-number matching remains exact.

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
