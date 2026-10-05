# Lux content tools

This Dart package generates the Lux Bible runtime assets in [`apps/bible/assets/`](../../apps/bible/assets/). It reads the authoritative inputs in [`content/sources/`](../../content/sources/) and depends on the app’s existing Bible models without extracting a shared package prematurely.

Resolve workspace dependencies from the repository root, then run generator commands from this directory. The scripts locate the repository root themselves, so their input and output paths do not depend on the shell working directory.

```sh
cd ../..
dart pub get
cd tools/content
dart run bin/generate_bsb_json.dart
dart run bin/generate_msb_json.dart
dart run bin/generate_csb_json.dart
dart run bin/generate_kjv_json.dart
dart run bin/generate_asv_json.dart
dart run bin/generate_web_json.dart
dart run bin/generate_osis_json.dart
dart run bin/generate_bible_plans_json.dart
dart run bin/generate_commentary_json.dart
dart run bin/generate_articles_json.dart
dart run bin/generate_dictionary_json.dart
dart run bin/generate_maps_json.dart
dart run bin/generate_strongs_json.dart
dart run bin/generate_audio_bible_timings_json.dart
dart run bin/generate_verse_of_the_day.dart
dart run bin/generate_website_bsb_json.dart
```

Bible generators write one minified runtime asset per book under `assets/translations/<translation>/`, using USX book codes such as `GEN.json`. The book type is derived from the asset path and is not repeated inside the JSON.

`generate_commentary_json.dart` writes the same per-book layout under `assets/commentary/<commentary>/`. Commentary
assets preserve book introductions, Matthew Henry chapter outlines, ordered verse-linked sections, normalized paragraph
presentation, and source tables.

`generate_articles_json.dart` writes Tyndale's people profiles and theme articles as one minified list each to
`assets/people/tyndale.json` and `assets/themes/tyndale.json`. Each article's links to dictionary entries on the same
subject come from the hand-curated `content/sources/commentary/tyndale/dictionary_links.json`, and the generator fails
on any article or dictionary ID it doesn't recognize. Tyndale's link, book-code, and formatting conversion
lives in [`lib/tyndale.dart`](lib/tyndale.dart) and is shared with the commentary generator, so after changing it,
regenerate the commentary too and confirm its assets are unchanged unless the change was meant to affect them.

`generate_dictionary_json.dart` writes the Tyndale Open Bible Dictionary from `content/sources/dictionary/tyndale/` to
`assets/dictionary/tyndale.json`, with its text boxes, charts, and map references inline, and prints the links it kept
as plain text because they cannot be resolved. It also uses [`lib/tyndale.dart`](lib/tyndale.dart).

The dictionary's maps are curated by hand in `content/sources/dictionary/tyndale/maps.json`: one entry per map image,
with its title, the Maps.xml entry names that use the image as aliases (dictionary articles embed maps by these names),
a caption checked against the image, and the OSIS passages it illustrates. `generate_maps_json.dart` validates the
passages and writes `assets/maps/tyndale.json`. The images in `assets/maps/tyndale/` come from the map PDFs through
[`python/maps/rasterize_tyndale_maps.py`](python/maps/rasterize_tyndale_maps.py), whose docstring lists its venv setup;
rerun it only when the PDFs or the ids in `maps.json` change.

`generate_audio_bible_timings_json.dart` validates their canonical chapter and verse coverage, removes the verse text and source metadata, and writes one minified runtime asset per Audio Bible.

`generate_website_bsb_json.dart` writes the BSB as plain verse text to [`websites/bible/data/bsb.json`](../../websites/bible/data/bsb.json), keyed by OSIS book ID with one array of verses per chapter. The marketing site reads it to render passage share previews. Omitted verses are empty strings so array positions stay aligned with verse numbers.

`generate_navigators_5x5x5_source.dart` writes its normalized input file into `content/sources/reading_plans/` before `generate_bible_plans_json.dart` reads it.

Raw SWORD modules and downloaded archives belong under `content/sources/sword/` and remain ignored. Generators read committed, extracted inputs elsewhere in `content/sources/` so runtime assets do not depend on local SWORD downloads.

The MSB sources in `content/sources/bibles/msb/` are the `MSB_strongs_usx.zip` files from a [bsb2usfm release](https://github.com/BSB-publishing/bsb2usfm/releases), renamed to their book codes. They keep their Strong's numbers, but MSB lacks the word positions and transliterations of a full study Bible, so it is generated as a reading text. The WEB is the Classic edition, prepared once from eBible.org's USFM by [`python/web/prepare_web.py`](python/web/prepare_web.py), whose docstring lists its setup and download steps, including a venv since global `pip install` is blocked on Homebrew Python. The WEB has no section headings of its own, so `generate_web_json.dart` inserts the BSB's through [`lib/src/section_headings.dart`](lib/src/section_headings.dart), leaving the WEB source untouched. The KJV and ASV sources already contain the BSB headings.

The licensed CSB DBL bundle belongs under `content/sources/bibles/csb/`. Both that source directory and the generated JSON files under `apps/bible/assets/translations/csb/` remain ignored so the licensed text is available to local release builds without being distributed through GitHub.

`generate_verse_of_the_day.dart` reads the committed Daily Light extraction at `content/sources/verse_of_the_day/daily_light.json`, validates all morning and evening OSIS selections and complete leap-year calendar coverage, then writes the first morning passage for each date to `apps/bible/assets/verse_of_the_day.json`. The source extraction records the official CrossWire Daily module download and extraction steps.

## Adding a bundled translation

1. Put the source under `content/sources/bibles/<name>/`, as one USX file per book or OSIS files for `generate_osis_json.dart`. Raw downloads go in `content/sources/sword/`. If the source needs a one-time conversion, add a script under `python/<name>/` whose docstring lists the setup and download steps.
2. Add a generator in `bin/`, or add the translation to `generate_osis_json.dart`. Run it and compare each verse's text in the generated JSON against the source.
3. Add the value to `BibleTranslation` in `packages/lux/lib/src/models/bible/bible_translation.dart`, inside its language group. Language groups are alphabetical by English name, and the order within a language sets the default Compare order. Fill in `title`, `fullName`, `source`, `bibleLanguage`, and whichever of `copyright`, `testament`, `expirationDate`, and the feature flags apply.
4. For a new language, add it to `BibleLanguage` alphabetically, add its name to every `packages/lux/lib/i18n/*.i18n.json` file, and map it in `BibleLanguageAppExtensions` in `apps/bible/lib/models/user/language.dart` when Lux has a matching app language.
5. Declare `assets/translations/<name>/` in `apps/bible/pubspec.yaml` and add a license entry to `apps/bible/lib/licenses.dart`.
6. Update the Bible Library in `context/bible/features.md`, and the bundled list, capability lists, and any versification notes in `context/bible/technical.md`.
7. Run `dart analyze` on `packages/lux`, `apps/bible`, and `tools/content`.
