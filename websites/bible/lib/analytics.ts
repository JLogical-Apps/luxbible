import { Campaign } from '@/lib/campaign';
import { StoreName } from '@/lib/store';

declare global {
  interface Window {
    gtag?: (...args: unknown[]) => void;
  }
}

export function trackStoreNavigation(
  store: StoreName,
  campaign?: Campaign,
  onSent?: () => void,
) {
  window.gtag?.('event', 'store_navigation', {
    store,
    ...(campaign && {
      campaign_source: campaign.source,
      campaign_medium: campaign.medium,
      campaign_name: campaign.name,
    }),
    ...(onSent && { event_callback: onSent, event_timeout: 1000 }),
  });
}
