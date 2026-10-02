import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bible/models/calendar_date_time.dart';
import 'package:bible/models/user/language.dart';
import 'package:bible/models/user/migration.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/services/analytics_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:lux/lux.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utils_core/utils_core.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class UserNotifier extends _$UserNotifier {
  SharedPreferences get sharedPreferences => ref.watch(sharedPreferencesServiceProvider);

  @override
  User build() {
    final existingUser = userOrNull;
    if (existingUser != null) return existingUser;

    AnalyticsEvent.onboardingStarted.log();
    return User(
      translation: getDefaultBibleTranslations(Language.device).first,
      completedOnboardingSteps: [],
      recentBibles: [getDefaultBibleTranslations(Language.device).first],
      latestMigration: Migration.values.last,
    );
  }

  @override
  bool updateShouldNotify(_, _) => true;

  User? get userOrNull {
    if (userFile.existsSync()) {
      final user = guard(
        () => User.fromJson(jsonDecode(userFile.readAsStringSync())),
        onException: (error, stackTrace) {
          debugPrint(error.toString());
          debugPrintStack(stackTrace: stackTrace);
        },
      );
      if (user != null) {
        if (user.latestMigration != Migration.values.last) {
          final latestMigration = user.latestMigration;
          final newUser = Migration.values
              .skip(latestMigration == null ? 0 : (latestMigration.index + 1))
              .fold(user, (user, migration) => migration.migrate(user));
          Future.microtask(() async {
            update((_) => newUser.copyWith(latestMigration: Migration.values.last));
          });
          return newUser;
        }

        return user;
      }
    }

    return null;
  }

  User update(User Function(User) updater) {
    final previousUser = state;
    state = updater(previousUser);
    final shouldRequestReview = state.shouldRequestReviewAfterUpdate(previousUser);
    logAnalytics(previousUser, state);
    userFile.writeAsStringSync(jsonEncode(state.toJson()));
    if (shouldRequestReview) requestReviewIfEligible();
    return state;
  }

  void refreshActiveDay() => update((user) => user.withActiveDay(DateTime.now()));

  Future<void> requestReviewIfEligible() async {
    final appReview = InAppReview.instance;
    if (!state.isReviewRequestEligible || !await appReview.isAvailable()) return;

    update((user) => user.copyWith(lastReviewRequestDate: CalendarDateTime.now()));
    AnalyticsEvent.reviewPromptRequested.log();
    await appReview.requestReview();
  }

  void logAnalytics(User previousUser, User user) {
    if (user.planProgressById.entries.any(
      (entry) => previousUser.planProgressById[entry.key]?.instanceId != entry.value.instanceId,
    )) {
      AnalyticsEvent.planStarted.log();
    }

    if (user.planProgressById.entries.any(
      (entry) => entry.value.hasCompletedDaySince(previousUser.planProgressById[entry.key]),
    )) {
      AnalyticsEvent.planDayCompleted.log();
    }

    if (user.mainToolbar != previousUser.mainToolbar ||
        user.verseSelection != previousUser.verseSelection ||
        user.textSelection != previousUser.textSelection) {
      AnalyticsEvent.toolbarCustomized.log();
    }

    final previousCompletedSteps = previousUser.completedOnboardingSteps ?? [];
    (user.completedOnboardingSteps ?? [])
        .where((step) => !previousCompletedSteps.contains(step))
        .forEach((step) => AnalyticsEvent.onboardingStepComplete(step).log());

    if (!previousUser.isOnboardingActive && user.isOnboardingActive) {
      AnalyticsEvent.onboardingStarted.log();
    } else if (previousUser.isOnboardingActive && !user.isOnboardingActive) {
      if (previousUser.currentOnboardingStep case final step?) {
        AnalyticsEvent.onboardingSkipped(step).log();
      } else {
        AnalyticsEvent.onboardingComplete.log();
      }
    }
  }

  File get userFile => ref.read(pathServiceProvider)!.applicationSupport - 'user.json';
}
