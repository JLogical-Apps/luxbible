import 'package:lux/i18n.dart';

enum Message {
  renamedBiblePlans,
  anonymousAnalytics;

  String title() => switch (this) {
    renamedBiblePlans => t.renamedBiblePlansNotice.title,
    anonymousAnalytics => t.analyticsNotice.title,
  };

  String description() => switch (this) {
    renamedBiblePlans => t.renamedBiblePlansNotice.description,
    anonymousAnalytics => t.analyticsNotice.description,
  };
}
