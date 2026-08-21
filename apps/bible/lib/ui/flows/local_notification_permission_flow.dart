import 'package:bible/providers/root_ref.dart';
import 'package:bible/services/local_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class LocalNotificationPermissionFlow {
  final LocalNotificationService notifications;

  LocalNotificationPermissionFlow(this.notifications);

  static Future<bool> request({
    required BuildContext context,
    String? androidChannelId,
    required String permissionDeniedTitle,
    required String permissionDeniedBody,
    required String openSettingsLabel,
    required String cancelLabel,
    required String errorTitle,
    required String errorBody,
  }) async {
    final notifications = ref.read(localNotificationServiceProvider);

    try {
      final availability = await notifications.getAvailability(androidChannelId: androidChannelId);
      if (availability == .enabled) return true;
      if (availability == .notRequested && await notifications.requestPermission()) {
        if (await notifications.getAvailability(androidChannelId: androidChannelId) == .enabled) return true;
      }
      if (!context.mounted) return false;

      final shouldOpenSettings = await context.showStyledDialog(
        (context) => StyledDialog.confirmOrCancel(
          title: permissionDeniedTitle.toText(),
          body: permissionDeniedBody.toText(),
          confirmLabel: openSettingsLabel.toText(),
          cancelLabel: cancelLabel.toText(),
        ),
      );
      if (shouldOpenSettings != true) return false;

      await notifications.openSettingsAndCheckPermission();
      return await notifications.getAvailability(androidChannelId: androidChannelId) == .enabled;
    } catch (_) {
      if (context.mounted) {
        await context.showStyledDialog(
          (context) => StyledDialog.confirm(title: errorTitle.toText(), body: errorBody.toText()),
        );
      }
      return false;
    }
  }
}
