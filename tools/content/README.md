# Lux content tools

This Dart package generates the Lux Bible runtime assets in [`apps/bible/assets/`](../../apps/bible/assets/). It reads the authoritative inputs in [`content/sources/`](../../content/sources/) and depends on the app’s existing Bible models without extracting a shared package prematurely.

Run all Dart commands from this directory. The scripts locate the repository root themselves, so their input and output paths do not depend on the shell working directory.

```sh
flutter pub get
dart run bin/generate_bsb_json.dart
dart run bin/generate_kjv_json.dart
dart run bin/generate_asv_json.dart
dart run bin/generate_osis_json.dart
dart run bin/generate_bible_plans_json.dart
dart run bin/generate_commentary_json.dart
dart run bin/generate_easton_json.dart
dart run bin/generate_strongs_json.dart
```

`generate_navigators_5x5x5_source.dart` writes its normalized input file into `content/sources/reading_plans/` before `generate_bible_plans_json.dart` reads it.

The Python SWORD pipeline lives in [`python/sword/`](python/sword/). It reads and writes under `content/sources/`; see each script’s usage text before running it. Downloaded SWORD modules and source downloads remain ignored.
