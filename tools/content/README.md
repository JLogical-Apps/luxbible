# Lux content tools

This Dart package generates the Lux Bible runtime assets in [`apps/bible/assets/`](../../apps/bible/assets/). It reads the authoritative inputs in [`content/sources/`](../../content/sources/) and depends on the app’s existing Bible models without extracting a shared package prematurely.

Resolve workspace dependencies from the repository root, then run generator commands from this directory. The scripts locate the repository root themselves, so their input and output paths do not depend on the shell working directory.

```sh
cd ../..
dart pub get
cd tools/content
dart run bin/generate_bsb_json.dart
dart run bin/generate_csb_json.dart
dart run bin/generate_kjv_json.dart
dart run bin/generate_asv_json.dart
dart run bin/generate_osis_json.dart
dart run bin/generate_bible_plans_json.dart
dart run bin/generate_commentary_json.dart
dart run bin/generate_easton_json.dart
dart run bin/generate_strongs_json.dart
dart run bin/generate_audio_bible_timings_json.dart
dart run bin/generate_verse_of_the_day.dart
```

Bible generators write one minified runtime asset per book under `assets/translations/<translation>/`, using USX book codes such as `GEN.json`. The book type is derived from the asset path and is not repeated inside the JSON.

`generate_audio_bible_timings_json.dart` validates their canonical chapter and verse coverage, removes the verse text and source metadata, and writes one minified runtime asset per Audio Bible.

`generate_navigators_5x5x5_source.dart` writes its normalized input file into `content/sources/reading_plans/` before `generate_bible_plans_json.dart` reads it.

Raw SWORD modules and downloaded archives belong under `content/sources/sword/` and remain ignored. Generators read committed, extracted inputs elsewhere in `content/sources/` so runtime assets do not depend on local SWORD downloads.

The licensed CSB DBL bundle belongs under `content/sources/bibles/csb/`. Both that source directory and the generated JSON files under `apps/bible/assets/translations/csb/` remain ignored so the licensed text is available to local release builds without being distributed through GitHub.

`generate_verse_of_the_day.dart` reads the committed Daily Light extraction at `content/sources/verse_of_the_day/daily_light.json`, validates all morning and evening OSIS selections and complete leap-year calendar coverage, then writes the first morning passage for each date to `apps/bible/assets/verse_of_the_day.json`. The source extraction records the official CrossWire Daily module download and extraction steps.
