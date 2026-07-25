import { createLocalJWKSet, exportJWK, generateKeyPair, SignJWT } from "jose";
import { afterEach, describe, expect, it, vi } from "vitest";
import { handleAuthenticatedRequest, handleRequest, verifyAppCheckToken } from "../src/index";

const env: Cloudflare.Env = {
  API_BIBLE_KEY: "test-api-key",
  FIREBASE_PROJECT_NUMBER: "365679413474",
  FIREBASE_ANDROID_APP_ID: "1:365679413474:android:5b19dac485b52fe1d2b6bb",
  FIREBASE_IOS_APP_ID: "1:365679413474:ios:241c176505a41fedd2b6bb",
};
const chapterContent = '<p class="p"><span class="v" data-number="1">1</span>In the beginning</p>';
const cacheControl = "public, max-age=2419200, stale-while-revalidate=86400, stale-if-error=2419200";

function apiBibleResponse(content: string = chapterContent): Response {
  return Response.json({ data: { content } });
}

async function createAppCheckToken({
  audience = `projects/${env.FIREBASE_PROJECT_NUMBER}`,
  expiresIn = "5m" as string | null,
  includeIssuedAt = true,
  issuer = `https://firebaseappcheck.googleapis.com/${env.FIREBASE_PROJECT_NUMBER}`,
  subject = env.FIREBASE_ANDROID_APP_ID,
  typ = "JWT",
}: {
  audience?: string;
  expiresIn?: string | null;
  includeIssuedAt?: boolean;
  issuer?: string;
  subject?: string;
  typ?: string;
} = {}) {
  const { privateKey, publicKey } = await generateKeyPair("RS256");
  const publicJwk = await exportJWK(publicKey);
  const getKey = createLocalJWKSet({
    keys: [{ ...publicJwk, alg: "RS256", kid: "test-key", use: "sig" }],
  });
  let signer = new SignJWT()
    .setProtectedHeader({ alg: "RS256", kid: "test-key", typ })
    .setAudience(audience)
    .setIssuer(issuer)
    .setSubject(subject);

  if (includeIssuedAt) signer = signer.setIssuedAt();
  if (expiresIn !== null) signer = signer.setExpirationTime(expiresIn);

  return {
    getKey,
    token: await signer.sign(privateKey),
  };
}

afterEach(() => {
  vi.restoreAllMocks();
});

describe("scripture worker", () => {
  it.each([
    ["csb", "a556c5305ee15c3f-01"],
    ["nlt", "d6e14a625393b4da-01"],
    ["nkjv", "63097d2a0a2f7db3-01"],
  ])("maps %s to its API.Bible ID", async (translation, bibleId) => {
    const fetchSpy = vi.spyOn(globalThis, "fetch").mockResolvedValue(apiBibleResponse());

    const response = await handleRequest(new Request(`https://scripture.luxbible.app/${translation}/JHN.3`), env);

    expect(response.status).toBe(200);
    expect(await response.text()).toBe(chapterContent);
    expect(fetchSpy).toHaveBeenCalledWith(
      new URL(`https://rest.api.bible/v1/bibles/${bibleId}/chapters/JHN.3?include-notes=true`),
      {
        headers: {
          "api-key": "test-api-key",
        },
      },
    );
  });

  it("returns cacheable plain text for successful chapters", async () => {
    vi.spyOn(globalThis, "fetch").mockResolvedValue(apiBibleResponse());

    const response = await handleRequest(new Request("https://scripture.luxbible.app/csb/GEN.1"), env);

    expect(response.headers.get("Cache-Control")).toBe(cacheControl);
    expect(response.headers.get("Content-Type")).toBe("text/plain; charset=utf-8");
    expect(await response.text()).toBe(chapterContent);
  });

  it.each([
    ["https://scripture.luxbible.app/esv/JHN.3", 404],
    ["https://scripture.luxbible.app/csb/jhn.3", 400],
    ["https://scripture.luxbible.app/csb/JHN.0", 400],
    ["https://scripture.luxbible.app/csb/JHN.3?notes=false", 400],
    ["https://scripture.luxbible.app/csb/JHN.3/", 404],
  ])("rejects invalid request %s", async (url, status) => {
    const fetchSpy = vi.spyOn(globalThis, "fetch");

    const response = await handleRequest(new Request(url), env);

    expect(response.status).toBe(status);
    expect(response.headers.get("Cache-Control")).toBe("no-store");
    expect(fetchSpy).not.toHaveBeenCalled();
  });

  it("rejects unsupported methods", async () => {
    const fetchSpy = vi.spyOn(globalThis, "fetch");

    const response = await handleRequest(
      new Request("https://scripture.luxbible.app/csb/JHN.3", { method: "POST" }),
      env,
    );

    expect(response.status).toBe(405);
    expect(response.headers.get("Allow")).toBe("GET");
    expect(response.headers.get("Cache-Control")).toBe("no-store");
    expect(fetchSpy).not.toHaveBeenCalled();
  });

  it("passes through an upstream missing chapter as a non-cacheable 404", async () => {
    vi.spyOn(globalThis, "fetch").mockResolvedValue(new Response(null, { status: 404 }));

    const response = await handleRequest(new Request("https://scripture.luxbible.app/csb/JHN.999"), env);

    expect(response.status).toBe(404);
    expect(response.headers.get("Cache-Control")).toBe("no-store");
  });

  it("returns a non-cacheable 502 for upstream failures", async () => {
    vi.spyOn(globalThis, "fetch").mockResolvedValue(new Response(null, { status: 503 }));

    const response = await handleRequest(new Request("https://scripture.luxbible.app/csb/JHN.3"), env);

    expect(response.status).toBe(502);
    expect(response.headers.get("Cache-Control")).toBe("no-store");
  });

  it.each([
    new Response("not json"),
    Response.json({ data: {} }),
    Response.json({ data: { content: 42 } }),
  ])("rejects invalid API.Bible content", async (upstreamResponse) => {
    vi.spyOn(globalThis, "fetch").mockResolvedValue(upstreamResponse);

    const response = await handleRequest(new Request("https://scripture.luxbible.app/csb/JHN.3"), env);

    expect(response.status).toBe(502);
    expect(response.headers.get("Cache-Control")).toBe("no-store");
  });

  it("returns a non-cacheable 502 when API.Bible cannot be reached", async () => {
    vi.spyOn(globalThis, "fetch").mockRejectedValue(new Error("connection failed"));

    const response = await handleRequest(new Request("https://scripture.luxbible.app/csb/JHN.3"), env);

    expect(response.status).toBe(502);
    expect(response.headers.get("Cache-Control")).toBe("no-store");
  });

  it("returns a non-cacheable 500 when the secret is empty", async () => {
    const fetchSpy = vi.spyOn(globalThis, "fetch");

    const response = await handleRequest(new Request("https://scripture.luxbible.app/csb/JHN.3"), {
      ...env,
      API_BIBLE_KEY: "",
    });

    expect(response.status).toBe(500);
    expect(response.headers.get("Cache-Control")).toBe("no-store");
    expect(fetchSpy).not.toHaveBeenCalled();
  });
});

