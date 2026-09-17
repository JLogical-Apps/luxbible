'use client';

import { useEffect, useState } from 'react';

import { Campaign, getCampaign } from '@/lib/campaign';

export function useCampaign() {
  const [campaign, setCampaign] = useState<Campaign>();

  useEffect(() => setCampaign(getCampaign(window.location.search)), []);

  return campaign;
}
