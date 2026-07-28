import 'dart:async';
import 'dart:developer' as developer;

import 'package:audio_service/audio_service.dart';
import 'package:bible/firebase_options.dart';
import 'package:bible/functions/bible_plan_importer.dart';
import 'package:bible/functions/commentary_importer.dart';
import 'package:bible/functions/cross_references_importer.dart';
import 'package:bible/functions/dictionary_importer.dart';
import 'package:bible/functions/strong_importer.dart';
import 'package:bible/licenses.dart';
import 'package:bible/providers/audio_bible_provider.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/commentaries_provider.dart';
import 'package:bible/providers/cross_references_provider.dart';
import 'package:bible/providers/dictionary_provider.dart';
import 'package:bible/providers/package_info_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/audio_bible_handler.dart';
import 'package:bible/services/path_service.dart';
import 'package:bible/services/shared_preferences_service.dart';
import 'package:bible/style/color_library.dart';
import 'package:bible/ui/pages/bible_page.dart';
import 'package:bible/utils/scroll_behavior.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utils_core/utils_core.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

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
          androidNotificationChannelName: 'Audio Bible playback',
          androidNotificationChannelDescription: 'Audio Bible playback controls',
          androidNotificationIcon: 'drawable/ic_notification',
          androidStopForegroundOnPause: true,
          fastForwardInterval: Duration(seconds: 10),
          rewindInterval: Duration(seconds: 10),
        ),
      );

      await registerLicenses();

      final commentaries = await CommentaryImporter().import();
      final strongs = await StrongImporter().import();
      final dictionary = await DictionaryImporter().import();
      final crossReferences = await CrossReferencesImporter().import();
      final biblePlans = await BiblePlanImporter().import();

      final paths = await getPaths();
      final sharedPreferences = await SharedPreferences.getInstance();
      final packageInfo = await PackageInfo.fromPlatform();

      ref = ProviderContainer(
        overrides: [
          audioBibleHandlerProvider.overrideWithValue(audioBibleHandler),
          strongsProvider.overrideWithValue(strongs),
          dictionaryProvider.overrideWithValue(dictionary),
          crossReferencesProvider.overrideWithValue(crossReferences),
          commentariesProvider.overrideWithValue(commentaries),
          biblePlansProvider.overrideWithValue(biblePlans),
          pathServiceProvider.overrideWithValue(paths),
          sharedPreferencesServiceProvider.overrideWithValue(sharedPreferences),
          packageInfoProvider.overrideWithValue(packageInfo),
        ],
        observers: [ProviderErrorObserver()],
      );

      eagerlyLoad();

      runApp(UncontrolledProviderScope(container: ref, child: BibleApp()));
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
}

class BibleApp extends ConsumerWidget {
  const BibleApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MediaQuery.withClampedTextScaling(
        minScaleFactor: 1,
        maxScaleFactor: 1.8,
        child: MaterialApp(
          title: 'Lux Bible',
          themeMode: user.theme,
          theme: ThemeData(
            colorScheme: ColorScheme.highContrastLight(brightness: Brightness.light, primary: Colors.black),
            cardColor: Colors.white,
            appBarTheme: AppBarThemeData(scrolledUnderElevation: 0),
            iconTheme: IconThemeData(fill: 1, weight: 400, size: 25, color: Colors.black, opticalSize: 24),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.black,
              selectionColor: Colors.black.withValues(alpha: 0.2),
              selectionHandleColor: Colors.black,
            ),
            sliderTheme: SliderThemeData(inactiveTrackColor: ColorLibrary(brightness: .light).surfaceSecondary),
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.dark(brightness: Brightness.dark, primary: Colors.white),
            cardColor: Colors.black,
            appBarTheme: AppBarThemeData(scrolledUnderElevation: 0),
            iconTheme: IconThemeData(fill: 1, weight: 400, size: 25, color: Colors.white, opticalSize: 24),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.white,
              selectionColor: Colors.white.withValues(alpha: 0.2),
              selectionHandleColor: Colors.white,
            ),
            sliderTheme: SliderThemeData(inactiveTrackColor: ColorLibrary(brightness: .dark).surfaceSecondary),
          ),
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
