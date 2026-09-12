# Lux social publishing

Run from this independent Dart package, not the repository root. Requires Dart 3.10+ and `ffprobe` plus `ffmpeg` on PATH (install FFmpeg, for example `brew install ffmpeg` on macOS). No Flutter, native developer apps, scheduling, database, or persistent delivery state is used. The package uses `args` for CLI parsing, `http` for requests and streamed uploads, `path` for file paths and containment checks, `uuid` for request IDs, `dotenv` for local configuration, and `yaml` for post metadata. It is intentionally outside the Flutter workspace.

```sh
cd tools/socials
dart pub get
dart run bin/publish.dart my-post
dart run bin/publish.dart my-post --platform=tiktok,youtube
dart run bin/publish.dart my-post --posted --platform=tiktok,youtube
```

## Shell shortcut and agent preparation

The `socials` function is defined directly in `~/.zshrc`. It runs this command from its component directory and preserves your current directory. Reload your configuration in an existing shell:

```sh
source ~/.zshrc
```

Then use:

```sh
socials my-post
socials my-post --posted --platform=tiktok,youtube
```

All arguments pass through unchanged. Credentials load automatically from `tools/socials/.env`; exported environment variables take precedence. For future agents preparing content, read [PREPARING_POSTS.md](PREPARING_POSTS.md), also linked from the repository’s `AGENTS.md`.

`--platform` accepts comma-separated values, a separate argument value, or repeated options. `-h` shows generated usage.

Running the command publishes immediately, without confirmation prompts. There is no preview mode or browser launch. Platforms run concurrently, with one updating terminal row each showing bytes sent, validation, publication and delivery status. Redirected output records only status changes. The final summary includes delivery IDs/links, warnings and manual comments.

## Connect accounts and configure credentials

