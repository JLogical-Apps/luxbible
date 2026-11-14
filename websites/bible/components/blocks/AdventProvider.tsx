'use client';

import {
  createContext,
  ReactNode,
  useContext,
  useEffect,
  useState,
} from 'react';

import { AdventDay, AdventStatus, getAdventStatus } from '@/lib/advent';

type Advent = {
  year: number;
  start: number;
  days: AdventDay[];
  status: AdventStatus;
};

const AdventContext = createContext<Advent | null>(null);

export function useAdvent() {
  const advent = useContext(AdventContext);
  if (!advent) throw new Error('useAdvent must be used inside AdventProvider');
  return advent;
}

// The server renders with its own date, then the page switches to the viewer's date.
export default function AdventProvider({
  year,
  start,
  days,
  initialStatus,
  children,
}: {
  year: number;
  start: number;
  days: AdventDay[];
  initialStatus: AdventStatus;
  children: ReactNode;
}) {
  const [status, setStatus] = useState(initialStatus);
  useEffect(
    () => setStatus(getAdventStatus(new Date(), start, days.length)),
    [start, days.length],
  );

  return (
    <AdventContext.Provider value={{ year, start, days, status }}>
      {children}
    </AdventContext.Provider>
  );
}
