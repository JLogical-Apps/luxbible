# Provider behavior and verified limitations

## Platform differences and cleanup

| Destination | Images | Cover | Discussion comment |
| --- | --- | --- | --- |
| TikTok / Zernio | Up to 35 photos, 90-character title, 4,000-character description | Video timestamp selection supported; custom image supported; may stitch a frame on older connections. Photo cover selects an existing image. | Append after the description with a blank line, before hashtags. No separate comment creation or pinning. |
| YouTube Shorts / Zernio | Requires a video | Custom thumbnails unsupported for Shorts; warn and do not upload cover | Create through comments API after confirmed delivery. Pin manually. |
| Instagram / WoopSocial | Feed carousel supported | Reel cover image or extracted timestamp frame supported; carousel starts with first image | Public API has no comment creation or pin endpoint. Print and auto-copy text after delivery for manual posting and pinning where available. |
| Facebook Page / WoopSocial | Multi-image Page feed post; native display may differ from Instagram carousel | No documented Facebook cover field; warn and do not upload cover | Public API has no comment creation or pin endpoint. Print and auto-copy text after delivery for manual posting and pinning where available. |

Zernio’s YouTube guide describes `firstComment` as pinned, while its OpenAPI only promises posting and its pin route explicitly rejects every platform except TikTok. This implementation uses the documented comment-create response and reports YouTube pinning as a manual step, never as confirmed automatic pinning. Comment failures do not change a successful video result, and appear in the final summary. Unconfirmed creation prints and auto-copies the comment as a fallback; inspect existing native comments before posting or retrying. Successful YouTube creation only needs manual pinning and does not replace the clipboard. TikTok always uses the description regardless of any provider comment/pin capability.

WoopSocial [documents FFmpeg resizing/optimization](https://woopsocial.com/) but exposes no switch to prevent it and no exact output specification in the public contract. The final summary reports this uncertainty. The first live account test must inspect the delivered video, audio, framing and cover; do not assume source bytes are preserved. Instagram/Facebook local envelope warnings use Zernio’s official platform references as guidance, **not verified WoopSocial hard limits**; WoopSocial’s own media validator makes the authoritative preflight decision. Source size/dimensions, aspect ratio, duration, codec, frame rate, audio and captions are inspected locally.

WoopSocial uploads through chunked sessions (up to 5 GB per file), waits for media `READY`, and creates a separate single-destination post with `autoDeleteMediaAfterPublish: true`. This documented setting deletes referenced provider media only after that post’s delivery succeeds. Separate copies keep a successful Instagram cleanup from deleting a Facebook failure’s media, or vice versa. Local sources are never deleted. Automatic retry policies are omitted.

The media-list schema exposes no byte usage, so there is no reliable API quota calculation. Check **organization-wide** storage in the WoopSocial dashboard before running the command; uploads for each destination consume separate storage, and transformations may use more. Failed/uncertain delivery media remain in the provider library. Cancelled validation/upload runs may leave unused media; failed-session IDs in errors can help identify them. Remove only clearly unused media in the dashboard, never anything attached to unresolved delivery. Verify automatic cleanup on the first successful live test.

Facebook is always an explicit API destination. Instagram’s native auto-share is not assumed to run for API posts. Check the Page for existing posts and disable relevant Instagram sharing if it produces a duplicate, or omit Facebook with `--platform=tiktok,youtube,instagram` when a native share is already confirmed. An API cannot reliably infer this setting here.

## Retry safely

Never rerun blindly after a timeout, lost response, or provider-side failure that might have published. Inspect the provider dashboard **and native account** first. Some accepted TikTok requests may be held by the provider and publish later. Prefer checking the original provider post ID to creating another post. If you rerun, explicitly select only destinations you have decided to retry.

Zernio create requests send a unique `x-request-id` per destination. Its replay window lasts roughly five minutes, plus a separate 24-hour content/media-URL dedup check: [official idempotency contract](https://docs.zernio.com/guides/idempotency). This tool never automatically resubmits writes. A new process gets a new ID and reuploads source media to new URLs, so provider deduplication is **not durable retry protection**. Comment creation uses its documented `Idempotency-Key`, but also has no automatic retry. WoopSocial documents no publish idempotency header; none is invented. A 5xx, network failure or malformed response after submit is treated as uncertain and reported without resubmission. No `state.json`, receipts, database or scheduling system is created.

## Verification and remaining live tests

Official documentation checked September 12, 2026:

- [Zernio API schema](https://docs.zernio.com/api/openapi), [TikTok guide](https://docs.zernio.com/platforms/tiktok), [YouTube guide](https://docs.zernio.com/platforms/youtube), [Instagram reference](https://docs.zernio.com/platforms/instagram), [Facebook reference](https://docs.zernio.com/platforms/facebook).
- WoopSocial [OpenAPI](https://docs.woopsocial.com/openapi.yaml), [create post](https://docs.woopsocial.com/api-reference/posts/create-post), [validate post](https://docs.woopsocial.com/api-reference/posts/validate-post), [get delivery](https://docs.woopsocial.com/api-reference/posts/get-post), [upload sessions](https://docs.woopsocial.com/api-reference/media/start-media-upload-session), [complete upload](https://docs.woopsocial.com/api-reference/media/complete-media-upload-session).

Local validation and temporary mock-provider tests do not establish live account permissions or native-platform acceptance. Before routine use, verify one real delivery per connected account and verify channel/Page identities, visibility/disclosures, transformed media, carousel order/display, covers, comments/pinning, status/URL reconciliation, storage cleanup and Facebook duplicate behavior. Development did not publish any real content.

## Paragraph formatting and video covers

[Zernio states that TikTok ignores caption line breaks](https://zernio.com/tiktok-api). YAML literal blocks preserve paragraphs through parsing. For TikTok only, double newlines become `\n\u00A0\n`, inserting a non-breaking space on the separator line. This is an experimental workaround; downstream presentation is not guaranteed. Other platforms are unchanged. There is no documented API option here that forces TikTok to retain paragraphs. Use short copy or visible separators if separation must survive flattening.

Video `coverTimestampMs` maps to TikTok's [native cover field](https://docs.zernio.com/platforms/tiktok). For Instagram Reels, FFmpeg extracts a temporary JPEG and sends WoopSocial's documented `cover` media reference. Generated covers are removed locally after each request finishes. YouTube Shorts and Facebook do not receive timestamp covers.
