# Technical Reference

## Scope

This file records architectural constraints, data boundaries, and external services that are important when changing Lux. Implementation details that can be read directly from the code or `pubspec.yaml` should not be duplicated here.

## Application

- Flutter application
- Supported targets: iPhone, iPad, and Android
- Responsive study layout changes at 800 logical pixels
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

## Privacy and Telemetry

Lux does not include:

- Analytics
- Behavioral tracking
- Crash reporting
- Advertising SDKs
- Authentication

Firebase Core and Firebase App Check are present to attest requests to the API.Bible proxy. Their presence does not represent Firebase Analytics, Crashlytics, or cloud storage of user content.

## Offline and Online Boundaries

### Fully Bundled

The following are bundled with the app and work offline:

- BSB
- KJV
- ASV
- SV
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
- Search of local Bible text
- Annotations, notebooks, bookmarks, and settings

### Online Bible Text

These translations require a connection:

- NASB95 through the YouVersion Platform
- NIV through the YouVersion Platform
- CSB through API.Bible
- NLT through API.Bible
- NKJV through API.Bible

API.Bible requests go through `scripture.luxbible.app` and use Firebase App Check. YouVersion passages are requested from the YouVersion Platform.

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
- TR: Textus Receptus, 1550/1894
- BYZ: Byzantine Textform 2013
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
- Native headings: BSB, NASB95, NIV, CSB, NLT, NKJV
- Paragraph formatting: all except OSHB and SV

## Study Data Sources

- Cross-references: OpenBible cross-reference mapping
- Dictionary: Easton's Bible Dictionary
- Lexicon: Strong's Greek and Hebrew dictionaries
- Commentaries: Matthew Henry, John Calvin, and Jamieson-Fausset-Brown
- Reading plans: schedules from public-domain and licensed sources recorded in the in-app licenses

The app's license registry is authoritative for detailed attribution and redistribution terms.

## Search Boundaries

Word and phrase search operates on one Bible at a time:

- If the active Bible is local, Lux searches that Bible.
- If the active Bible is online, Lux searches the user's most recently selected BSB or KJV study Bible.
- Strong's-number search uses the selected study Bible.

Search does not download or index online translations and does not search all active translations simultaneously.

## Responsive Layout

- Below 800 logical pixels, study panels dock below the Bible and can be resized up to 75 percent of the screen height.
- At 800 logical pixels and above, study panels appear to the right of the Bible in a 3:2 reading-to-panel layout.
- Orientation alone does not determine placement.

## Current Architectural Limitations

- No account system
- No cross-device sync
- No user-data export
- No cloud backup
- No web target configuration
- No offline audio downloads
- No full-text annotation-note search
