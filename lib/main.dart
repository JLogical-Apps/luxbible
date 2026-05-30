import 'dart:async';

import 'package:bible/functions/bible_importer.dart';
import 'package:bible/functions/commentary_importer.dart';
import 'package:bible/functions/cross_references_importer.dart';
import 'package:bible/functions/strong_importer.dart';
import 'package:bible/licenses.dart';
import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/commentaries_provider.dart';
import 'package:bible/providers/cross_references_provider.dart';
import 'package:bible/providers/package_info_provider.dart';
import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/path_service.dart';
import 'package:bible/services/shared_preferences_service.dart';
import 'package:bible/ui/pages/bible_page.dart';
import 'package:bible/ui/pages/get_started_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await registerLicenses();

      final bibles = await Future.wait(
        BibleTranslation.values.map((translation) => BibleImporter().importBible(translation: translation)),
      );
      final commentaries = await CommentaryImporter().import();
      final strongs = await StrongImporter().import();
      final crossReferences = await CrossReferencesImporter().import();

      final paths = await getPaths();
      final sharedPreferences = await SharedPreferences.getInstance();
      final packageInfo = await PackageInfo.fromPlatform();

      runApp(
        ProviderScope(
          overrides: [
            biblesProvider.overrideWith((ref) => bibles),
            strongsProvider.overrideWith((ref) => strongs),
            crossReferencesProvider.overrideWith((ref) => crossReferences),
            commentariesProvider.overrideWith((ref) => [commentaries]),
            pathServiceProvider.overrideWith((ref) => paths),
            sharedPreferencesServiceProvider.overrideWith((ref) => sharedPreferences),
            packageInfoProvider.overrideWith((ref) => packageInfo),
          ],
          child: BibleApp(),
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

class BibleApp extends ConsumerWidget {
  const BibleApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
        ),
        debugShowCheckedModeBanner: false,
        home: MediaQuery.withNoTextScaling(
          child: Consumer(
            builder: (context, ref, child) {
              final user = ref.watch(userProvider.notifier).userOrNull;
              return user == null ? IntroPage() : BiblePage();
            },
          ),
        ),
      ),
    );
  }
}
