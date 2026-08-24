# Feature Specification

This file describes user-facing behavior implemented in the current working tree and intended for the upcoming release.

## Supported Platforms

- iPhone
- iPad
- Android

Lux uses a single reading area with optional study panels. Panels appear below the Bible on narrower layouts and to its right when the available width is at least 700 logical pixels.

## Languages

Lux supports English, Dutch, and Russian. By default, it follows the device language when that language is supported and otherwise uses English. More > Settings > Language opens the device's native app-language setting, where available. Android 13 and later opens Lux's Language screen directly; iOS opens Lux's app settings, which include its Language control.

The selected language controls Lux's interface, Bible book names, reference formatting, reading-plan metadata, study terminology, and other app-authored text. It does not translate Bible text, translation names, user-created content, imported study-resource bodies, or legal copy.

## Notifications

More > Settings > Push Notifications always includes a Verse of the Day card with the same sun icon used by the main action. Its subtitle is either No notification or the localized daily time, and its Add or Edit button opens the time picker. Editing an existing reminder includes a delete button that asks for confirmation before clearing it. The page also lists every active Bible plan in the user's plan order, including plans without reminders. Each plan retains its thumbnail and shows the same No notification or localized-time subtitle with the same Add or Edit behavior. Removing a reminder does not remove the Verse of the Day discovery answer or any Bible plan progress.

Verse of the Day is available from the main toolbar and its overflow menu. It previews the bundled passage for the current date with the selected translation, falling back to the selected Study Bible if that passage cannot be loaded. After that preview closes for the first time, Lux asks whether to add a daily reminder. It never asks again after a response or after a reminder is removed. Verse of the Day reminders use the current selected translation with that per-passage fallback. The schedule and bundled source passages work offline, while online translations use cached text when available and otherwise require a connection. Lux schedules a rolling fourteen-day set of dated local notifications so each notification contains that day's actual verse and opens that originally scheduled date when tapped.

Bible plan reminders are also scheduled as dated local notifications. Completing a plan day cancels any remaining reminder for that local date and schedules the next reminder no earlier than the following day.

Saving any reminder asks for notification permission only when needed. If app notifications are disabled, Lux directs the user to system settings and preserves all reminder settings. Android manages Verse of the Day and Bible Plan Reminders through separate channels: a disabled channel affects only its own controls and points to system notification settings, while the other reminder type remains available. Lux reconciles saved schedules after a setting change or restart without clearing saved reminder choices.

## Bible Library

### Offline Bibles

- BSB: Berean Standard Bible and the default English Bible
- KJV: King James Version
- ASV: American Standard Version
- SV: Statenvertaling in Dutch
- NLD1939: Petrus Canisiusvertaling 1939 in Dutch
- FOB: Ostervald 1744 in French
- Martin: Bible David Martin 1744 in French
- RVG: Reina Valera Gómez 2010 in Spanish
- LXX: Septuagint, Rahlfs
- TR: Textus Receptus, Stephens 1550
- BYZ: Robinson-Pierpont Byzantine Textform 2005
- SR: Statistical Restoration Greek New Testament
- OSHB: Open Scriptures Hebrew Bible

### Online Bibles

- NASB95
- NIV
- CSB
- NLT
- NKJV
- NRT: New Russian Translation 2010 in Russian
- HTB: Het Boek 2007 in Dutch

Online chapters are cached on the device after they are loaded. A cached chapter remains available without a
connection for fourteen days, after which Lux requires a connection to load it again.

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

For a new or uncustomized Bible list, English activates BSB followed by the other English Bibles, matching the existing default order. Dutch activates SV, the other Dutch Bibles, and then BSB. Russian activates NRT followed by BSB. Changing the app language updates this language-based default list only while the user has not customized their active Bibles. It does not change the currently selected translation.

BSB and KJV are the two study Bibles. LXX and OSHB contain the Old Testament, while TR, BYZ, and SR contain the New Testament.

## Reading Experience

### Display

Lux supports:

- Light, dark, and system appearance
- System accessibility text sizing for interface text, clamped to Lux's designed minimum size
- Selectable reading fonts, including OpenDyslexic
- Seven font size and spacing levels from Extra Tiny through Extra Huge
- Independent Greek and Hebrew font size and spacing overrides
- Red-letter display for supported translations
- Native, native plus synthetic, or no section headings
- Optional verse numbers
- Paragraph or verse-by-verse layout
- Optional footnote markers
- Psalm superscriptions and other supported section types

Bible text uses the closest Lux reading size to the system accessibility text size by default. Users can override it with one of seven independent font size and spacing levels. Lux controls the final Bible text size so its layout, selection, and annotations stay aligned.

Users can pinch Bible text with two fingers to change its font size and spacing.

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

Tapping the main toolbar opens the reference navigation page.

### Book

- Lists all Bible books
- Accepts typed filtering and fuzzy matching
- Advances to Chapter when a typed book is disambiguated and followed by a space

