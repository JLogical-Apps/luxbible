# Feature Specification

This file describes user-facing behavior implemented in the current working tree and intended for the upcoming release.

## Supported Platforms

- iPhone
- iPad
- Android

Lux uses a single reading area with optional study panels. Panels appear below the Bible on narrower layouts and to its right on layouts at least 800 logical pixels wide.

## Bible Library

### Offline Bibles

- BSB: Berean Standard Bible and the default Bible
- KJV: King James Version
- ASV: American Standard Version
- SV: Statenvertaling in Dutch
- LXX: Septuagint, Rahlfs
- TR: Textus Receptus, 1550/1894
- BYZ: Byzantine Textform 2013
- SR: Statistical Restoration Greek New Testament
- OSHB: Open Scriptures Hebrew Bible

### Online Bibles

- NASB95
- NIV
- CSB
- NLT
- NKJV

### Bible Management

The Bibles page lets users:

- See every available Bible grouped by language
- Add or remove Bibles from their active set
- Reorder active Bibles
- Open Bible details
- See whether a Bible is online or offline
- See whether a Bible covers the whole Bible or only one testament
- See supported features such as study data, red letters, headings, paragraphs, and footnotes
- Review copyright information where applicable

At least one Bible must remain active. The order of active Bibles controls their order in translation selectors and Compare.

BSB and KJV are the two study Bibles. LXX and OSHB contain the Old Testament, while TR, BYZ, and SR contain the New Testament.

## Reading Experience

### Display

Lux supports:

- Light, dark, and system appearance
- Selectable reading fonts, including OpenDyslexic
- Seven font size and spacing levels from Extra Tiny through Extra Huge
- Independent Greek and Hebrew font size and spacing overrides
- Red-letter display for supported translations
- Native, native plus synthetic, or no section headings
- Optional verse numbers
- Paragraph or verse-by-verse layout
- Optional footnote markers
- Psalm superscriptions and other supported section types

KJV and ASV can use section headings synthetically inserted from BSB. Footnote markers open their content without leaving the passage.

### Immersive Reading

The Bible remains the primary screen. Toolbars move out of the way while scrolling down and return when scrolling up.

Users can:

- Swipe the Bible left or right to change chapters
- Tap a verse to select it
- Tap additional verses to extend a verse selection
- Long-press a word to select it
- Continue dragging after a long-press to select a phrase
- Copy verses or selected text

## Navigation

Tapping the main toolbar opens the chapter navigation page.

### Book

- Lists all Bible books
- Accepts typed filtering and fuzzy matching
- Advances to Chapter when a typed book is disambiguated and followed by a space

### Chapter

- Lists the chapters available for the selected book
- Accepts numeric filtering
- Opens the selected chapter by tap or keyboard submission

### Translation

- Opens a selector containing the user's active Bibles
- Changes the current Bible without leaving navigation

### Recents and Bookmarks

The navigation page displays:

- Bookmarked chapters
- Up to four other recent reading positions, because the five-position history includes the current position

Recent positions can be removed individually.

### In-Session Undo and Redo

- Swipe right on the main toolbar to go back through hard navigation.
- Swipe left on the main toolbar to go forward again.

This history includes navigation from chapter search, search results, cross-references, commentary links, dictionary links, lexicon links, reading plans, and similar passage navigation. It preserves scroll position where available and resets the redo stack after new navigation.

## Contextual Toolbars

Lux has three configurable toolbar contexts. Each toolbar has pinned shortcuts, an overflow menu, and a configurable long-press shortcut.

Toolbar presets configure all three contexts at once:

- Reader
- Note-taker
- Studier

Applying a preset replaces the current shortcuts. Users can customize each toolbar afterward.

### Main Toolbar

The main toolbar appears when no Bible selection is active. Available shortcuts are:

- Audio
- Bookmark
- Study
- Compare
- Interlinear
- Commentary
- Cross References
- Add Study Panel
- Switch Bible
- Search
- Resources
- Dictionary
- Lexicon
- Bible Plans
- Theme & Layout

The main overflow menu also provides Settings.

