import { type ClassValue, clsx } from 'clsx';
import { twMerge } from 'tailwind-merge';

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

// Prefers a sentence or clause boundary so a cut never inverts a verse, e.g. "I will fear…".
export const truncateText = (text: string, length: number) => {
  if (text.length <= length) return text;
  const slice = text.slice(0, length + 1);
  const clauseEnd = Array.from(slice.matchAll(/[.?!;][”’"')]*(?=\s)/g)).at(-1);
  return clauseEnd?.index !== undefined && clauseEnd.index > length / 2
    ? `${slice.slice(0, clauseEnd.index + clauseEnd[0].length)} …`
    : `${slice.slice(0, length).replace(/[\s,;:]*\S*$/, '')}…`;
};
