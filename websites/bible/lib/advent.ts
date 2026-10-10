import { formatPassage } from '@/lib/passage';

// Mirrors apps/bible/assets/bible_plans/advent.json, one entry per day.
const adventDays = [
  ['Gen.3.8-Gen.3.15'],
  ['Gen.12.1-Gen.12.3', 'Gal.3.6-Gal.3.9'],
  ['2Sam.7.8-2Sam.7.16'],
  ['Isa.7.10-Isa.7.14'],
  ['Isa.9.1-Isa.9.7'],
  ['Isa.11.1-Isa.11.10'],
  ['Mic.5.2-Mic.5.5'],
  ['Isa.40.1-Isa.40.11'],
  ['Mal.3.1-Mal.3.4'],
  ['Mal.4.1-Mal.4.6'],
  ['Luke.1.5-Luke.1.25'],
  ['Mark.1.1-Mark.1.8'],
  ['Matt.3.1-Matt.3.12'],
  ['John.1.6-John.1.8', 'John.1.19-John.1.28'],
  ['Luke.1.26-Luke.1.38'],
  ['Matt.1.18-Matt.1.25'],
  ['Luke.1.39-Luke.1.45'],
  ['Luke.1.46-Luke.1.56'],
  ['Luke.1.57-Luke.1.66'],
  ['Luke.1.67-Luke.1.80'],
  ['Isa.52.7-Isa.52.10'],
  ['Matt.1.1-Matt.1.17'],
  ['John.1.1-John.1.5'],
  ['John.1.9-John.1.14'],
  ['Phil.2.5-Phil.2.11'],
  ['Gal.4.4-Gal.4.7', 'Luke.2.1-Luke.2.7'],
  ['Luke.2.8-Luke.2.20'],
];

const weekDetails = [
  {
    title: 'The promise',
    description:
      'From the garden to the promises made to Abraham and David, and the prophets who said a child would come from Bethlehem.',
  },
  {
    title: 'Preparing the way',
    description:
      "Isaiah's voice in the wilderness, Malachi's messenger, the angel's visit to Zechariah, and John the Baptist.",
  },
  {
    title: 'The announcements',
    description:
      'Gabriel comes to Mary, an angel speaks to Joseph, Mary visits Elizabeth, and John is born.',
  },
  {
    title: 'The Word became flesh',
    description:
      'The family line of Jesus, the light coming into the world, and the birth in Bethlehem on Christmas Day.',
  },
];

export const adventWeeks = weekDetails.map((details, index) => ({
  ...details,
  passages: adventDays
    .slice(index * 7, index * 7 + 7)
    .flat()
    .map((osisId) => formatPassage(osisId)),
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
