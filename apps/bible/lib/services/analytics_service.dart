import 'package:bible/models/user/onboarding_step.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

enum AnalyticsEventType {
  audioPlayed('audio_played'),
  videoPlayed('video_played'),
  planDayCompleted('plan_day_completed'),
  planStarted('plan_started'),
  biblePlanFileOpened('bible_plan_file_opened'),
  search('search'),
  verseShared('verse_shared'),
  sharedPassageOpened('shared_passage_opened'),
  planLinkOpened('plan_link_opened'),
  verseOfTheDayTapped('verse_of_the_day_tapped'),
  verseOfTheDayWidgetTapped('verse_of_the_day_widget_tapped'),
  notificationTapped('notification_tapped'),
  toolbarCustomized('toolbar_customized'),
  communityLinkPressed('community_link_pressed'),
  rateLuxPressed('rate_lux_pressed'),
  reviewPromptRequested('review_prompt_requested'),
  onboardingStarted('onboarding_started'),
  onboardingStepComplete('onboarding_step_complete'),
  onboardingComplete('onboarding_complete'),
  onboardingSkipped('onboarding_skipped');

  final String eventName;

  const AnalyticsEventType(this.eventName);
}

class AnalyticsEvent {
  final AnalyticsEventType type;
  final Map<String, Object>? parameters;

  AnalyticsEvent._(this.type, [this.parameters]);

  static final audioPlayed = AnalyticsEvent._(.audioPlayed);
  static final videoPlayed = AnalyticsEvent._(.videoPlayed);
  static final planDayCompleted = AnalyticsEvent._(.planDayCompleted);
  static final planStarted = AnalyticsEvent._(.planStarted);
  static final biblePlanFileOpened = AnalyticsEvent._(.biblePlanFileOpened);
  static final search = AnalyticsEvent._(.search);
  static final verseShared = AnalyticsEvent._(.verseShared);
  static final sharedPassageOpened = AnalyticsEvent._(.sharedPassageOpened);
  static final planLinkOpened = AnalyticsEvent._(.planLinkOpened);
  static final verseOfTheDayTapped = AnalyticsEvent._(.verseOfTheDayTapped);
  static final verseOfTheDayWidgetTapped = AnalyticsEvent._(.verseOfTheDayWidgetTapped);
  static final notificationTapped = AnalyticsEvent._(.notificationTapped);
  static final toolbarCustomized = AnalyticsEvent._(.toolbarCustomized);
  static final communityLinkPressed = AnalyticsEvent._(.communityLinkPressed);
  static final rateLuxPressed = AnalyticsEvent._(.rateLuxPressed);
  static final reviewPromptRequested = AnalyticsEvent._(.reviewPromptRequested);

  static AnalyticsEvent onboardingStarted(OnboardingTour tour) =>
      AnalyticsEvent._(.onboardingStarted, {'tour': tour.name});

  static AnalyticsEvent onboardingComplete(OnboardingTour tour) =>
      AnalyticsEvent._(.onboardingComplete, {'tour': tour.name});

  static AnalyticsEvent onboardingStepComplete(OnboardingStep step) =>
      AnalyticsEvent._(.onboardingStepComplete, {'tour': step.tour.name, 'step': step.name});

  static AnalyticsEvent onboardingSkipped(OnboardingStep step) =>
      AnalyticsEvent._(.onboardingSkipped, {'tour': step.tour.name, 'step': step.name});

  void log() => FirebaseAnalytics.instance.logEvent(name: type.eventName, parameters: parameters);
}