### Verse Selection Toolbar

The verse toolbar appears after one or more verses are selected. Available shortcuts are:

- Study
- Compare
- Interlinear
- Commentary
- Cross References
- Annotate
- Highlight
- Copy

Long-pressing an existing verse selection invokes the configured verse-selection long-press action.

### Text Selection Toolbar

The text toolbar appears after a word or phrase is selected. Available shortcuts are:

- Annotate
- Highlight
- Interlinear
- Search
- Copy

The Search shortcut opens search with the selected text and immediately runs it. Text-selection Interlinear is available when reading BSB or KJV.

Long-pressing an existing text selection invokes the configured text-selection long-press action.

## Study Menu

The Study action groups:

- Compare
- Interlinear
- Commentary
- Cross References

These tools can be opened as temporary bottom sheets. Supported tools can also be pinned into a persistent study panel.

## Compare

Compare displays the selected chapter, verses, or passage in every active Bible, in the order configured on the Bibles page.

- Local and online Bibles are supported.
- Testament-limited Bibles show an unavailable message for passages they do not contain.
- A Compare study panel can pin one selected parallel Bible beside the reading text.

## Interlinear

Interlinear provides a lexical breakdown based on BSB or KJV.

It can show:

- The translated word or phrase
- Its Greek or Hebrew inflection
- Transliteration
- Strong's number
- Morphology
- The original word order

Users can switch between forward and reverse interlinear direction. Tapping a Strong's entry opens its lexical details and usage.

Entry points include:

- Main toolbar for the current chapter
- Verse toolbar for selected verses
- Text toolbar for a selected word or phrase in BSB or KJV
- Interlinear study panel

When a non-study Bible is active, chapter and verse interlinear use the user's most recently selected BSB or KJV study Bible.

## Commentary

Lux bundles:

- Matthew Henry
- John Calvin
- Jamieson-Fausset-Brown

Commentary can be opened for a chapter or verse selection. It also includes available book introductions.

Users can:

- Choose which commentaries are active
- Reorder active commentaries
- Swipe between commentaries in the temporary sheet
- Pin a specific commentary as a study panel
- Open Scripture links in commentary as passage previews

## Cross References

Cross-references are powered by OpenBible data.

- Available for a chapter or verse selection
- Results are combined and ranked for multi-verse selections
- Tapping a result opens a passage preview without changing the main Bible
- The preview can be moved into the main Bible when the user wants to continue there
- Cross-references can be pinned as a study panel

When an online Bible is active, cross-reference previews use the user's study Bible to avoid repeated online requests.

## Search

Search supports words, ordered phrases, and Strong's numbers such as `H2452`.

### Scope

- A local active Bible is searched directly.
- When an online Bible is active, the user's most recently selected BSB or KJV study Bible is searched.
- Strong's-number searches use the study Bible.
- Search does not search multiple Bibles simultaneously.

### Filters

Search can be limited to:

- Old Testament
- New Testament
- The current book
- One or more selected books

### Results

- Matching text or Strong's occurrences are emphasized.
- A matching Strong's entry appears above Strong's search results.
- A matching Easton's Bible Dictionary entry appears above word-search results.
- Tapping a result opens a passage preview.
- The preview can be moved into the main Bible.
- The five most recent search queries are retained and can be removed individually.

Search can be opened from the main toolbar or prefilled from a text selection.

## Resources

The Resources action opens:

### Dictionary

- Easton's Bible Dictionary
- Alphabetical browsing
- Prefix search by people, places, and topics
- Scripture links that can open passage previews or navigate to the Bible

### Lexicon

- Strong's Greek and Hebrew entries
- Search by Strong's number
- Greek or Hebrew language filtering
- Definitions, derivations, related words, and available verse usage
- Scripture navigation from word usage

The Dictionary and Lexicon are also available as independent main-toolbar shortcuts.

## Study Panels

Study panels stay visible while the user reads and follow the currently visible verses or active selection.

Available panel types are:

- Compare with a selected Bible
- Forward or reverse Interlinear
- A selected Commentary
- Cross References
- Notes from visible annotations

