import 'dart:async';

import 'package:bible/functions/bible_importer.dart';
import 'package:bible/functions/strong_importer.dart';
import 'package:bible/models/bible.dart';
import 'package:bible/models/bible_translation.dart';
import 'package:bible/models/strong.dart';
import 'package:bible/providers/bible_provider.dart';
import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/services/shared_preferences_service.dart';
import 'package:bible/ui/pages/bible_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      runApp(
        BibleApp(
          bibles: await Future.wait(
            BibleTranslation.values.map(
              (translation) => BibleImporter().import(translation: translation),
            ),
          ),
          strongs: await StrongImporter().import(),
          sharedPreferences: await SharedPreferences.getInstance(),
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

class BibleApp extends StatelessWidget {
  final List<Bible> bibles;
  final Map<String, Strong> strongs;
  final SharedPreferences sharedPreferences;

  const BibleApp({
    super.key,
    required this.bibles,
    required this.strongs,
    required this.sharedPreferences,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        biblesProvider.overrideWith((ref) => bibles),
        strongsProvider.overrideWith((ref) => strongs),
        sharedPreferenceServiceProvider.overrideWith(
          (ref) => SharedPreferencesService(sharedPreferences),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
          title: 'Bible',
          theme: ThemeData(
            colorScheme: ColorScheme.highContrastLight(brightness: Brightness.light),
            cardColor: Colors.transparent,
            appBarTheme: AppBarThemeData(scrolledUnderElevation: 0),
            iconTheme: IconThemeData(
              fill: 1,
              weight: 600,
              color: Colors.black,
              opticalSize: 36,
            ),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.black,
              selectionColor: Colors.black.withValues(alpha: 0.2),
              selectionHandleColor: Colors.black,
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.dark(brightness: Brightness.dark),
            cardColor: Colors.transparent,
            appBarTheme: AppBarThemeData(scrolledUnderElevation: 0),
            iconTheme: IconThemeData(
              fill: 1,
              weight: 600,
              color: Colors.white,
              opticalSize: 36,
            ),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.white,
              selectionColor: Colors.white.withValues(alpha: 0.2),
              selectionHandleColor: Colors.white,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: BiblePage(),
        ),
      ),
    );
  }
}
