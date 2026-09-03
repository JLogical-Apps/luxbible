enum Message {
  renamedBiblePlans;

  String title() => switch (this) {
    renamedBiblePlans => 'Bible Plans Have Updated',
  };

  String description() => switch (this) {
    renamedBiblePlans =>
      'To improve the accuracy and naming of Bible plans, some of your Bible plans have been renamed.',
  };
}
