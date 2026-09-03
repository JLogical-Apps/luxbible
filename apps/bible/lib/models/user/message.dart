import 'package:lux/i18n.dart';

enum Message {
  renamedBiblePlans,
  anonymousAnalytics;

  String title() => switch (this) {
    renamedBiblePlans => 'Bible Plans Have Updated',
    anonymousAnalytics => t.analyticsNotice.title,
  };

  String description() => switch (this) {
    renamedBiblePlans =>
      'To improve the accuracy and naming of Bible plans, some of your Bible plans have been renamed.',
    anonymousAnalytics => t.analyticsNotice.description,
  };
}
