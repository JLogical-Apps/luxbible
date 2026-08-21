import 'dart:async';

import 'package:bible/utils/extensions/date_time_extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lux/lux.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synchronized/synchronized.dart';
import 'package:timezone/timezone.dart' as timezone;

part 'local_notification_service.g.dart';

class LocalNotificationChannel extends Equatable {
  final String id;
  final String name;
  final String description;

  const LocalNotificationChannel({required this.id, required this.name, required this.description});

  @override
  List<Object> get props => [id, name, description];
}

class LocalNotification extends Equatable {
  final int id;
  final LocalNotificationChannel channel;
  final String title;
  final String body;
  final LocalNotificationSchedule schedule;
  final String? payload;

  const LocalNotification({
    required this.id,
    required this.channel,
    required this.title,
    required this.body,
    required this.schedule,
    this.payload,
  });

  @override
  List<Object?> get props => [id, channel, title, body, schedule, payload];
}

sealed class LocalNotificationSchedule extends Equatable {
  const LocalNotificationSchedule();

  DateTime get scheduledDate;
  DateTimeComponents? get matchDateTimeComponents;
}

class RepeatingLocalNotificationSchedule extends LocalNotificationSchedule {
  final Time time;
  final DateTime? startDate;

  const RepeatingLocalNotificationSchedule({required this.time, this.startDate});

  @override
  DateTime get scheduledDate => time.getNextNotificationDate(startDate: startDate);

  @override
  DateTimeComponents? get matchDateTimeComponents => .time;

  @override
  List<Object?> get props => [time, startDate];
}

class SingleLocalNotificationSchedule extends LocalNotificationSchedule {
  final DateTime date;

  const SingleLocalNotificationSchedule({required this.date});

  @override
  DateTime get scheduledDate => date;

  @override
  DateTimeComponents? get matchDateTimeComponents => null;

  @override
  List<Object> get props => [date];
}

enum LocalNotificationAvailability {
  enabled,
  notRequested,
  appDisabled,
  channelDisabled;

  bool get isDisabled => this == appDisabled || this == channelDisabled;
}

class LocalNotificationService {
  static const payloadPrefix = 'lux-local-notification:';

  final FlutterLocalNotificationsPlugin plugin;

  LocalNotificationService({FlutterLocalNotificationsPlugin? plugin})
    : plugin = plugin ?? FlutterLocalNotificationsPlugin();

  Future<void> initialize({Function(String)? onNotificationTap}) async {
    await plugin.initialize(
      settings: InitializationSettings(
        android: AndroidInitializationSettings('ic_notification'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          defaultPresentAlert: true,
          defaultPresentBadge: false,
          defaultPresentSound: true,
        ),
      ),
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload != null) onNotificationTap?.call(payload);
      },
    );
  }

  Future<String?> getLaunchPayload() async {
    final details = await plugin.getNotificationAppLaunchDetails();
    return details?.didNotificationLaunchApp == true ? details?.notificationResponse?.payload : null;
  }

  Future<bool> get hasPermission async => await getAvailability() == .enabled;

  Future<LocalNotificationAvailability> getAvailability({String? androidChannelId}) async {
    final permissionAvailability = switch (await Permission.notification.status) {
      .granted || .provisional || .limited => LocalNotificationAvailability.enabled,
      .denied => LocalNotificationAvailability.notRequested,
      _ => LocalNotificationAvailability.appDisabled,
    };
    if (permissionAvailability != .enabled) return permissionAvailability;

    return defaultTargetPlatform == .android ? getAndroidAvailability(androidChannelId: androidChannelId) : .enabled;
  }

  Future<LocalNotificationAvailability> getAndroidAvailability({String? androidChannelId}) async {
    final android = plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (await android?.areNotificationsEnabled() != true) return .appDisabled;
    if (androidChannelId == null) return .enabled;

    final channels = await android?.getNotificationChannels() ?? [];
    return channels.any((channel) => channel.id == androidChannelId && channel.importance == .none)
        ? .channelDisabled
        : .enabled;
  }

  Future<bool> requestPermission() async {
    if (await hasPermission) return true;

    return switch (defaultTargetPlatform) {
      .android =>
        await plugin
                .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
                ?.requestNotificationsPermission() ??
            false,
      .iOS =>
        await plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
              alert: true,
              badge: false,
              sound: true,
            ) ??
            false,
      _ => false,
    };
  }

  Future<bool> openSettingsAndCheckPermission() async {
    final resumedCompleter = Completer<void>();
    var hasLeftApp = false;
    final listener = AppLifecycleListener(
      onStateChange: (state) {
        if (state != .resumed) hasLeftApp = true;
        if (hasLeftApp && state == .resumed && !resumedCompleter.isCompleted) resumedCompleter.complete();
      },
    );

    try {
      final didOpen = await plugin.openAppNotificationSettings() ?? false;
      if (!didOpen) return await hasPermission;
      await resumedCompleter.future;
      return await hasPermission;
    } finally {
      listener.dispose();
    }
  }

  final _synchronizationLock = Lock();
  Future<void> synchronize(List<LocalNotification> notifications) => _synchronizationLock.synchronized(() async {
    final desiredIds = notifications.map((notification) => notification.id).toSet();
    final pending = await plugin.pendingNotificationRequests();
    await pending
        .where((notification) => notification.payload?.startsWith(payloadPrefix) == true)
        .where((notification) => !desiredIds.contains(notification.id))
        .map((notification) => cancel(notification.id))
        .wait;

    if (!await hasPermission) return;
    await notifications.map(schedule).wait;
  });

  Future<void> schedule(LocalNotification notification) async {
    await plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          AndroidNotificationChannel(
            notification.channel.id,
            notification.channel.name,
            description: notification.channel.description,
            importance: .defaultImportance,
            playSound: true,
            showBadge: false,
          ),
        );

    final scheduledDate = timezone.TZDateTime.from(notification.schedule.scheduledDate, timezone.local);
    if (!scheduledDate.isAfter(timezone.TZDateTime.now(timezone.local))) return;

    await plugin.zonedSchedule(
      id: notification.id,
      title: notification.title,
      body: notification.body,
      scheduledDate: scheduledDate,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          notification.channel.id,
          notification.channel.name,
          channelDescription: notification.channel.description,
          importance: .defaultImportance,
          priority: .defaultPriority,
          playSound: true,
          channelShowBadge: false,
          styleInformation: BigTextStyleInformation(notification.body),
        ),
        iOS: DarwinNotificationDetails(presentAlert: true, presentBadge: false, presentSound: true),
      ),
      androidScheduleMode: .inexactAllowWhileIdle,
      matchDateTimeComponents: notification.schedule.matchDateTimeComponents,
      payload: notification.payload,
    );
  }

  Future<void> cancel(int id) => plugin.cancel(id: id);
}

@Riverpod(keepAlive: true)
LocalNotificationService localNotificationService(Ref ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
Future<LocalNotificationAvailability> localNotificationAvailability(Ref ref, {String? androidChannelId}) =>
    ref.watch(localNotificationServiceProvider).getAvailability(androidChannelId: androidChannelId);