Create a Lux profile in [Zernio](https://zernio.com/) and connect only Lux’s TikTok account and YouTube channel. Verify the Google identity owns the correct channel, including the correct Brand Account where applicable. Create a key in the dashboard API keys page and copy the provider account `_id` values from its account list/dashboard. Zernio’s first two connected accounts include API access for free. Additional account connections across the team can incur charges: [official pricing](https://docs.zernio.com/pricing).

Create a Lux project in [WoopSocial](https://app.woopsocial.com/), connect only Lux’s Instagram **Business or Creator** account and **Facebook Page**, and create a key at [API Access](https://app.woopsocial.com/api-access). Copy the project ID from the project dropdown and the social account IDs from Connect Accounts. Native account/Page IDs are different from provider social account IDs. Free currently includes two social accounts, API access and 1 GB storage: [official pricing](https://woopsocial.com/pricing), [setup instructions](https://docs.woopsocial.com/api-reference/api-onboarding).

Create your private configuration from the template:

```sh
cd tools/socials
cp -n .env.example .env
chmod 600 .env
```

Edit `.env` to fill in your API keys, provider account IDs and WoopSocial project ID:

```dotenv
ZERNIO_API_KEY=your-private-key
ZERNIO_TIKTOK_ACCOUNT_ID=provider-account-id
ZERNIO_YOUTUBE_ACCOUNT_ID=provider-account-id
WOOPSOCIAL_API_KEY=your-private-key
WOOPSOCIAL_PROJECT_ID=lux-project-id
WOOPSOCIAL_INSTAGRAM_ACCOUNT_ID=provider-account-id
WOOPSOCIAL_FACEBOOK_ACCOUNT_ID=provider-account-id
```

The command locates this file relative to the repository, independent of your shell directory. No `export` or shell `source` is needed. `.env` is gitignored; `.env.example` contains only empty template values. Existing exported environment variables take precedence, including empty values. If switching from an old credentials shell file, remove its source line from `.zshrc` and unset stale exports or start a new terminal. An absent `.env` is allowed for environment-only setup. API keys loaded from `.env` are included in diagnostic redaction. Never put credentials into `post.yaml` or tracked files.

The command checks connected accounts before uploading and reports selected identities in the final summary. TikTok creator privacy, interactions and duration/posting limits are checked live. WoopSocial does not expose Page/professional-account type in its account list, so configure the correct Lux account in advance. Reconnect stale accounts in the provider dashboard.

## Prepare a post

Create `socials/pending/<post-id>/post.yaml` and place its source media beside it. `socials/` is gitignored. IDs may contain letters, digits, hyphens and underscores, beginning with a letter or digit. Copy [post.example.yaml](post.example.yaml) as a starting point. Metadata contains shared content only; optional fields can be omitted or cleared with `null` for cover/comment.

- Required: `title`, `description`, and `media`.
- `hashtags`: optional array of words, with or without a leading `#`. Added to the description after a blank line; limits include hashtags.
- `media`: either `video: video.mp4` or `images: [01.jpg, 02.jpg, 03.jpg]`. Images remain ordered. Local tool formats: MP4/MOV/WebM video and JPEG/PNG/WebP image; platform restrictions still apply. No mixed media or automatic image-to-video conversion.
- `cover`: optional relative image path.
- `coverTimestampMs`: optional nonnegative integer video position in milliseconds, strictly before the end. Use either this or `cover`. TikTok uses its native timestamp field; Instagram Reels get a temporary JPEG extracted with FFmpeg. YouTube Shorts and Facebook ignore it and report the limitation.
- `pinnedComment`: discussion comment text. Include a natural, post-specific question in every prepared post. Existing metadata can omit it or clear it with `null`. TikTok appends it after the description with a blank line, before hashtags. YouTube creates it automatically and asks you to pin it manually. Instagram/Facebook print and auto-copy it after successful delivery for manual posting and pinning where available.

All paths must stay inside the post folder, including symlink targets. No absolute paths, traversal, remote media URLs, schedule fields, or hidden consent settings are accepted. All destinations use the same copy and media. YouTube is blocked for an image carousel; exclude it with `--platform=tiktok,instagram,facebook`. To publish a separately prepared video, package it as another post. `platforms` and platform settings are no longer accepted in YAML.

The command derives platform settings for ordinary Lux posts: public TikTok/YouTube visibility, comments enabled, TikTok duet/stitch disabled, own-brand `brand_organic` promotion, and YouTube `madeForKids: false`. AI disclosure defaults to false. Use `socials my-post --ai` when the media requires AI disclosure; it enables TikTok `video_made_with_ai` and YouTube `containsSyntheticMedia`. AI disclosure reflects the media, not merely whether an agent assisted with captions.

Invoking the command authorizes immediate publication with those defaults, including TikTok's required consent fields. Prepare and inspect the content beforehand, ensure the disclosures are accurate, and agree to [TikTok’s Music Usage Confirmation](https://www.tiktok.com/legal/page/global/music-usage-confirmation/en). Own-brand promotion is labeled **Promotional content**. If the account does not support these defaults, or a post needs different privacy, commercial or child-directed classifications, use native publishing.

Write multiline descriptions with YAML `|-`, as in the example. Folded blocks (`>`) and quoted text without explicit newline escapes can flatten paragraphs during parsing. For TikTok only, the script replaces each double newline with a newline, a non-breaking space (`U+00A0`), and another newline. This applies within descriptions and between the description, discussion prompt and hashtags. Other platforms keep their original paragraph separators. [Zernio documents that TikTok ignores caption line breaks](https://zernio.com/tiktok-api), so native paragraph layout cannot be guaranteed. The non-breaking-space workaround is experimental and needs verification on a real TikTok upload.

This command targets YouTube Shorts only: Zernio documents 9:16 and 1 to 180 seconds. There is no `isShort` flag; YouTube classifies the upload.

## Publish

Each destination independently inspects local media and verifies its account, uploads, validates and publishes. Hard validation errors block that destination; warnings are collected in the final summary and do not prompt. WoopSocial's `/posts/validate` runs after upload. TikTok uses Zernio's dry run, which checks request shape and capacity rather than every downstream restriction. YouTube has no equivalent preflight here.

Delivery status is read every 10 seconds for up to 15 minutes. TikTok successful deliveries without a URL get up to two more minutes to resolve it. Read-only transient status failures can be retried, but no upload, publish or comment write is automatically resubmitted.

Share published Instagram posts or Reels to your Story manually in Instagram.

If every requested destination succeeds, pending moves to posted automatically. Partial failures or timeouts retain the pending folder. Existing posted folders are never overwritten. `--posted` never moves the folder. Exit status is nonzero for any failed, blocked or timed-out destination. There is no persistent success ledger or automatic skip of previously published destinations. After partial delivery, check the dashboard and native accounts, then explicitly select only destinations to retry.

## Provider limitations and verification

See [PROVIDERS.md](PROVIDERS.md) for verified API contracts, media guidance, covers/comments, cleanup, transformation uncertainty and safe retry behavior, with official sources checked September 12, 2026.

Zernio supports TikTok photos/videos and YouTube videos. YouTube Shorts custom thumbnails are skipped. TikTok includes the discussion prompt in its description without a separate comment; YouTube comments are created but pinned manually. WoopSocial supports Instagram carousels/Reels and explicit Facebook Page posts, with a Reel cover field for Instagram only. Its public API exposes no comment-create/pin endpoint. Manual comment text is copied to the clipboard using `pbcopy` on macOS, `clip.exe` on Windows, or `wl-copy`/`xclip` on Linux. If copying fails, the printed text remains available. Manual comments are collected in selection order and copied together once after all uploads finish. Unconfirmed YouTube comment creation also prints and copies the text, with a reminder to check existing comments before posting it. Videos may be resized and optimized, with no documented disable switch or exact output specification.

WoopSocial posts enable automatic provider-media deletion only after successful delivery. Each destination gets its own uploads to preserve unresolved media. Local files are never deleted. Free storage is 1 GB. Source batches larger than 1 GB are blocked; check the organization dashboard before upload because the public API exposes no byte usage. Cancelled or failed uploads can leave provider media to inspect manually.

Retries can duplicate posts. No write is automatically resubmitted. Zernio request IDs only protect a short provider window; rerunning reuploads media and creates a fresh request ID. WoopSocial documents no publish idempotency header. Check original provider IDs and native accounts before retrying, then select only intended destinations.

Development validation uses temporary private tests, removed before delivery. Mock tests cannot establish live account permissions, transformed output or native presentation. No real posts are published during development.
