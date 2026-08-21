// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_of_the_day_local_notification_schedules_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(verseOfTheDayLocalNotifications)
final verseOfTheDayLocalNotificationsProvider =
    VerseOfTheDayLocalNotificationsProvider._();

final class VerseOfTheDayLocalNotificationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LocalNotification>>,
          List<LocalNotification>,
          FutureOr<List<LocalNotification>>
        >
    with
        $FutureModifier<List<LocalNotification>>,
        $FutureProvider<List<LocalNotification>> {
  VerseOfTheDayLocalNotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verseOfTheDayLocalNotificationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verseOfTheDayLocalNotificationsHash();

  @$internal
  @override
  $FutureProviderElement<List<LocalNotification>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LocalNotification>> create(Ref ref) {
    return verseOfTheDayLocalNotifications(ref);
  }
}

String _$verseOfTheDayLocalNotificationsHash() =>
    r'514d2aed592a94114f9b37c7ba5e66aa4a15dcf3';
