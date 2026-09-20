import 'package:firebase_analytics/firebase_analytics.dart';

enum AnalyticsEvent {
  audioPlayed('audio_played'),
  planDayCompleted('plan_day_completed'),
  planStarted('plan_started'),
  biblePlanFileOpened('bible_plan_file_opened'),
  search('search'),
  verseOfTheDayTapped('verse_of_the_day_tapped'),
  notificationTapped('notification_tapped'),
  toolbarCustomized('toolbar_customized'),
  communityLinkPressed('community_link_pressed'),
  rateLuxPressed('rate_lux_pressed'),
  reviewPromptRequested('review_prompt_requested'),
  onboardingStarted('onboarding_started'),
  onboardingComplete('onboarding_complete'),
  onboardingSkipped('onboarding_skipped');

  final String eventName;

  const AnalyticsEvent(this.eventName);

  void log() => FirebaseAnalytics.instance.logEvent(name: eventName);
}
