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
    jamiesonFaussetBrown => 'A compact, verse-by-verse commentary on the whole Bible. Balanced and accessible.',
    calvin => "The Reformer's classic exposition. Deep and doctrinal. ",
  };
}
