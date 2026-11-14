import { formatPassage } from '@/lib/passage';

// Mirrors apps/bible/assets/bible_plans/advent.json, one entry per day.
const adventDays = [
  ['Gen.3.1-Gen.3.21', 'Gen.4.25', '1John.3.8'],
  ['Gen.12.1-Gen.12.9', 'Gal.3.6-Gal.3.16'],
  ['Gen.38', 'Matt.1.1-Matt.1.3'],
  ['Josh.2.1-Josh.2.21', 'Josh.6.22-Josh.6.25', 'Heb.11.31'],
  [
    'Ruth.1.6-Ruth.1.18',
    'Ruth.2.8-Ruth.2.12',
    'Ruth.4.13-Ruth.4.22',
    'Matt.1.5-Matt.1.6',
  ],
  ['2Sam.7.8-2Sam.7.29'],
  ['Isa.7.10-Isa.7.16', 'Isa.9.1-Isa.9.7'],
  ['Mic.5.1-Mic.5.5'],
  ['Mal.3.1-Mal.3.4', 'Mal.4.1-Mal.4.6', 'Luke.1.16-Luke.1.17'],
  ['Luke.1.18-Luke.1.22', 'Luke.1.57-Luke.1.80'],
  ['Luke.1.24-Luke.1.25', 'Luke.1.39-Luke.1.45'],
  ['Luke.1.13-Luke.1.15', 'Luke.1.30-Luke.1.33'],
  ['Luke.1.46-Luke.1.56'],
  ['Matt.1.18-Matt.1.25', 'Matt.2.19-Matt.2.23'],
  ['John.1.19-John.1.34'],
  ['Luke.2.1-Luke.2.20'],
  ['Luke.2.25-Luke.2.35'],
  ['Luke.2.36-Luke.2.38', 'Isa.52.7-Isa.52.10'],
  ['Matt.2.1-Matt.2.6'],
  ['Matt.2.7-Matt.2.8', 'Matt.2.13-Matt.2.18', 'Ps.2'],
  ['Matt.2.9-Matt.2.12', 'Ps.72.8-Ps.72.11'],
  ['Gal.4.1-Gal.4.7', 'Eph.1.3-Eph.1.14'],
  ['1John.4.7-1John.4.14', 'John.3.16-John.3.21'],
  ['John.1.1-John.1.18', 'Phil.2.5-Phil.2.11'],
  ['Heb.2.14-Heb.2.18', 'Heb.10.1-Heb.10.10', '1Pet.2.21-1Pet.2.25'],
  ['Luke.1.34-Luke.1.38', '1Pet.1.10-1Pet.1.12'],
  ['John.16.7-John.16.15', 'Rom.8.14-Rom.8.17', 'Rom.8.26-Rom.8.27'],
];

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
  passages: [...new Set(adventDays.slice(index * 7, index * 7 + 7).flat())].map(
    (osisId) => formatPassage(osisId),
  ),
}));

export const adventDayCount = adventDays.length;

// Mirrors BiblePlanSeason.advent: the first Sunday of Advent always falls between Nov 27 and Dec 3.
const getAdventStart = (year: number) => {
  const earliestStart = new Date(Date.UTC(year, 10, 27));
  return new Date(
    Date.UTC(year, 10, 27 + ((7 - earliestStart.getUTCDay()) % 7)),
  );
};

// After Christmas, the page looks ahead to next year's Advent.
export const getUpcomingAdvent = (now: Date) => {
  const year =
    now.getTime() > Date.UTC(now.getUTCFullYear(), 11, 25, 23, 59)
      ? now.getUTCFullYear() + 1
      : now.getUTCFullYear();
  return {
    year,
    start: getAdventStart(year),
    end: new Date(Date.UTC(year, 11, 25)),
  };
};

export const formatAdventDate = (date: Date) =>
  date.toLocaleDateString('en-US', {
    month: 'long',
    day: 'numeric',
    timeZone: 'UTC',
  });
