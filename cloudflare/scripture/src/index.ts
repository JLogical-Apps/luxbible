import { WorkerEntrypoint } from "cloudflare:workers";
import { createRemoteJWKSet, errors, jwtVerify, type JWTVerifyGetKey } from "jose";

const apiBibleOrigin = "https://rest.api.bible";

const appCheckJwksUrl = new URL("https://firebaseappcheck.googleapis.com/v1/jwks");
const appCheckHeader = "X-Firebase-AppCheck";

const cacheControl = "public, max-age=2419200, stale-while-revalidate=86400, stale-if-error=2419200";
const noStore = "no-store";
const usxPattern = /^[1-3A-Z][A-Z]{2}\.[1-9]\d{0,2}$/;

const firebaseJwks = createRemoteJWKSet(appCheckJwksUrl, {
  cacheMaxAge: 21_600_000,
  cooldownDuration: 30_000,
  timeoutDuration: 5_000,
});

const bibleIds = {
  csb: "a556c5305ee15c3f-01",
  nlt: "d6e14a625393b4da-01",
  nkjv: "63097d2a0a2f7db3-01",
} as const;

type Translation = keyof typeof bibleIds;

export type AppCheckVerification = "valid" | "invalid" | "unavailable";

function errorResponse(error: string, status: number): Response {
  return Response.json(
    { error },
    {
      status,
      headers: {
        "Cache-Control": noStore,
        "X-Content-Type-Options": "nosniff",
      },
    },
  );
}

function isTranslation(value: string): value is Translation {
  return Object.hasOwn(bibleIds, value);
}

function getApiBibleKey(env: Cloudflare.Env): string | null {
  if (!("API_BIBLE_KEY" in env)) return null;
  return typeof env.API_BIBLE_KEY === "string" && env.API_BIBLE_KEY.length > 0 ? env.API_BIBLE_KEY : null;
}

function getContent(value: unknown): string | null {
  if (typeof value !== "object" || value === null || !("data" in value)) return null;
  const { data } = value;
  if (typeof data !== "object" || data === null || !("content" in data)) return null;
  return typeof data.content === "string" ? data.content : null;
}

function logError(event: string, details: Record<string, string | number>): void {
  console.error({ event, ...details });
}

export async function verifyAppCheckToken(
  token: string,
  env: Cloudflare.Env,
  getKey: JWTVerifyGetKey = firebaseJwks,
): Promise<AppCheckVerification> {
  if (
    !/^\d+$/.test(env.FIREBASE_PROJECT_NUMBER) ||
    env.FIREBASE_ANDROID_APP_ID.length === 0 ||
    env.FIREBASE_IOS_APP_ID.length === 0
  ) {
    logError("app_check_invalid_configuration", {});
    return "unavailable";
  }

  try {
    const { payload } = await jwtVerify(token, getKey, {
      algorithms: ["RS256"],
      audience: `projects/${env.FIREBASE_PROJECT_NUMBER}`,
      issuer: `https://firebaseappcheck.googleapis.com/${env.FIREBASE_PROJECT_NUMBER}`,
      requiredClaims: ["exp", "iat", "sub"],
      typ: "JWT",
    });

    return payload.iat! <= Math.floor(Date.now() / 1000) &&
      (payload.sub === env.FIREBASE_ANDROID_APP_ID || payload.sub === env.FIREBASE_IOS_APP_ID)
      ? "valid"
      : "invalid";
  } catch (error) {
    if (error instanceof errors.JWKSTimeout || !(error instanceof errors.JOSEError)) {
      logError("app_check_verification_unavailable", {
        error: error instanceof Error ? error.message : String(error),
      });
      return "unavailable";
    }

    return "invalid";
  }
}

