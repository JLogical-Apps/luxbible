import { Campaign } from '@/lib/campaign';
import { StoreName } from '@/lib/store';

declare global {
  interface Window {
    gtag?: (...args: unknown[]) => void;
  }
}

export function trackStoreNavigation(store: StoreName, campaign?: Campaign) {
  window.gtag?.('event', 'store_navigation', {
    store,
    ...(campaign && {
      campaign_source: campaign.source,
      campaign_medium: campaign.medium,
      campaign_name: campaign.name,
    }),
  });
}