Users can:

- Open multiple panels
- Swipe between panels
- Close panels individually
- Resize bottom panels
- Keep panels open across navigation and app sessions

On narrow layouts, panels dock below the Bible. On wide layouts, they appear to its right. The onboarding checklist and Audio Bible use the same swipeable panel area.

## Audio Bible

Audio is available for BSB and KJV and requires an internet connection.

It supports:

- Streaming the current chapter
- Play and pause
- Ten-second rewind and fast-forward
- Scrubbing within the chapter
- Playback speeds of 0.7x, 1x, 1.2x, 1.5x, 1.7x, and 2x
- Sleep timers
- Background playback
- System and notification playback controls
- Persisted playback preferences

When the current Bible has no audio, Lux offers to switch to the user's most recently selected audio-enabled Bible.

## Annotations

Annotations can be attached to:

- One or more whole verses
- A selected word or phrase

Each annotation has:

- A highlight style
- An optional note
- An optional notebook
- Its creation time

### Highlight Styles

Styles support:

- Color highlights
- Straight underlines
- Squiggly underlines
- Custom labels
- Reordering

Users can create, edit, reorder, and remove styles. When changing or deleting a style, Lux lets the user decide how existing annotations should be handled.

The quick Highlight shortcut applies the most recently used style and notebook. A success message offers immediate editing without leaving the passage.

### Notebooks

Users can:

- Create named, colored notebooks
- Reorder notebooks
- Hide or show a notebook's annotations in the Bible
- Browse the annotations in a notebook
- Move annotations between notebooks

Annotations without an assigned notebook belong to the permanent Default notebook. When deleting a notebook, its annotations can be deleted or retained in Default.

### Annotation Management

The Annotations page supports:

- Sorting by most recent or canonical location
- Filtering by notebook
- Filtering by highlight style
- Filtering to annotations with or without notes
- Filtering by testament or one or more books
- Editing and deleting annotations
- Opening an annotation in a passage preview
- Moving the preview into the main Bible

Annotation notes are visible from the Bible and can be edited directly. Note text is not currently searchable.

## Bookmarks

Users can:

- Bookmark chapters
- Give bookmarks a custom name and color
- Open bookmarks from navigation
- Reorder bookmarks
- Edit or delete bookmarks

A bookmark can follow the user's reading position as they move between adjacent chapters. Bookmark folders and tags are not available.

## Bible Reading Plans

Lux includes multiple whole-Bible and focused reading plans from several sources.

Users can:

- Filter available plans by Old Testament, New Testament, or whole-Bible scope
- Filter plans by focused or comprehensive type
- Review a plan's description, source, duration, and daily readings
- Follow more than one plan at a time
- Reorder active plans
- Open any previous or current day
- Mark individual passages or review days complete
- Track progress for each plan
- Stop a plan and remove its progress
- Finish a completed plan

Daily passages open in a focused reading flow that retains access to normal Bible selection and study behavior.

## Settings

Settings is organized around:

### Customize

- Theme & Layout
- Bibles
- Commentaries

### Toolbars

- Toolbar Presets
- Main Toolbar
- Verse Selection
- Text Selection

### Your Content

- Annotations
- Notebooks
- Highlight Styles
- Bookmarks

### Community

- Discord
- Instagram

### Support Lux

- Rate Lux through the platform store
- Join Discord to share feedback

### Help

- Restart Get Started
- Reset contextual tutorials

### About

- App version
- Open-source and content licenses

## Get Started and Tutorials

New users see a Get Started checklist that teaches:

- Cross-references
- Verse annotations
- Word search
- Switching Bibles
- Chapter navigation
- Toolbar undo
- Swiping between chapters
- Study panels
- Toolbar customization
- Bible reading plans

The checklist can be skipped and restarted from Settings. Separate contextual tutorial banners can also be reset.

## Current Product Limitations

- No accounts
- No cross-device sync or cloud backup
- No user-data export
- No full-text search of annotation notes
- No complete history page
- No bookmark folders or tags
- No offline audio downloads
