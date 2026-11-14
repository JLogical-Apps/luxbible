'use client';

import { useAdvent } from '@/components/blocks/AdventProvider';
import { formatAdventDate } from '@/lib/advent';

export default function AdventStatusLabel() {
  const { year, start, days, status } = useAdvent();

  switch (status.kind) {
    case 'upcoming':
      return status.daysUntil === 1
        ? 'Advent starts tomorrow'
        : `Advent starts ${formatAdventDate(start, {
            weekday: 'long',
            month: 'long',
            day: 'numeric',
          })}`;
    case 'active':
      return `Day ${status.day} of ${days.length} · ${
        days[status.day - 1].person
      }`;
    case 'ended':
      return `Advent ${year}`;
  }
}
