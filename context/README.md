# Lux Bible Context

These files provide product and technical context for Lux Bible. They describe the upcoming release represented by the current working tree, even when the public App Store or Google Play release is older.

## Sources of Truth

| Question | Source |
| --- | --- |
| What is Lux, who is it for, and what principles guide it? | [`product.md`](product.md) |
| What can users currently do in the app? | [`features.md`](features.md) |
| How is the app built, where does its data come from, and what requires a connection? | [`technical.md`](technical.md) |
| What might be built later? | [`roadmap.md`](roadmap.md) |
| What metadata and copy are pending for the Apple App Store? | [`appstore.md`](appstore.md) |
| What metadata and copy are pending for the Google Play Store? | [`play_store.md`](play_store.md) |

The source code remains authoritative for implementation details. If the implementation and these files disagree, verify the intended behavior and update the relevant context file.

## Status Conventions

- Content in `features.md` is implemented in the current working tree and intended for the upcoming release.
- Content in `roadmap.md` is exploratory. It is not a commitment or scheduled work.
- The store files contain pending metadata and copy. They do not necessarily match the currently published listings.
- Product principles describe the intended direction of Lux, even when a future decision could revise them.

## Maintenance

- Keep strategy and positioning in `product.md`, not in the feature specification.
- Keep user-visible behavior in `features.md`, not in the technical reference.
- Keep implementation constraints and external service boundaries in `technical.md`.
- Move a roadmap item into `features.md` only after it is implemented in the working tree.
- Update store copy separately. Product or feature documentation changes do not automatically authorize changes to the store files.
- Prefer links between files over repeated descriptions.