import plan from '@/data/advent.json';

const dayLength = 24 * 60 * 60 * 1000;

export type AdventDay = {
  number: number;
  date: number;
  title: string;
  person: string;
};

export type AdventStatus =
  | { kind: 'upcoming'; daysUntil: number }
  | { kind: 'active'; day: number }
  | { kind: 'ended' };

export const adventDayCount = plan.dayTitles.length;

const weekDetails = [
  {
    title: 'The promise before Bethlehem',
    description:
      'Follow the promise of a deliverer from Eve and Abraham through the family line of Jesus and the words of Isaiah.',
  },
  {
    title: 'Preparing for the arrival',
    description:
      'Read what Micah and Malachi anticipated, then see how Zechariah, Elizabeth, Mary, and Joseph receive the news.',
  },
  {
    title: 'Witnessing and responding',
    description:
      'See how John, the shepherds, Simeon, Anna, the Magi, and others respond to the promised King.',
  },
  {
    title: 'The Father, the Son, and the Holy Spirit',
    description:
      'Study how God works in the coming of Jesus and consider the Holy Spirit’s work in your life today.',
  },
];

export const adventWeeks = weekDetails.map((details, index) => ({
  ...details,
  firstDay: index * 7 + 1,
  lastDay: Math.min((index + 1) * 7, adventDayCount),
}));

// After Christmas, the page looks ahead to next year's Advent. The plan always ends on Christmas Day.
export const getUpcomingAdvent = (now: Date) => {
  const year =
    now.getTime() > Date.UTC(now.getUTCFullYear(), 11, 25, 23, 59)
      ? now.getUTCFullYear() + 1
      : now.getUTCFullYear();
  const end = Date.UTC(year, 11, 25);
  const start = end - (adventDayCount - 1) * dayLength;
  const days: AdventDay[] = plan.dayTitles.map((title, index) => ({
    number: index + 1,
    date: start + index * dayLength,
    title,
    person: title.split(': ')[0],
  }));
  return { year, start: new Date(start), end: new Date(end), days };
};

// Compares calendar days in the viewer's own timezone, so "today" matches their date.
export const getAdventStatus = (
  now: Date,
  start: Date | number,
  dayCount: number,
): AdventStatus => {
  const offset = Math.round(
    (Date.UTC(now.getFullYear(), now.getMonth(), now.getDate()) -
      new Date(start).getTime()) /
      dayLength,
  );
  if (offset < 0) return { kind: 'upcoming', daysUntil: -offset };
  if (offset < dayCount) return { kind: 'active', day: offset + 1 };
  return { kind: 'ended' };
};

export const formatAdventDate = (
  date: Date | number,
  options: Intl.DateTimeFormatOptions = { month: 'long', day: 'numeric' },
) =>
  new Date(date).toLocaleDateString('en-US', { ...options, timeZone: 'UTC' });
