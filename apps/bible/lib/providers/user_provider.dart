import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bible/providers/bible_plans_provider.dart';
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
        () {
          final plans = ref.read(biblePlansProvider);
          final json = jsonDecode(userFile.readAsStringSync()) as Map<String, dynamic>;
          return User.fromJson({
            ...json,
            'planProgressByType': (json['planProgressByType'] as Map<String, dynamic>? ?? {}).where(
              (id, _) => plans.containsKey(id),
            ),
            'completedPlans': (json['completedPlans'] as List? ?? []).where(plans.containsKey).toList(),
          });
        },
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

    update((user) => user.copyWith(hasRequestedReview: true));
    AnalyticsEvent.reviewPromptRequested.log();
    await appReview.requestReview();
  }

  void logAnalytics(User previousUser, User user) {
    if (user.planProgressById.keys.any((planId) => !previousUser.planProgressById.containsKey(planId))) {
      AnalyticsEvent.planStarted.log();
    }

    final hasCompletedPlanDay = user.planProgressById.entries.any((entry) {
      final previousDays = previousUser.planProgressById[entry.key]?.days ?? [];
      return entry.value.days.asMap().entries.any(
        (day) => day.value.isComplete && (day.key >= previousDays.length || !previousDays[day.key].isComplete),
      );
    });
    if (hasCompletedPlanDay) AnalyticsEvent.planDayCompleted.log();

    if (user.mainToolbar != previousUser.mainToolbar ||
        user.verseSelection != previousUser.verseSelection ||
        user.textSelection != previousUser.textSelection) {
      AnalyticsEvent.toolbarCustomized.log();
    }

    if (!previousUser.isOnboardingActive && user.isOnboardingActive) {
      AnalyticsEvent.onboardingStarted.log();
    } else if (previousUser.isOnboardingActive && !user.isOnboardingActive) {
      (previousUser.currentOnboardingStep == null
              ? AnalyticsEvent.onboardingComplete
              : AnalyticsEvent.onboardingSkipped)
          .log();
    }
  }

  File get userFile => ref.read(pathServiceProvider)!.applicationSupport - 'user.json';
}