async function fetchChapter(translation: Translation, usx: string, apiBibleKey: string): Promise<Response> {
  const upstreamUrl = new URL(`/v1/bibles/${bibleIds[translation]}/chapters/${usx}`, apiBibleOrigin);
  upstreamUrl.searchParams.set("include-notes", "true");

  let upstreamResponse: Response;
  try {
    upstreamResponse = await fetch(upstreamUrl, {
      headers: {
        "api-key": apiBibleKey,
      },
    });
  } catch (error) {
    logError("api_bible_network_error", {
      translation,
      usx,
      error: error instanceof Error ? error.message : String(error),
    });
    return errorResponse("Scripture service is unavailable", 502);
  }

  if (upstreamResponse.status === 404) return errorResponse("Chapter not found", 404);

  if (!upstreamResponse.ok) {
    logError("api_bible_response_error", {
      translation,
      usx,
      status: upstreamResponse.status,
    });
    return errorResponse("Scripture service is unavailable", 502);
  }

  let payload: unknown;
  try {
    payload = await upstreamResponse.json();
  } catch (error) {
    logError("api_bible_invalid_json", {
      translation,
      usx,
      error: error instanceof Error ? error.message : String(error),
    });
    return errorResponse("Scripture service returned an invalid response", 502);
  }

  const content = getContent(payload);
  if (content === null) {
    logError("api_bible_missing_content", { translation, usx });
    return errorResponse("Scripture service returned an invalid response", 502);
  }

  return new Response(content, {
    headers: {
      "Cache-Control": cacheControl,
      "Content-Type": "text/plain; charset=utf-8",
      "X-Content-Type-Options": "nosniff",
    },
  });
}

export async function handleRequest(request: Request, env: Cloudflare.Env): Promise<Response> {
  if (request.method !== "GET") {
    const response = errorResponse("Method not allowed", 405);
    response.headers.set("Allow", "GET");
    return response;
  }

  const url = new URL(request.url);
  if (url.search.length > 0) return errorResponse("Query parameters are not supported", 400);

  const segments = url.pathname.split("/").slice(1);
  if (segments.length !== 2 || segments.some((segment) => segment.length === 0)) {
    return errorResponse("Route not found", 404);
  }

  const [translation, usx] = segments;
  if (!isTranslation(translation)) return errorResponse("Translation not found", 404);
  if (!usxPattern.test(usx)) return errorResponse("Invalid USX chapter identifier", 400);

  const apiBibleKey = getApiBibleKey(env);
  if (apiBibleKey === null) {
    logError("missing_api_bible_key", { translation, usx });
    return errorResponse("Scripture service is not configured", 500);
  }

  return fetchChapter(translation, usx, apiBibleKey);
}

export async function handleAuthenticatedRequest(
  request: Request,
  env: Cloudflare.Env,
  fetchScripture: (request: Request) => Promise<Response>,
  verifyToken: (token: string, env: Cloudflare.Env) => Promise<AppCheckVerification> = verifyAppCheckToken,
): Promise<Response> {
  const token = request.headers.get(appCheckHeader);
  if (token === null || token.length === 0) return errorResponse("Unauthorized", 401);

  const verification = await verifyToken(token, env);
  if (verification === "invalid") return errorResponse("Unauthorized", 401);
  if (verification === "unavailable") return errorResponse("App Check verification is unavailable", 503);

  const headers = new Headers(request.headers);
  headers.delete(appCheckHeader);

  const response = await fetchScripture(new Request(request, { headers }));
  const responseHeaders = new Headers(response.headers);
  responseHeaders.set("Cache-Control", noStore);

  return new Response(response.body, {
    status: response.status,
    statusText: response.statusText,
    headers: responseHeaders,
  });
}

export class Scripture extends WorkerEntrypoint<Cloudflare.Env> {
  override async fetch(request: Request): Promise<Response> {
    return handleRequest(request, this.env);
  }
}

export default {
  async fetch(request, env, ctx): Promise<Response> {
    return handleAuthenticatedRequest(request, env, (scriptureRequest) => ctx.exports.Scripture.fetch(scriptureRequest));
  },
} satisfies ExportedHandler<Cloudflare.Env>;
