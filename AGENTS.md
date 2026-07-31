# Lux

Before making product-facing changes to Lux Bible, read `context/README.md`, then `context/bible/README.md` and the relevant files it links to.

- Product vision, audience, positioning, and principles: `context/bible/product.md`
- Current user-facing behavior: `context/bible/features.md`
- Architecture, data, and platform constraints: `context/bible/technical.md`
- Exploratory future work: `context/bible/roadmap.md`
- Pending App Store metadata and copy: `context/bible/appstore.md`
- Pending Google Play metadata and copy: `context/bible/play_store.md`

Treat the current source code as authoritative for implementation details. The context describes the intended product behavior of the upcoming release, which can include completed work that has not reached the public stores yet.

When a change makes the context inaccurate, update the relevant context file in the same change. Link to another context file instead of duplicating its content.

Run component commands from their own directories. The root is not a Flutter or Node project.
