import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:memory/providers/root_ref.dart';
import 'package:memory/providers/user_provider.dart';
import 'package:memory/ui/pages/chapter_preview_page.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style/style.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final paths = await getPaths();
      final sharedPreferences = await SharedPreferences.getInstance();
      final packageInfo = await PackageInfo.fromPlatform();

      ref = ProviderContainer(
        overrides: [
          pathServiceProvider.overrideWithValue(paths),
          sharedPreferencesServiceProvider.overrideWithValue(sharedPreferences),
          packageInfoProvider.overrideWithValue(packageInfo),
        ],
        observers: [ProviderErrorObserver()],
      );

      runApp(UncontrolledProviderScope(container: ref, child: MemoryApp()));
    },
    (error, stack) {
      if (kDebugMode) {
        print(error);
        print(stack);
      }
    },
  );
}

class MemoryApp extends HookConsumerWidget {
  const MemoryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MediaQuery.withClampedTextScaling(
        minScaleFactor: 1,
        maxScaleFactor: 1.8,
        child: MaterialApp(
          title: 'Lux Memory',
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
          home: ChapterPreviewPage(
            chapterReference: ChapterReference(book: .genesis, chapterNum: 1),
            translation: .bsb,
          ),
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
