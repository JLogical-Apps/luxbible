import 'package:bible/models/user/user.dart';
import 'package:lux/lux.dart';

enum Migration {
  renamedBiblePlans,
  anonymousAnalytics;

  User migrate(User user) => switch (this) {
    renamedBiblePlans =>
      user.planProgressByType.keys.containsAny([.esv_through_the_bible, .heartlight_ot_and_nt])
          ? user.withMessage(.renamedBiblePlans)
          : user,
    anonymousAnalytics => user.withMessage(.anonymousAnalytics),
  };
}
