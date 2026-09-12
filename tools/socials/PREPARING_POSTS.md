# Preparing pending Lux posts

Use this guide when asked to prepare a Lux social post from existing media or to package newly created content for publishing. The deliverable is a local `socials/pending/<post-id>/` folder with `post.yaml` and its media, inspected locally before handover. Preparing a post does not authorize uploading or publishing it.

## Read the relevant sources

Read the repository’s `AGENTS.md` and `context/README.md`, then `context/bible/README.md`. Use `context/bible/product.md` for Lux’s voice and positioning, and `context/bible/features.md` plus current source code for product claims. Use plain copy without em-dashes. Do not present exploratory roadmap work as an available feature.

Read [README.md](README.md) for the maintained metadata schema and command, [post.example.yaml](post.example.yaml) for the video starting point, and [PROVIDERS.md](PROVIDERS.md) for platform differences. The schema and validators in `lib/post.dart` and `lib/media.dart` remain authoritative. Do not add fields the command does not support.

For Bible interpretation or verse-study content, use the available `verse-study` skill to ground analytical claims in attributed sources. For new Lux videos, use the appropriate available Lux video skill and the `videos/` component workflow. Packaging already prepared media does not require regenerating it.

## Build the folder

Use a descriptive, explicit post ID containing letters, digits, hyphens or underscores, beginning with a letter or digit. Check both pending and posted for a collision before creating the folder. Do not overwrite an existing post or modify a posted source as part of a new preparation request.

Place media inside the post folder and use relative paths in YAML. Copy approved source assets into this folder so it is self-contained; do not depend on symlinks to renders elsewhere. Keep render project files in their existing video workflow. `socials/` is gitignored, including its metadata and licensed media.

For a video, copy [post.example.yaml](post.example.yaml), replace its copy, and supply `video.mp4`. Omit `cover` if no cover is available. Prefer 1080 x 1920 H.264 MP4, 30 fps and AAC audio for broad compatibility. For a video targeting all four platforms, 3 to 60 seconds is a useful starting envelope, subject to the maintained provider guidance and validation. Preserve appropriately licensed source music; no trending-audio handoff is needed.

For a carousel, set `media` to an ordered image list:

```yaml
media:
  images:
    - 01.jpg
    - 02.jpg
    - 03.jpg
```

Use the intended first image as the cover. TikTok and Instagram support photo posts; Facebook receives a multi-image Page feed post whose display can differ. Exclude YouTube from the suggested destination command. A separately prepared YouTube video needs its own post folder. Do not silently create a slideshow video. For a photo-only post, remove any unused video/cover paths.

## Write the effective copy and disclosures

Supply `title`, `description`, optional `hashtags`, and `pinnedComment` for every post. Write a specific, open-ended question tied to the post that invites readers to share their experience or perspective. Keep it natural and avoid generic engagement bait. The command appends hashtags to the description, so avoid putting the same hashtags in both fields. All destinations share this copy and media. Do not add `platforms` or settings to YAML. Omit or use `null` for an unused cover/comment.

A title is published separately on YouTube and TikTok photo posts. On TikTok videos and Instagram/Facebook requests it is a local label; the caption is the published copy. Do not rely on the title to convey essential information on those destinations.

The command defaults to public visibility, AI disclosure off, comments enabled, TikTok duet/stitch off, own-brand Lux promotional content, and YouTube not made for kids. Review whether these defaults fit the actual post. Use `--ai` in the suggested publishing command when AI media disclosure is needed. AI disclosure reflects the media, not merely whether an agent assisted with captions. If an important classification is unclear, ask the user before treating the post as ready. Content requiring different privacy, commercial or child-directed classifications should use native publishing. Running the publishing command authorizes immediate publication with these defaults.

Provider credentials belong in the private `tools/socials/.env`, automatically loaded by the command. Use `.env.example` as its template; do not read or print the private file while preparing content. Never put credentials or stored approval/consent flags into metadata. Do not add scheduling fields, a delivery ledger, or a `state.json`. TikTok appends `pinnedComment` after the description with a blank line, before hashtags; it does not create or pin a separate comment. YouTube creates the comment after delivery and asks for manual pinning. Instagram and Facebook print and auto-copy the comment after successful delivery for manual posting and pinning where available. For videos, `coverTimestampMs` selects a frame for TikTok and Instagram Reels. It cannot be combined with `cover`. YouTube Shorts and Facebook ignore the timestamp. Read the maintained provider notes before promising either behavior.

## Inspect and hand over

There is no preview mode. Do not run `bin/publish.dart` to validate prepared content: it immediately uploads and publishes without confirmation.

Inspect the media locally with `ffprobe` and image/video viewers. Check the metadata against `Post.load` / `Post.prepare`, and use `MediaInfo.read` plus `getValidation` in a temporary local Dart runner if automated offline validation is needed. Run that runner from `tools/socials` and remove it afterward. These library calls do not contact providers. Review copy, image order, dimensions, duration, encoding and destination warnings. Use YAML literal blocks (`|-`) for multiline descriptions; TikTok gets an experimental non-breaking space on double-newline separator lines, but may still flatten line breaks downstream. Fix hard errors for intended destinations and report remaining limitations.

Hand over the absolute post-folder path, intended destinations, unresolved limitations, and exact publishing command, such as `socials <post-id>` or `socials <post-id> --platform=tiktok,instagram,facebook`. Instagram Story sharing is handled manually after publication.

Preparing content does not authorize publishing. Do not run the command or move pending to posted during preparation. On a publishing run, the command automatically moves the folder only when all requested destinations succeed. Partial failures retain the folder. Check dashboard and native-account status before retrying uncertain delivery.
