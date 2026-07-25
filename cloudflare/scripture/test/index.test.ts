import { afterEach, describe, expect, it, vi } from "vitest";
import { handleRequest } from "../src/index";

const env = { API_BIBLE_KEY: "test-api-key" };
const chapterContent = '<p class="p"><span class="v" data-number="1">1</span>In the beginning</p>';
const cacheControl = "public, max-age=2419200, stale-while-revalidate=86400, stale-if-error=2419200";

function apiBibleResponse(content: string = chapterContent): Response {
  return Response.json({ data: { content } });
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
      API_BIBLE_KEY: "",
    });

    expect(response.status).toBe(500);
    expect(response.headers.get("Cache-Control")).toBe("no-store");
    expect(fetchSpy).not.toHaveBeenCalled();
  });
});
