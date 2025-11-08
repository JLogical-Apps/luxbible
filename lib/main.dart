import 'dart:async';

import 'package:bible/models/bible.dart';
import 'package:bible/models/bible_importer.dart';
import 'package:bible/providers/bible_provider.dart';
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
          bible: await BibleImporter().import(name: 'rsv'),
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
  final Bible bible;
  final SharedPreferences sharedPreferences;

  const BibleApp({super.key, required this.bible, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        bibleProvider.overrideWith((ref) => bible),
        sharedPreferenceServiceProvider.overrideWith(
          (ref) => SharedPreferencesService(sharedPreferences),
        ),
      ],
      child: MaterialApp(
        title: 'Bible',
        theme: ThemeData(
          colorScheme: ColorScheme.highContrastLight(brightness: Brightness.light),
          cardColor: Colors.transparent,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.dark(brightness: Brightness.dark),
          cardColor: Colors.transparent,
        ),
        debugShowCheckedModeBanner: false,
        home: BiblePage(),
      ),
    );
  }
}