### Chapter

- Lists the chapters available for the selected book
- Accepts numeric filtering
- Opens the selected chapter by tap or keyboard submission
- Advances to Verse when a valid typed chapter is followed by a space

### Verse

- Lists the verses available for the selected chapter
- Accepts numeric filtering
- Opens and selects the chosen verse by tap or keyboard submission
- Returns to chapter or book navigation when either earlier field is selected

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
- Verse of the Day
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

The main overflow menu provides Audio, Bookmark, Study, Verse of the Day, Bible Plans, and More. More opens app customization, content, settings, and community links. Verse of the Day previews the bundled passage for the current date using the selected translation, falling back to the selected Study Bible if its text cannot be loaded. The preview can be moved into the main Bible.

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
Temporary study sheets opened from the main Bible reader provide a pin action that closes the sheet and opens the
corresponding persistent panel. Compare offers the action for each translation, while Interlinear and Commentary
preserve the direction or resource currently selected in the sheet. When a panel is pinned from a verse selection, Lux
clears the selection and scrolls its verses into view after the panel changes the reading area. Study sheets opened
while reading a Bible plan do not offer pin actions.

## Compare

Compare displays the selected chapter, verses, or passage in every active Bible, in the order configured on the Bibles page.

- Local and online Bibles are supported.
- Testament-limited Bibles show an unavailable message for passages they do not contain.
- A Compare study panel pins one selected parallel Bible beside the reading text and links their chapter scrolling.

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

Study panels stay visible while the user reads. Most show the currently visible verses or active selection.

Compare panels are linked reading surfaces. They show the entire current chapter and remain aligned to the top visible
verse in the main Bible. Scrolling either the Bible or the Compare panel moves the other surface to the corresponding
verse.

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
- Verse previews while scrubbing
- Passage scrolling to the selected verse after scrubbing
- Seeking to a verse by tapping it while the audio panel is active
- Playback speeds of 0.7x, 1x, 1.2x, 1.5x, 1.7x, and 2x
- Sleep timers
- Background playback
- System and notification playback controls
- Persisted playback preferences
- Verse-by-verse follow along with automatic scrolling and animated emphasis during playback
- Restarting the current passage when switching between audio-enabled Bibles

Verse 1 is emphasized during chapter introductions, and each later verse receives emphasis 300 milliseconds before its recorded start.

Manually scrolling the passage or selecting a verse or text pauses playback. Starting playback clears the current selection.

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
- Listen through a day's passages with automatic verse following and progress completion
- Adjust reading-plan audio speed or skip backward and forward by ten seconds
- Track progress for each plan
- Set, edit, or delete a daily local notification reminder for each active plan
- Stop a plan and remove its progress
- Finish a completed plan

Daily passages open in a focused reading flow that retains access to normal Bible selection and study behavior.
The chapter-preview action reads "Read In Context" when the assigned passage already covers the full chapter and "Read Entire Chapter" otherwise.
Reading-plan audio starts at the first assigned verse, stops at the final assigned verse, marks the passage complete, and continues to the next incomplete tab. It stops after every passage for the day is complete. Manual scrolling or selecting text pauses playback. A passage whose active Bible does not support audio prompts the user to switch Bibles.
While a reading-plan audio session is active, its full playback controls replace the Next button. The page's top-right stop button closes that session and restores the Next button. Its scrubber is limited to the assigned passage rather than the whole chapter.

Daily plan reminders follow the device's local time and include the plan name plus every passage from the earliest incomplete day. Review days use the localized Review & Reflect label. Completing any plan day suppresses that plan's remaining reminder for the current local calendar day, including when a later day is completed out of order. If no day has been completed today, the reminder uses today's occurrence when its time is still ahead and tomorrow's occurrence after that time has passed. Lux asks for notification permission only when a reminder is saved. If permission is disabled, Lux can open the system settings and completes the attempted save when permission is enabled before returning. A confirmation appears after every successful save. Reminders can appear while Lux is open. Tapping a reminder opens the earliest incomplete passage in its plan, with Bible and Bible Plans remaining behind it in the page history. A Review & Reflect day opens Bible Plans instead. If the plan is no longer active or is complete, the reminder opens Bible Plans safely.

After a user completes a plan day for the first time, Lux asks whether they want a daily reminder if they have not already answered or configured one for that plan. The prompt appears when the Bible Plans page is visible again, including after reading or listening on the focused reading page. Declining or canceling reminder setup resolves the prompt for that plan. Stopping and restarting a plan resets this eligibility with its fresh progress.

## More

More is organized around:

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

### Settings

- Push Notifications
- Language

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

The checklist can be skipped and restarted from More > Help. Separate contextual tutorial banners can also be reset.

## Current Product Limitations

- No accounts
- No cross-device sync or cloud backup
- No user-data export
- No full-text search of annotation notes
- No complete history page
- No bookmark folders or tags
- No offline audio downloads
