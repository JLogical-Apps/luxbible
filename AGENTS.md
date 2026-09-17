# Lux

Before making product-facing changes to Lux Bible, read `context/README.md`, then `context/bible/README.md` and the relevant files it links to.

- Product vision, audience, positioning, and principles: `context/bible/product.md`
- Current user-facing behavior: `context/bible/features.md`
- Architecture, data, and platform constraints: `context/bible/technical.md`
- Exploratory future work: `context/bible/roadmap.md`
- Pending App Store metadata and copy: `context/bible/appstore/`
- Pending Google Play metadata and copy: `context/bible/play_store/`

Treat the current source code as authoritative for implementation details. The context describes the intended product behavior of the upcoming release, which can include completed work that has not reached the public stores yet.

When a change makes the context inaccurate, update the relevant context file in the same change. Link to another context file instead of duplicating its content.

Run component commands from their own directories. The root is not a Flutter or Node project.

## Shared Code

Lux Bible is one app in a product family. Check the shared packages before treating a change as app-only:

- `packages/lux` contains shared Bible models and providers, plus the product-neutral passage renderer, selection logic, and passage preview.
- `packages/style` contains the shared visual language and widgets, including `StyledListItem`, `StyledSheet`, and `StyledModulePage`.
- User-facing strings live in `packages/lux/lib/i18n/{en,nl,ru}.i18n.json` with generated Dart alongside; keep every language in sync.
- `apps/memory` is the exploratory Lux Memory app and the reference for shared patterns.

Never hand-edit generated `*.g.dart` or `*.freezed.dart` files.

## Verifying Changes

There is no CI, and `apps/bible/test` is empty. Static analysis and formatting are the current gate.

The Flutter SDK is outside this workspace, so `flutter` and the `dart` wrapper cannot write its cache and fail under the default sandbox. Use the SDK's direct binary with a workspace-local `HOME` instead:

```sh
FLUTTER_ROOT="$(dirname "$(dirname "$(command -v flutter)")")"
HOME="$PWD/.tmp/dart-home" "$FLUTTER_ROOT/bin/cache/dart-sdk/bin/dart" analyze <path>
HOME="$PWD/.tmp/dart-home" "$FLUTTER_ROOT/bin/cache/dart-sdk/bin/dart" format <path>
```

`flutter analyze`, `flutter test`, and `flutter run` additionally write the SDK lockfile and require escalated full access.

When preparing local Lux social posts, read [`tools/socials/PREPARING_POSTS.md`](tools/socials/PREPARING_POSTS.md).
