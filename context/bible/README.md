# Lux Bible Context

These files provide product and technical context for Lux Bible. They describe the upcoming release represented by the current working tree, even when the public App Store or Google Play release is older.

## Sources of Truth

| Question | Source |
| --- | --- |
| What is Lux, who is it for, and what principles guide it? | [`product.md`](product.md) |
| What can users currently do in the app? | [`features.md`](features.md) |
| How is the app built, where does its data come from, and what requires a connection? | [`technical.md`](technical.md) |
| What might be built later? | [`roadmap.md`](roadmap.md) |
| What metadata, copy, and release notes are pending for the Apple App Store? | [`apps/bible/ios/fastlane/metadata/`](../../apps/bible/ios/fastlane/metadata/) |
| What metadata, copy, and release notes are pending for the Google Play Store? | [`apps/bible/android/fastlane/metadata/android/`](../../apps/bible/android/fastlane/metadata/android/) |

The source code remains authoritative for implementation details. If the implementation and these files disagree, verify the intended behavior and update the relevant context file.

## Status Conventions

- Content in `features.md` is implemented in the current working tree and intended for the upcoming release.
- Content in `roadmap.md` is exploratory. It is not a commitment or scheduled work.
- The store directories use fastlane's `deliver` and `supply` metadata layout: one plain-text file per store field, in a folder per store locale. They contain pending metadata, copy, and release notes, and do not necessarily match the currently published listings. Apple's `release_notes.txt` describes the upcoming version, while Google Play keeps one `changelogs/<build>.txt` per build number. `apps/bible/tool/release/listings.dart` pushes them with fastlane, text only, and `--pull` copies the live listings over the tracked files so `git diff` shows what differs. Google Play release notes attach to the build's release on the internal track, so push them after `deploy.dart` has uploaded that build.
- Product principles describe the intended direction of Lux, even when a future decision could revise them.

## Maintenance

- Keep strategy and positioning in `product.md`, not in the feature specification.
- Keep user-visible behavior in `features.md`, not in the technical reference.
- Keep implementation constraints and external service boundaries in `technical.md`.
- Move a roadmap item into `features.md` only after it is implemented in the working tree.
- Update store copy separately. Product or feature documentation changes do not automatically authorize changes to the store files.
- Prefer links between files over repeated descriptions.
