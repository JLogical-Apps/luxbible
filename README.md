# Lux

Lux is a product family for focused Bible reading and study. This repository contains the Lux Bible app, its marketing website, content pipeline, and Scripture service.

## Repository layout

- [`apps/bible/`](apps/bible/) contains the Flutter application and its release tooling.
- [`apps/memory/`](apps/memory/) contains the Lux Memory Flutter application.
- [`packages/lux/`](packages/lux/) contains shared Bible models, application infrastructure, behavior widgets, and utilities.
- [`packages/style/`](packages/style/) contains the shared Lux visual language and Flutter widgets.
- [`websites/bible/`](websites/bible/) contains the Lux Bible marketing site.
- [`services/scripture/`](services/scripture/) contains the Cloudflare Worker used for licensed Bible-text requests.
- [`content/sources/`](content/sources/) contains authoritative Bible, commentary, dictionary, and reading-plan source files.
- [`tools/content/`](tools/content/) contains generators that turn source content into app runtime assets.
- [`context/`](context/) contains product context, organized by product.

The repository root is a Dart pub workspace for the Flutter apps, shared packages, and content tools. Run dependency resolution at the root and component commands from the relevant component directory.

## Common commands

```sh
dart pub get

cd apps/bible
flutter analyze

cd ../memory
flutter analyze

cd ../../packages/lux
flutter analyze

cd ../../packages/style
flutter analyze

cd ../../tools/content
dart run bin/generate_bsb_json.dart

cd ../../services/scripture
npm install
npm run check

cd ../../websites/bible
npm install
npm run build
```

See each component’s README for its full workflow. The product documentation index is [`context/README.md`](context/README.md).
