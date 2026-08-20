import 'dart:async';
import 'dart:developer' as developer;

import 'package:audio_service/audio_service.dart';
import 'package:bible/firebase_options.dart';
import 'package:bible/functions/audio_bible_timings_importer.dart';
import 'package:bible/functions/bible_plan_importer.dart';
import 'package:bible/functions/cross_references_importer.dart';
import 'package:bible/functions/dictionary_importer.dart';
import 'package:bible/functions/strong_importer.dart';
import 'package:bible/licenses.dart';
import 'package:bible/models/user/language.dart';
import 'package:bible/providers/app_bible_provider.dart';
import 'package:bible/providers/audio_bible_provider.dart';
import 'package:bible/providers/audio_bible_timings_provider.dart';
import 'package:bible/providers/bible_plan_local_notification_schedules_provider.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/cross_references_provider.dart';
import 'package:bible/providers/dictionary_provider.dart';
import 'package:bible/providers/language_provider.dart';
import 'package:bible/providers/local_notification_scheduler_provider.dart';
import 'package:bible/providers/local_notification_schedules_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/audio_bible_handler.dart';
import 'package:bible/services/local_notification_service.dart';
import 'package:bible/services/timezone_service.dart';
import 'package:bible/ui/bible_reader_configuration.dart';
import 'package:bible/ui/flows/bible_plan_reminder_navigation.dart';
import 'package:bible/ui/pages/bible_page.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n_flutter.dart';
import 'package:lux/lux.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:utils_core/utils_core.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      LocaleSettings.setLocaleSync(Language.device.appLocale);
      timeago.setLocaleMessages('nl', timeago.NlMessages());

      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

      const androidDebugToken = String.fromEnvironment('APP_CHECK_ANDROID_DEBUG_TOKEN');
      const appleDebugToken = String.fromEnvironment('APP_CHECK_APPLE_DEBUG_TOKEN');

      await FirebaseAppCheck.instance.activate(
        providerAndroid: kDebugMode
            ? AndroidDebugProvider(debugToken: androidDebugToken.nullIfBlank)
            : AndroidPlayIntegrityProvider(),
        providerApple: kDebugMode
            ? AppleDebugProvider(debugToken: appleDebugToken.nullIfBlank)
            : AppleAppAttestWithDeviceCheckFallbackProvider(),
      );

      final audioBibleHandler = await AudioService.init(
        builder: () => AudioBibleHandler(),
        config: AudioServiceConfig(
          androidNotificationChannelId: 'app.luxbible.app.channel.audio',
          androidNotificationChannelName: t.audio.notificationChannelName,
          androidNotificationChannelDescription: t.audio.notificationChannelDescription,
          androidNotificationIcon: 'drawable/ic_notification',
          androidStopForegroundOnPause: true,
          fastForwardInterval: Duration(seconds: 10),
          rewindInterval: Duration(seconds: 10),
        ),
      );

      await registerLicenses();

      final strongs = await StrongImporter().import();
      final dictionary = await DictionaryImporter().import();
      final crossReferences = await CrossReferencesImporter().import();
      final biblePlans = await BiblePlanImporter().import();
      final audioBibleTimings = await AudioBibleTimingsImporter().import();

      final paths = await getPaths();
      final sharedPreferences = await SharedPreferences.getInstance();
      final packageInfo = await PackageInfo.fromPlatform();

      final timezoneService = TimezoneService();
      await timezoneService.initialize();

      final localNotificationService = LocalNotificationService();
      final biblePlanReminderNavigation = BiblePlanReminderNavigation();
      await localNotificationService.initialize(
        onNotificationTap: (payload) => biblePlanReminderNavigation.handlePayload(payload),
      );

      ref = ProviderContainer(
        overrides: [
          luxReaderConfigurationProvider.overrideWith((ref) => BibleReaderConfiguration.build(ref.watch(userProvider))),
          audioBibleHandlerProvider.overrideWithValue(audioBibleHandler),
          audioBibleTimingsProvider.overrideWithValue(audioBibleTimings),
          strongsProvider.overrideWithValue(strongs),
          dictionaryProvider.overrideWithValue(dictionary),
          crossReferencesProvider.overrideWithValue(crossReferences),
          biblePlansProvider.overrideWithValue(biblePlans),
          pathServiceProvider.overrideWithValue(paths),
          sharedPreferencesServiceProvider.overrideWithValue(sharedPreferences),
          packageInfoProvider.overrideWithValue(packageInfo),
          timezoneServiceProvider.overrideWithValue(timezoneService),
          localNotificationServiceProvider.overrideWithValue(localNotificationService),
          localNotificationSchedulesProvider.overrideWith(
            (ref) => ref.watch(biblePlanLocalNotificationSchedulesProvider),
          ),
        ],
        observers: [ProviderErrorObserver()],
      );

      eagerlyLoad();

      runApp(
        UncontrolledProviderScope(
          container: ref,
          child: BibleApp(biblePlanReminderNavigation: biblePlanReminderNavigation),
        ),
      );
    },
    (error, stack) {
      if (kDebugMode) {
        print(error);
        print(stack);
      }
    },
  );
}

void eagerlyLoad() {
  ref.read(studyBibleProvider);
  ref.listen(localNotificationSchedulerProvider, (_, _) {});
}

class BibleApp extends HookConsumerWidget {
  final BiblePlanReminderNavigation biblePlanReminderNavigation;

  const BibleApp({super.key, required this.biblePlanReminderNavigation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    usePostFrameEffect(() async {
      final localNotificationService = ref.read(localNotificationServiceProvider);
      biblePlanReminderNavigation.handlePayload(await localNotificationService.getLaunchPayload());
    });

    useOnLocalesChanged((locales) {
      final language = Language.fromLocale(locales?.firstOrNull ?? .new('en'));
      LocaleSettings.setLocaleSync(language.appLocale);
      ref.invalidate(languageProvider);
    });

    useOnAppLifecycleStateChange((_, current) async {
      if (current == .resumed) {
        await ref.read(timezoneServiceProvider).updateLocalTimezone();
        ref.invalidate(localNotificationAvailabilityProvider(androidChannelId: biblePlanReminderNotificationChannelId));
        await ref.read(localNotificationServiceProvider).synchronize(ref.read(localNotificationSchedulesProvider));
      }
    });

    final user = ref.watch(userProvider);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MediaQuery.withClampedTextScaling(
        minScaleFactor: 1,
        maxScaleFactor: 1.8,
        child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Lux Bible',
          locale: Language.device.appLocale.flutterLocale,
          supportedLocales: AppLocaleUtils.instance.supportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          themeMode: user.theme,
          theme: theme,
          darkTheme: darkTheme,
          scrollBehavior: BouncingScrollBehavior(),
          debugShowCheckedModeBanner: false,
          home: BiblePage(),
        ),
      ),
    );
  }
}

final class ProviderErrorObserver extends ProviderObserver {
  @override
  void providerDidFail(ProviderObserverContext context, Object error, StackTrace stackTrace) {
    developer.log('Provider ${context.provider.name ?? context.provider.runtimeType} failed with: $error');
    developer.log('Stacktrace: $stackTrace');
  }
}
