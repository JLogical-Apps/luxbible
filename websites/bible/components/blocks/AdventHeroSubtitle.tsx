'use client';

import { useAdvent } from '@/components/blocks/AdventProvider';
import { formatAdventDate } from '@/lib/advent';

export default function AdventHeroSubtitle() {
  const { start, days, status } = useAdvent();
  const summary = `A free ${days.length}-day study through Advent in the Lux Bible app`;

  switch (status.kind) {
    case 'upcoming':
      return `${summary}, starting ${formatAdventDate(start)}.`;
    case 'active':
      return status.day === 1
        ? `${summary}. It starts today.`
        : `${summary}. It's not too late to join.`;
    case 'ended':
      return `${summary}.`;
  }
}