describe("App Check authentication", () => {
  it("rejects requests without an App Check token before reaching the cached entrypoint", async () => {
    const fetchScripture = vi.fn();
    const verifyToken = vi.fn();

    const response = await handleAuthenticatedRequest(
      new Request("https://scripture.luxbible.app/csb/JHN.3"),
      env,
      fetchScripture,
      verifyToken,
    );

    expect(response.status).toBe(401);
    expect(response.headers.get("Cache-Control")).toBe("no-store");
    expect(fetchScripture).not.toHaveBeenCalled();
    expect(verifyToken).not.toHaveBeenCalled();
  });

  it.each([
    ["invalid", 401],
    ["unavailable", 503],
  ] as const)("maps %s verification to a non-cacheable %s response", async (verification, status) => {
    const fetchScripture = vi.fn();
    const response = await handleAuthenticatedRequest(
      new Request("https://scripture.luxbible.app/csb/JHN.3", {
        headers: { "X-Firebase-AppCheck": "token" },
      }),
      env,
      fetchScripture,
      async () => verification,
    );

    expect(response.status).toBe(status);
    expect(response.headers.get("Cache-Control")).toBe("no-store");
    expect(fetchScripture).not.toHaveBeenCalled();
  });

  it("strips the token before invoking the cached entrypoint", async () => {
    const fetchScripture = vi.fn(async (request: Request) => {
      expect(request.headers.has("X-Firebase-AppCheck")).toBe(false);
      return new Response(chapterContent, { headers: { "Cache-Control": cacheControl } });
    });
    const response = await handleAuthenticatedRequest(
      new Request("https://scripture.luxbible.app/csb/JHN.3", {
        headers: { "X-Firebase-AppCheck": "token" },
      }),
      env,
      fetchScripture,
      async () => "valid",
    );

    expect(fetchScripture).toHaveBeenCalledOnce();
    expect(response.status).toBe(200);
    expect(response.headers.get("Cache-Control")).toBe("no-store");
    expect(await response.text()).toBe(chapterContent);
  });

  it.each([env.FIREBASE_ANDROID_APP_ID, env.FIREBASE_IOS_APP_ID])(
    "accepts a signed token for app %s",
    async (subject) => {
      const { getKey, token } = await createAppCheckToken({ subject });

      await expect(verifyAppCheckToken(token, env, getKey)).resolves.toBe("valid");
    },
  );

  it.each([
    { audience: "projects/999" },
    { issuer: "https://firebaseappcheck.googleapis.com/999" },
    { subject: "1:365679413474:web:not-allowed" },
    { typ: "NOT-JWT" },
    { expiresIn: "-1s" },
    { expiresIn: null },
    { includeIssuedAt: false },
  ])("rejects a signed token with invalid Firebase claims: %j", async (claims) => {
    const { getKey, token } = await createAppCheckToken(claims);

    await expect(verifyAppCheckToken(token, env, getKey)).resolves.toBe("invalid");
  });

  it("treats an invalid Worker configuration as unavailable", async () => {
    const { getKey, token } = await createAppCheckToken();
    const invalidEnv = { ...env, FIREBASE_PROJECT_NUMBER: "" } as unknown as Cloudflare.Env;

    await expect(verifyAppCheckToken(token, invalidEnv, getKey)).resolves.toBe("unavailable");
  });
});
