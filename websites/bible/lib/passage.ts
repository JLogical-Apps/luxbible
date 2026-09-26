const bookTitlesByOsisId: Record<string, string> = {
  Gen: 'Genesis',
  Exod: 'Exodus',
  Lev: 'Leviticus',
  Num: 'Numbers',
  Deut: 'Deuteronomy',
  Josh: 'Joshua',
  Judg: 'Judges',
  Ruth: 'Ruth',
  '1Sam': '1 Samuel',
  '2Sam': '2 Samuel',
  '1Kgs': '1 Kings',
  '2Kgs': '2 Kings',
  '1Chr': '1 Chronicles',
  '2Chr': '2 Chronicles',
  Ezra: 'Ezra',
  Neh: 'Nehemiah',
  Esth: 'Esther',
  Job: 'Job',
  Ps: 'Psalm',
  Prov: 'Proverbs',
  Eccl: 'Ecclesiastes',
  Song: 'Song of Solomon',
  Isa: 'Isaiah',
  Jer: 'Jeremiah',
  Lam: 'Lamentations',
  Ezek: 'Ezekiel',
  Dan: 'Daniel',
  Hos: 'Hosea',
  Joel: 'Joel',
  Amos: 'Amos',
  Obad: 'Obadiah',
  Jonah: 'Jonah',
  Mic: 'Micah',
  Nah: 'Nahum',
  Hab: 'Habakkuk',
  Zeph: 'Zephaniah',
  Hag: 'Haggai',
  Zech: 'Zechariah',
  Mal: 'Malachi',
  Matt: 'Matthew',
  Mark: 'Mark',
  Luke: 'Luke',
  John: 'John',
  Acts: 'Acts',
  Rom: 'Romans',
  '1Cor': '1 Corinthians',
  '2Cor': '2 Corinthians',
  Gal: 'Galatians',
  Eph: 'Ephesians',
  Phil: 'Philippians',
  Col: 'Colossians',
  '1Thess': '1 Thessalonians',
  '2Thess': '2 Thessalonians',
  '1Tim': '1 Timothy',
  '2Tim': '2 Timothy',
  Titus: 'Titus',
  Phlm: 'Philemon',
  Heb: 'Hebrews',
  Jas: 'James',
  '1Pet': '1 Peter',
  '2Pet': '2 Peter',
  '1John': '1 John',
  '2John': '2 John',
  '3John': '3 John',
  Jude: 'Jude',
  Rev: 'Revelation',
};

const bookTitlesByUppercaseOsisId = new Map(
  Object.entries(bookTitlesByOsisId).map(([osisId, title]) => [
    osisId.toUpperCase(),
    title,
  ]),
);

type Pointer = { book: string; chapter: number; verse?: number };

const parsePointer = (value: string): Pointer | null => {
  const match = /^([1-3]?[A-Za-z]+)\.(\d+)(?:\.(\d+))?$/.exec(value);
  const book = match && bookTitlesByUppercaseOsisId.get(match[1].toUpperCase());
  if (!match || !book) return null;
  return {
    book,
    chapter: Number(match[2]),
    verse: match[3] === undefined ? undefined : Number(match[3]),
  };
};

const formatPointer = (pointer: Pointer, previous?: Pointer) => {
  const location = [pointer.chapter, pointer.verse]
    .filter((part) => part !== undefined)
    .join(':');
  if (!previous || pointer.book !== previous.book) {
    return `${pointer.book} ${location}`;
  }
  if (pointer.chapter !== previous.chapter) return location;
  return String(pointer.verse ?? pointer.chapter);
};

// Mirrors VerseSelection.format() in packages/lux, e.g. `Rom.1.2-Rom.1.5 Rom.2.1` is `Romans 1:2-5; 2:1`.
export const formatPassage = (osisId: string) => {
  const spans = osisId.split(' ').map((span) => {
    const pointers = span.split('-').map(parsePointer);
    if (pointers.length > 2 || pointers.some((pointer) => !pointer)) {
      return null;
    }
    const [start, end] = pointers as Pointer[];
    return { start, end };
  });
  if (spans.some((span) => !span)) return null;

  return (spans as { start: Pointer; end?: Pointer }[])
    .map(({ start, end }, index, all) => {
      const previous = index > 0 ? all[index - 1] : undefined;
      const previousEnd = previous && (previous.end ?? previous.start);
      const separator = !previousEnd
        ? ''
        : previousEnd.book !== start.book ||
            previousEnd.chapter !== start.chapter
          ? '; '
          : ', ';
      const range = [
        formatPointer(start, previousEnd),
        ...(end ? [formatPointer(end, start)] : []),
      ].join('-');
      return `${separator}${range}`;
    })
    .join('');
};
