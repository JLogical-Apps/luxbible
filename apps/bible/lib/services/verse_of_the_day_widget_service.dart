import 'package:bible/functions/verse_of_the_day_widget_link.dart';
import 'package:bible/models/verse_of_the_day_widget_payload.dart';
import 'package:bible/services/launch_link_channel.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'verse_of_the_day_widget_service.g.dart';

class VerseOfTheDayWidgetService {
  static final channel = LaunchLinkChannel(
    'app.luxbible.app/widgets',
    launchMethod: 'getLaunchLink',
    openMethod: 'openLink',
  );

  // Only the mobile targets have a home screen to put a widget on.
  bool get isSupported => defaultTargetPlatform == .iOS || defaultTargetPlatform == .android;

  void initialize() {
    if (isSupported) channel.listen(VerseOfTheDayWidgetLink.handleLink);
  }

  Future<void> openLaunchLink() async {
    if (!isSupported) return;

    if (await channel.getLaunchValue() case final link?) VerseOfTheDayWidgetLink.handleLink(link);
  }

  Future<void> synchronize(VerseOfTheDayWidgetPayload payload) async {
    if (!isSupported) return;

    await channel.channel.invokeMethod<void>('setVerses', payload.encode());
  }
}

@Riverpod(keepAlive: true)
VerseOfTheDayWidgetService verseOfTheDayWidgetService(Ref ref) => VerseOfTheDayWidgetService();
