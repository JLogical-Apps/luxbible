import { readFileSync } from 'fs';
import path from 'path';

import { PassageSpan, parsePassage } from '@/lib/passage';

const bsb: Record<string, string[][]> = JSON.parse(
  readFileSync(path.join(process.cwd(), 'data/bsb.json'), 'utf8'),
);

const getSpanText = ({ start, end = start }: PassageSpan) =>
  (bsb[start.book] ?? [])
    .flatMap((verses, chapterIndex) =>
      verses.map((text, verseIndex) => ({
        chapter: chapterIndex + 1,
        verse: verseIndex + 1,
        text,
      })),
    )
    .filter(
      ({ chapter, verse }) =>
        (chapter > start.chapter ||
          (chapter === start.chapter && verse >= (start.verse ?? 1))) &&
        (end.book !== start.book ||
          chapter < end.chapter ||
          (chapter === end.chapter && verse <= (end.verse ?? Infinity))),
    )
    .map(({ text }) => text)
    .filter(Boolean)
    .join(' ');

export const getPassageText = (osisId: string) =>
  parsePassage(osisId)?.map(getSpanText).filter(Boolean).join(' … ') || null;
