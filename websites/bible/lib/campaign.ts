export type Campaign = {
  source: string;
  medium: string;
  name: string;
  appleToken: string;
};

export const campaignsBySourceCode = {
  fp: {
    source: 'facebook',
    medium: 'organic_social',
    name: 'social_profile',
    appleToken: 'facebook-profile',
  },
  ip: {
    source: 'instagram',
    medium: 'organic_social',
    name: 'social_profile',
    appleToken: 'instagram-profile',
  },
  ia: {
    source: 'instagram',
    medium: 'paid_social',
    name: 'boosted_post',
    appleToken: 'instagram-boosted-post',
  },
  tp: {
    source: 'tiktok',
    medium: 'organic_social',
    name: 'social_profile',
    appleToken: 'tiktok-profile',
  },
  ta: {
    source: 'tiktok',
    medium: 'paid_social',
    name: 'boosted_post',
    appleToken: 'tiktok-boosted-post',
  },
  yp: {
    source: 'youtube',
    medium: 'organic_social',
    name: 'social_profile',
    appleToken: 'youtube-profile',
  },
} satisfies Record<string, Campaign>;

export const passageShareCampaign: Campaign = {
  source: 'lux_bible',
  medium: 'share',
  name: 'passage_share',
  appleToken: 'passage-share',
};

export function getCampaign(search: string): Campaign | undefined {
  const sourceCode = new URLSearchParams(search).get('s');
  return sourceCode && sourceCode in campaignsBySourceCode
    ? campaignsBySourceCode[sourceCode as keyof typeof campaignsBySourceCode]
    : undefined;
}

export function getStoreUrl({
  href,
  store,
  campaign,
  appleProviderToken,
}: {
  href: string;
  store: 'app-store' | 'google-play';
  campaign?: Campaign;
  appleProviderToken?: string;
}) {
  if (!campaign) return href;

  const url = new URL(href);
  if (store === 'google-play') {
    url.searchParams.set(
      'referrer',
      new URLSearchParams({
        utm_source: campaign.source,
        utm_medium: campaign.medium,
        utm_campaign: campaign.name,
      }).toString(),
    );
  } else if (appleProviderToken) {
    url.searchParams.set('pt', appleProviderToken);
    url.searchParams.set('ct', campaign.appleToken);
    url.searchParams.set('mt', '8');
  }

  return url.toString();
}
