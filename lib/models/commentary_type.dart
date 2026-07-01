enum CommentaryType {
  matthewHenry,
  jamiesonFaussetBrown,
  calvin;

  String title() => switch (this) {
    matthewHenry => 'Matthew Henry',
    jamiesonFaussetBrown => 'Jamieson-Fausset-Brown',
    calvin => 'John Calvin',
  };

  String description() => switch (this) {
    matthewHenry =>
      'A concise, devotional commentary on the whole Bible from the Puritan tradition. Warm, practical, and easy to read.',
    jamiesonFaussetBrown =>
      'A compact, verse-by-verse commentary on the whole Bible by three Reformed Scottish scholars. Balanced and accessible.',
    calvin =>
      "The Reformer's classic exposition: deep, doctrinal, and thoroughly Reformed. Covers most of the Bible, but not the Old Testament history and wisdom books, Song of Solomon, or Revelation.",
  };
}
