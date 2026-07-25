# Lux Scripture Worker

This Worker proxies Lux's API.Bible chapter requests through `scripture.luxbible.app`. It keeps the API key on Cloudflare, returns only the chapter content used by the Flutter parser, and caches successful chapters for 28 days.

## Request flow

The public endpoint uses a translation slug followed by an uppercase USX chapter identifier:

```text
GET https://scripture.luxbible.app/csb/JHN.3
```

Supported translation slugs are `csb`, `nlt`, and `nkjv`.

On a cache miss, the Worker requests:

```text
GET https://rest.api.bible/v1/bibles/{bibleId}/chapters/{usx}?include-notes=true
```

The `api-key` header is added inside the Worker. The response's `data.content` string is returned as plain text. API.Bible IDs and the API key are never accepted from the caller.

Successful responses are fresh for 28 days. For one day after expiration, Cloudflare may serve the stale chapter while refreshing it in the background. If the Worker or API.Bible returns a server error, Cloudflare may serve the stale chapter for up to another 28 days.

API.Bible documents the chapter endpoint and `include-notes` behavior in its [chapter guide](https://docs.api.bible/guides/chapters/).

## What the configuration controls

[`wrangler.jsonc`](./wrangler.jsonc) is the source of truth for the deployed Worker:

- `name` identifies the Worker in your Cloudflare account.
- `main` points to the TypeScript entry point.
- `compatibility_date` selects the Workers runtime behavior.
- `nodejs_compat` enables Cloudflare's current Node.js compatibility layer.
- `workers_dev` keeps a `workers.dev` address available for testing.
- `routes` attaches the Worker to `scripture.luxbible.app` as a Custom Domain.
- `cache.enabled` enables Workers Cache in front of the Worker.
- `secrets.required` declares that deployment requires `API_BIBLE_KEY`.
- `observability` enables searchable logs and sampled traces.

Cloudflare documents these features in:

- [Wrangler configuration](https://developers.cloudflare.com/workers/wrangler/configuration/)
- [Workers Cache](https://developers.cloudflare.com/workers/cache/)
- [Worker secrets](https://developers.cloudflare.com/workers/configuration/secrets/)
- [Custom Domains](https://developers.cloudflare.com/workers/configuration/routing/custom-domains/)
- [Workers observability](https://developers.cloudflare.com/workers/observability/)

## Install the local tools

Install Node.js 22 or newer, then run these commands from the repository root:

```sh
cd cloudflare/scripture
npm install
```

This installs project-local versions of Wrangler, TypeScript, and the Cloudflare Vitest integration. Using project-local tooling makes the same versions available to every checkout.

Generate binding types after installing dependencies and whenever `wrangler.jsonc` bindings change:

```sh
npm run cf-typegen
```

This runs `wrangler types` with runtime generation disabled. It reads `secrets.required` and generates the project-specific `Cloudflare.Env` binding in `worker-configuration.d.ts` without needing the secret value. The pinned `@cloudflare/workers-types` package supplies the runtime APIs.

## Configure the secret for local development

Create an ignored `.dev.vars` file containing:

```text
API_BIBLE_KEY=your-api-bible-key
```

Do not commit `.dev.vars`. The repository ignores `.dev.vars` and `.env` files under `cloudflare/`.

Start the local Worker:

```sh
npm run dev
```

This runs `wrangler dev`. It executes the Worker locally and reads `API_BIBLE_KEY` from `.dev.vars`. The API.Bible request is real, so it consumes your API allowance.

In another terminal, request a chapter:

```sh
curl --silent --show-error --dump-header - http://localhost:8787/csb/JHN.3
```

The response body should be the HTML-like chapter fragment that the Flutter app parses.

## Run local checks

Run the Worker unit tests and TypeScript checks without contacting Cloudflare or API.Bible:

```sh
npm run check
```

The tests replace the outbound API.Bible request with a local mock. They verify translation mapping, the exact upstream query, response extraction, cache headers, validation, and error behavior.

## Authenticate Wrangler

Sign in to the Cloudflare account that manages `luxbible.app`:

```sh
npx wrangler login
```

Wrangler opens a browser-based authorization flow. Confirm the active account afterward:

```sh
npx wrangler whoami
```

These commands authenticate your local CLI. They do not put credentials in this repository.

## Check the custom-domain prerequisite

Before deploying, open the Cloudflare dashboard and verify:

1. `luxbible.app` is an active zone in the same Cloudflare account.
2. There is no existing DNS record for `scripture.luxbible.app`.

A Worker Custom Domain cannot replace an existing CNAME with the same hostname. When the Worker is deployed with the current `routes` configuration, Cloudflare creates the DNS record and TLS certificate for `scripture.luxbible.app`.

## Add the deployed secret

Add the API.Bible key through Wrangler's secure interactive prompt:

```sh
npx wrangler secret put API_BIBLE_KEY
```

Do not add the key after the command or pipe it with `echo`. Wrangler prompts for the value without placing it in shell history.

The command creates a new Worker version and deploys it immediately. If Wrangler says the Worker does not exist yet, confirm that it should create `lux-scripture`. The required-secret declaration prevents later deployments from succeeding without this secret.

## Deploy

Validate the bundle locally without deploying:

```sh
npx wrangler deploy --dry-run
```

Deploy after the dry run succeeds:

```sh
npx wrangler deploy
```

The deployment publishes the Worker, enables its cache, and attaches the Custom Domain from `wrangler.jsonc`. Cloudflare manages the DNS record and certificate.

The Flutter app should not be released with its new URL until this deployment and the checks below succeed.

## Verify production

Request the same chapter twice:

```sh
curl --silent --show-error --dump-header /tmp/lux-scripture-first.headers --output /tmp/lux-scripture-first.txt https://scripture.luxbible.app/csb/JHN.3
curl --silent --show-error --dump-header /tmp/lux-scripture-second.headers --output /tmp/lux-scripture-second.txt https://scripture.luxbible.app/csb/JHN.3
```

Inspect the cache headers:

```sh
grep -i "cf-cache-status" /tmp/lux-scripture-first.headers
grep -i "cf-cache-status" /tmp/lux-scripture-second.headers
```

The first request should normally report `MISS`. The second should report `HIT`. A previously requested chapter may already report `HIT`.

Compare the bodies:

```sh
cmp /tmp/lux-scripture-first.txt /tmp/lux-scripture-second.txt
```

No output from `cmp` means the bodies match.

Repeat the request for `nlt` and `nkjv`, then try an invalid translation and malformed USX identifier to confirm that errors are not cached.

Cloudflare documents cache status troubleshooting in [Workers Cache debugging](https://developers.cloudflare.com/workers/cache/debugging/).

## Inspect production errors

Open the Worker in the Cloudflare dashboard, select **Observability**, and filter logs by the structured `event` field. Events include:

- `api_bible_network_error`
- `api_bible_response_error`
- `api_bible_invalid_json`
- `api_bible_missing_content`
- `missing_api_bible_key`

Logs include the translation and USX identifier, but never the API key or API.Bible response body.

You can also stream logs from your terminal:

```sh
npx wrangler tail
```

## API key rollout

The key previously embedded in Flutter must be treated as exposed because it remains in Git history and released app binaries.

If API.Bible permits multiple active keys:

1. Create a new key for this Worker.
2. Keep the old key active while released Lux versions still call API.Bible directly.
3. Deploy and release the Flutter change.
4. Revoke the old key after the migration window.

If API.Bible permits only one active key, rotating it immediately will break older Lux versions. Choose the cutoff deliberately after the Worker-backed release has reached enough users.
