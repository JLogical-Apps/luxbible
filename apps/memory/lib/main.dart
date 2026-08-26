import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:memory/licenses.dart';
import 'package:memory/providers/root_ref.dart';
import 'package:memory/providers/user_provider.dart';
import 'package:memory/ui/pages/home_page.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await registerLicenses();

      final paths = await getPaths();
      final sharedPreferences = await SharedPreferences.getInstance();
      final packageInfo = await PackageInfo.fromPlatform();

      ref = ProviderContainer(
        overrides: [
          luxReaderConfigurationProvider.overrideWithValue(
            LuxReaderConfiguration(translationForChapter: (_) => .bsb, selectedTranslation: .bsb),
          ),
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
          theme: theme,
          darkTheme: darkTheme,
          scrollBehavior: BouncingScrollBehavior(),
          debugShowCheckedModeBanner: false,
          home: HomePage(),
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
