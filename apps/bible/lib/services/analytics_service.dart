import 'package:firebase_analytics/firebase_analytics.dart';

enum AnalyticsEvent {
  audioPlayed,
  planDayCompleted,
  planStarted,
  search,
  verseOfTheDayTapped,
  notificationTapped,
  toolbarCustomized,
  communityLinkPressed,
  rateLuxPressed,
  onboardingStarted,
  onboardingComplete,
  onboardingSkipped;

  String get eventName => switch (this) {
    audioPlayed => 'audio_played',
    planDayCompleted => 'plan_day_completed',
    planStarted => 'plan_started',
    search => 'search',
    verseOfTheDayTapped => 'verse_of_the_day_tapped',
    notificationTapped => 'notification_tapped',
    toolbarCustomized => 'toolbar_customized',
    communityLinkPressed => 'community_link_pressed',
    rateLuxPressed => 'rate_lux_pressed',
    onboardingStarted => 'onboarding_started',
    onboardingComplete => 'onboarding_complete',
    onboardingSkipped => 'onboarding_skipped',
  };

  void log() => FirebaseAnalytics.instance.logEvent(name: eventName);
}
