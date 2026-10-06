# Lux

Before making product-facing changes to Lux Bible, read `context/README.md`, then `context/bible/README.md` and the relevant files it links to.

- Product vision, audience, positioning, and principles: `context/bible/product.md`
- Current user-facing behavior: `context/bible/features.md`
- Architecture, data, and platform constraints: `context/bible/technical.md`
- Exploratory future work: `context/bible/roadmap.md`
- Pending App Store metadata, copy, and release notes: `apps/bible/ios/fastlane/metadata/`
- Pending Google Play metadata, copy, and release notes: `apps/bible/android/fastlane/metadata/android/`

Treat the current source code as authoritative for implementation details. The context describes the intended product behavior of the upcoming release, which can include completed work that has not reached the public stores yet.

When a change makes the context inaccurate, update the relevant context file in the same change. Link to another context file instead of duplicating its content.

Run component commands from their own directories. The root is not a Flutter or Node project.

## Shared Code

Lux Bible is one app in a product family. Check the shared packages before treating a change as app-only:

- `packages/lux` contains shared Bible models and providers, plus the product-neutral passage renderer, selection logic, and passage preview.
- `packages/style` contains the shared visual language and widgets, including `StyledListItem`, `StyledSheet`, and `StyledModulePage`.
- User-facing strings live in `packages/lux/lib/i18n/{en,nl,de,ru}.i18n.json` with generated Dart alongside; keep every language in sync.
- Adding a language also touches `Language` in `apps/bible/lib/models/user/language.dart`, timeago messages in `apps/bible/lib/main.dart`, iOS `CFBundleLocalizations` (Runner and widget `Info.plist`), `knownRegions` in `project.pbxproj`, the widget's `Localizable.xcstrings`, Android `res/xml/locale_config.xml` and `res/values-<lang>/`, and the fastlane metadata folders.
- `apps/memory` is the exploratory Lux Memory app and the reference for shared patterns.
- `tools/content` can't import Flutter-dependent app files (anything importing `package:flutter`), so keep values the generators need, like link prefixes, on pure-Dart models. `lux/i18n` is pure Dart and fine to import.

Never hand-edit generated `*.g.dart` or `*.freezed.dart` files.

## Verifying Changes

There is no CI, and `apps/bible/test` is empty. Static analysis and formatting are the current gate.

Never interact with an Android emulator or iOS simulator yourself. Do not launch apps, install builds, send intents, tap or inspect screens, collect logs, or use `adb`, `xcrun simctl`, or UI automation against an emulator or simulator. When device verification is needed, ask me to test it and provide exact steps and the expected result.

The Flutter SDK is outside this workspace, so `flutter` and the `dart` wrapper cannot write its cache and fail under the default sandbox. Use the SDK's direct binary with a workspace-local `HOME` instead:

```sh
FLUTTER_ROOT="$(dirname "$(dirname "$(command -v flutter)")")"
HOME="$PWD/.tmp/dart-home" "$FLUTTER_ROOT/bin/cache/dart-sdk/bin/dart" analyze <path>
HOME="$PWD/.tmp/dart-home" "$FLUTTER_ROOT/bin/cache/dart-sdk/bin/dart" format <path>
```

`flutter analyze`, `flutter test`, and `flutter run` additionally write the SDK lockfile and require escalated full access.

When preparing local Lux social posts, read [`tools/socials/PREPARING_POSTS.md`](tools/socials/PREPARING_POSTS.md).

For stats on socials, the App Store, Google Play, Google Analytics (app and website), or Crashlytics, read the newest `stats/<yyyy-MM-dd>/` snapshot first. If it's more than a few days old or lacks what you need, run `dart run bin/collect.dart` from `tools/stats` (see its README). Query the sources directly only for what a snapshot doesn't cover, such as GA funnels.

When working on short-form reels, read [`tools/reels/CONTEXT.md`](tools/reels/CONTEXT.md) for the
vision and current state, and [`tools/reels/README.md`](tools/reels/README.md) for usage. Videos are
defined as Dart files there; rendering is pure Dart and the Flutter app is only a preview wrapper.

## Improving Agent Context

After finishing a task, consider whether this file, the `context/` files, a skill, or a tool README should change so the next agent has an easier time. Good candidates:

- A relevant file, command, or workflow that took real searching to find and is likely to come up again.
- An instruction here or in `context/` that was missing, outdated, or misleading.
- A repeated multi-step process that would work better as a skill or a documented script.

Don't make these edits on your own. At the end of your response, briefly propose the specific change and where it would go, and ask whether to make it. Skip the suggestion when nothing learned would generalize beyond the current task, and keep proposed additions short so this file stays easy to scan.
