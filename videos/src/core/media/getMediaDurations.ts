import { ALL_FORMATS, Input, UrlSource } from "mediabunny";
import type { MediaDurations } from "./types";

const getMediaDuration = async (src: string) => {
  const input = new Input({
    formats: ALL_FORMATS,
    source: new UrlSource(src),
  });

  try {
    return await input.computeDuration();
  } finally {
    input.dispose();
  }
};

export const getMediaDurations = async <Id extends string>(
  sources: Record<Id, string>,
): Promise<MediaDurations<Id>> =>
  Object.fromEntries(
    await Promise.all(
      Object.entries<string>(sources).map(async ([id, src]) => [
        id,
        await getMediaDuration(src),
      ]),
    ),
  ) as MediaDurations<Id>;
