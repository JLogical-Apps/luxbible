export type StoreName = 'app-store' | 'google-play';

export function getPreferredStore({
  userAgent,
  platform,
  maxTouchPoints,
}: Pick<Navigator, 'userAgent' | 'platform' | 'maxTouchPoints'>):
  | StoreName
  | undefined {
  if (/Android/i.test(userAgent)) return 'google-play';

  const isAppleMobile =
    /iPhone|iPad|iPod/i.test(userAgent) ||
    (platform === 'MacIntel' && maxTouchPoints > 1);

  if (isAppleMobile) return 'app-store';
}
