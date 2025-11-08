import 'package:bible/providers/bible_provider.dart';
import 'package:bible/services/bible_importer.dart';
import 'package:bible/ui/pages/bible_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final bible = await BibleImporter().import(name: 'rsv');

  runApp(
    ProviderScope(
      overrides: [bibleProvider.overrideWith((ref) => bible)],
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
    ),
  );
}
