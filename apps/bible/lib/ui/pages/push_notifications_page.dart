import 'package:bible/models/main_action.dart';
import 'package:bible/providers/bible_plan_local_notification_schedules_provider.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/local_notification_schedules_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/providers/verse_of_the_day_local_notification_schedules_provider.dart';
import 'package:bible/services/local_notification_service.dart';
import 'package:bible/ui/flows/bible_plan_reminder_flow.dart';
import 'package:bible/ui/flows/verse_of_the_day_reminder_flow.dart';
import 'package:bible/ui/widgets/bible_plan_thumbnail.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class PushNotificationsPage extends ConsumerWidget implements StyledRoute<void> {
  const PushNotificationsPage({super.key});

  @override
  String get path => '/settings/notifications';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final plans = ref.watch(biblePlansProvider);
    final activePlans = user.getHydratedPlanProgresses(plans);
    final verseOfTheDayTime = user.verseOfTheDayReminder?.dailyTime;

    final appAvailability = ref.watch(localNotificationAvailabilityProvider()).value;
    final planAvailability = ref
        .watch(localNotificationAvailabilityProvider(androidChannelId: biblePlanReminderNotificationChannelId))
        .value;

    final verseOfTheDayAvailability = ref
        .watch(localNotificationAvailabilityProvider(androidChannelId: verseOfTheDayReminderNotificationChannelId))
        .value;

    final areNotificationsEnabled = appAvailability?.isDisabled == false;
    final isPlanEnabled = areNotificationsEnabled ? planAvailability?.isDisabled == false : false;
    final isVerseOfTheDayEnabled = areNotificationsEnabled ? verseOfTheDayAvailability?.isDisabled == false : false;

    Widget buildAvailabilityNotice({
      required LocalNotificationAvailability availability,
      required String channelDisabledTitle,
    }) => Padding(
      padding: .only(left: 16, top: 16, right: 16),
      child: StyledCard.child(
        child: StyledListItem(
          leading: Symbols.notifications_off.toIcon(),
          title: switch (availability) {
            .notRequested => t.settings.notificationsNotRequested.toText(),
            .channelDisabled => channelDisabledTitle.toText(),
            _ => t.settings.notificationsDisabled.toText(),
          },
          subtitle: switch (availability) {
            .notRequested => t.settings.notificationsNotRequestedDescription.toText(),
            _ => t.settings.notificationsDisabledDescription.toText(),
          },
          trailing: availability == .notRequested ? null : Symbols.arrow_outward.toIcon(),
          onPressed: () async {
            final notifications = ref.read(localNotificationServiceProvider);
            final hasPermission = availability == .notRequested
                ? await notifications.requestPermission()
                : await notifications.openSettingsAndCheckPermission();
            if (hasPermission) {
              await notifications.synchronize(await ref.read(localNotificationsProvider.future));
            }

            ref.invalidate(localNotificationAvailabilityProvider);
          },
        ),
      ),
    );

    return StyledPage(
      title: t.settings.pushNotifications.toText(),
      backgroundColor: .backgroundPrimary,
      body: ListView(
        children: [
          if (appAvailability case final availability? when availability != .enabled)
            buildAvailabilityNotice(availability: availability, channelDisabledTitle: t.settings.notificationsDisabled)
          else ...[
            if (planAvailability == .channelDisabled)
              buildAvailabilityNotice(
                availability: .channelDisabled,
                channelDisabledTitle: t.settings.biblePlanRemindersDisabled,
              ),
            if (verseOfTheDayAvailability == .channelDisabled)
              buildAvailabilityNotice(
                availability: .channelDisabled,
                channelDisabledTitle: t.settings.verseOfTheDayRemindersDisabled,
              ),
          ],
          StyledSection.child(
            title: t.mainActions.verseOfTheDay.toText(),
            isEnabled: isVerseOfTheDayEnabled,
            child: StyledCard.child(
              child: StyledSwipeable(
                key: ValueKey(verseOfTheDayTime),
                isEnabled: isVerseOfTheDayEnabled && verseOfTheDayTime != null,
                actions: [.remove(onPressed: () => VerseOfTheDayReminderFlow.remove())],
                child: StyledListItem(
                  leading: MainAction.verseOfTheDay.buildIcon(context),
                  title: t.mainActions.verseOfTheDay.toText(),
                  subtitle: (verseOfTheDayTime?.format(format: context.timeFormat) ?? t.common.noNotification).toText(),
                  isEnabled: isVerseOfTheDayEnabled,
                  trailing: StyledPillButton.sm(
                    label: Text(verseOfTheDayTime == null ? t.common.add : t.common.edit),
                    onPressed: isVerseOfTheDayEnabled
                        ? () async {
                            final time = await context.showStyledSheet(
                              (context, _) => StyledTimeDialSheet(
                                title: t.verseOfTheDay.dailyReminders.toText(),
                                initialTime: verseOfTheDayTime ?? Time.now(),
                                trailing: verseOfTheDayTime == null
                                    ? null
                                    : StyledCircleButton.md(
                                        child: Symbols.delete.toIcon(),
                                        onPressed: () async {
                                          context.pop();

                                          final shouldRemove = await context.showStyledDialog(
                                            (dialogContext) => StyledDialog.confirmDelete(
                                              title: t.verseOfTheDay.deleteReminder.toText(),
                                              body: t.verseOfTheDay.deleteReminderConfirmation.toText(),
                                              cancelLabel: t.common.nevermind.toText(),
                                            ),
                                          );
                                          if (shouldRemove == true) VerseOfTheDayReminderFlow.remove();
                                        },
                                      ),
                              ),
                            );
                            if (time != null && context.mounted) {
                              await VerseOfTheDayReminderFlow.save(context: context, time: time);
                            }
                          }
                        : null,
                  ),
                ),
              ),
            ),
          ),
          if (activePlans.isNotEmpty)
            StyledSection.child(
              title: t.settings.biblePlanReminders.toText(),
              isEnabled: isPlanEnabled,
              child: StyledCard(
                children: activePlans.map((progress) {
                  final time = progress.progress.reminder?.dailyTime;

                  return StyledSwipeable(
                    key: ValueKey((progress.type, time)),
                    isEnabled: isPlanEnabled && time != null,
                    actions: [
                      .remove(onPressed: () => ref.updateUser((user) => user.withPlanReminder(progress.type, .none()))),
                    ],
                    child: StyledListItem(
                      leading: BiblePlanThumbnail(
                        plan: progress.plan,
                        planType: progress.type,
                        isEnabled: isPlanEnabled,
                      ),
                      title: progress.type.title().toText(),
                      subtitle: (time?.format(format: context.timeFormat) ?? t.common.noNotification).toText(),
                      isEnabled: isPlanEnabled,
                      trailing: StyledPillButton.sm(
                        label: Text(time == null ? t.common.add : t.common.edit),
                        onPressed: isPlanEnabled
                            ? () async {
                                final newTime = await context.showStyledSheet(
                                  (context, _) => StyledTimeDialSheet(
                                    title: t.biblePlans.dailyReminders.toText(),
                                    initialTime: time ?? Time.now(),
                                    trailing: time == null
                                        ? null
                                        : StyledCircleButton.md(
                                            child: Symbols.delete.toIcon(),
                                            onPressed: () async {
                                              context.pop();

                                              final shouldRemove = await context.showStyledDialog(
                                                (dialogContext) => StyledDialog.confirmDelete(
                                                  title: t.biblePlans.deleteReminder.toText(),
                                                  body: t.biblePlans
                                                      .deleteReminderConfirmation(name: progress.type.title())
                                                      .toText(),
                                                  cancelLabel: t.common.nevermind.toText(),
                                                ),
                                              );
                                              if (shouldRemove == true) {
                                                ref.updateUser((user) => user.withPlanReminder(progress.type, .none()));
                                              }
                                            },
                                          ),
                                  ),
                                );
                                if (newTime != null && context.mounted) {
                                  await BiblePlanReminderFlow.save(
                                    context: context,
                                    planType: progress.type,
                                    time: newTime,
                                  );
                                }
                              }
                            : null,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
