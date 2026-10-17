// ignore_for_file: invalid_use_of_visible_for_testing_member, avoid_print, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:bible/functions/audio_bible_timings_importer.dart';
import 'package:bible/functions/bible_plan_importer.dart';
import 'package:bible/functions/cross_references_importer.dart';
import 'package:bible/functions/strong_importer.dart';
import 'package:bible/functions/verse_of_the_day_importer.dart';
import 'package:bible/main.dart';
import 'package:bible/models/user/migration.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/audio_bible_timings_provider.dart';
import 'package:bible/providers/bible_data_providers.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/cross_references_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/providers/verse_of_the_day_provider.dart';
import 'package:bible/services/local_notification_service.dart';
import 'package:bible/services/timezone_service.dart';
import 'package:bible/ui/bible_reader_configuration.dart';
import 'package:bible/ui/pages/bible_page.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
import 'package:firebase_analytics_platform_interface/firebase_analytics_platform_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/misc.dart';
import 'package:lux/i18n_flutter.dart';
import 'package:lux/lux.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

import 'device.dart';
import 'touch_indicator.dart';

final outputDirectory = Directory('build/screenshots');

class FakeLocalNotificationService implements LocalNotificationService {
  @override
  dynamic noSuchMethod(Invocation invocation) => Future.value();
}

class FakeAnalyticsPlatform extends FirebaseAnalyticsPlatform with MockPlatformInterfaceMixin {
  @override
  FirebaseAnalyticsPlatform delegateFor({required FirebaseApp app, Map<String, dynamic>? webOptions}) => this;

  @override
  Future<void> logEvent({required String name, Map<String, Object?>? parameters, AnalyticsCallOptions? callOptions}) =>
      Future.value();
}

class FakeTimezoneService implements TimezoneService {
  @override
  dynamic noSuchMethod(Invocation invocation) => Future.value();
}

Future<void> setUpScreenshotApp({List<Override> overrides = const []}) async {
  setupFirebaseCoreMocks();
  await Firebase.initializeApp();
  FirebaseAnalyticsPlatform.instance = FakeAnalyticsPlatform();
  await loadFonts();
  SharedPreferences.setMockInitialValues({});
  PackageInfo.setMockInitialValues(
    appName: 'Lux Bible',
    packageName: 'app.luxbible.app',
    version: '1.9.0',
    buildNumber: '96',
    buildSignature: '',
  );
  LocaleSettings.setLocaleSync(.en);

  final directory = await Directory.systemTemp.createTemp('lux_screenshots');
  // A fresh user logs an onboarding analytics event, which needs Firebase, so one is written up front.
  await File(
    '${directory.path}/user.json',
  ).writeAsString(jsonEncode(User(translation: .bsb, latestMigration: Migration.values.last).toJson()));

  ref = ProviderContainer(
    overrides: [
      ...bibleDataOverrides,
      luxReaderConfigurationProvider.overrideWith((ref) => BibleReaderConfiguration.build(ref.watch(userProvider))),
      audioBibleTimingsProvider.overrideWithValue(await AudioBibleTimingsImporter().import()),
      strongsProvider.overrideWithValue(await StrongImporter().import()),
      crossReferencesProvider.overrideWithValue(await CrossReferencesImporter().import()),
      includedBiblePlansProvider.overrideWithValue(await BiblePlanImporter().import()),
      verseOfTheDaySelectionsProvider.overrideWithValue(await VerseOfTheDayImporter().import()),
      pathServiceProvider.overrideWithValue(Paths(applicationSupport: directory, applicationCache: directory)),
      sharedPreferencesServiceProvider.overrideWithValue(await SharedPreferences.getInstance()),
      packageInfoProvider.overrideWithValue(await PackageInfo.fromPlatform()),
      timezoneServiceProvider.overrideWithValue(FakeTimezoneService()),
      localNotificationServiceProvider.overrideWithValue(FakeLocalNotificationService()),
      ...overrides,
    ],
  );
}

Future<void> loadFonts() async {
  final manifest = (jsonDecode(await rootBundle.loadString('FontManifest.json')) as List).cast<Map<String, dynamic>>();
  await Future.wait(manifest.map(loadFontFamily));

  final sfPro = File('tool/screenshots/fonts/SF-Pro-Text-Semibold.otf');
  if (await sfPro.exists()) {
    await (FontLoader('SF Pro Text')..addFont(sfPro.readAsBytes().then((bytes) => ByteData.sublistView(bytes)))).load();
  } else {
    print('SF Pro not found at ${sfPro.path}, the status bar falls back to Inter.');
  }
}

Future<void> loadFontFamily(Map<String, dynamic> family) {
  final loader = FontLoader(family['family']);
  (family['fonts'] as List).cast<Map<String, dynamic>>().forEach(
    (font) => loader.addFont(rootBundle.load(font['asset'])),
  );
  return loader.load();
}

class Screenshot {
  final WidgetTester tester;
  final ScreenshotDevice device;
  final frameKey = GlobalKey();
  final screenKey = GlobalKey();
  final touchIndicator = ValueNotifier<TouchIndicator?>(null);

  Screenshot(this.tester, this.device);

  BuildContext get context => navigatorKey.currentContext!;

  Future<void> pumpApp(User user) async {
    ref.updateUser((_) => user);

    tester.view.physicalSize = device.frameSize * device.viewPixelRatio;
    tester.view.devicePixelRatio = device.viewPixelRatio;

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: ref,
        child: Directionality(
          textDirection: .ltr,
          child: RepaintBoundary(
            key: frameKey,
            child: DeviceFrame(
              device: device,
              screenKey: screenKey,
              child: Stack(
                fit: .expand,
                children: [
                  ToastificationWrapper(
                    child: Builder(
                      builder: (context) => MaterialApp(
                        navigatorKey: navigatorKey,
                        title: 'Lux Bible',
                        locale: AppLocale.en.flutterLocale,
                        supportedLocales: AppLocaleUtils.instance.supportedLocales,
                        localizationsDelegates: GlobalMaterialLocalizations.delegates,
                        themeMode: .dark,
                        theme: theme,
                        darkTheme: darkTheme,
                        scrollBehavior: BouncingScrollBehavior(),
                        debugShowCheckedModeBanner: false,
                        onGenerateRoute: (settings) => context.getStyledRoute(BiblePage()),
                      ),
                    ),
                  ),
                  Positioned.fill(child: TouchIndicatorOverlay(indicator: touchIndicator)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    await settle();
  }

  // Assets decode in isolates and on real IO, so frames alternate with real waits until everything has loaded.
  Future<void> settle({int rounds = 12}) async {
    for (final _ in Range.generate(1, rounds)) {
      await tester.runAsync(() => Future.delayed(Duration(milliseconds: 150)));
      await tester.pump(Duration(milliseconds: 100));
    }
  }

  // Sheets and pages complete their futures only when closed, so the action isn't awaited.
  Future<void> run(Function() action) async {
    action();
    await settle();
  }

  Future<T> load<T>(ProviderListenable<Future<T>> provider) async =>
      (await tester.runAsync<T>(() => ref.read(provider)))!;

  Future<void> waitFor(bool Function() isReady, {int maxRounds = 60}) async {
    for (final _ in Range.generate(1, maxRounds)) {
      if (isReady()) return;
      await settle(rounds: 1);
    }
    throw StateError('Timed out waiting for the screen to load');
  }

  RenderParagraph? findParagraph(String text) => tester
      .renderObjectList<RenderParagraph>(find.byType(RichText))
      .firstWhereOrNull((paragraph) => paragraph.text.toPlainText().contains(text));

  Rect getTextRect(String text) {
    final paragraph = findParagraph(text)!;
    final start = paragraph.text.toPlainText().indexOf(text);
    final box = paragraph
        .getBoxesForSelection(TextSelection(baseOffset: start, extentOffset: start + text.length))
        .first;
    return box.toRect().shift(paragraph.localToGlobal(Offset.zero));
  }

  ScrollPosition get readerScrollPosition => tester
      .stateList<ScrollableState>(find.byType(Scrollable))
      .map((state) => state.position)
      .where((position) => position.axis == .vertical && position.hasViewportDimension)
      .sortedBy<num>((position) => position.viewportDimension)
      .last;

  // The reader builds its paragraphs lazily, so text further down only exists once it is scrolled near, and may still
  // sit below the visible area, so it is centered once built.
  Future<void> revealText(String text) async {
    for (final _ in Range.generate(1, 30)) {
      if (findParagraph(text) != null) {
        final position = readerScrollPosition;
        position.jumpTo(position.pixels + getTextRect(text).center.dy - device.frameSize.height / 2);
        await settle(rounds: 2);
        return;
      }
      final position = readerScrollPosition;
      position.jumpTo(position.pixels + position.viewportDimension * 0.8);
      await settle(rounds: 2);
    }
    throw StateError('"$text" never appeared in the reader');
  }

  Future<void> longPressText(String text) async {
    await waitFor(() => findParagraph(text) != null);
    await tester.longPressAt(getTextRect(text).center);
    await settle();
  }

  // Finds the selection toolbar as the nearest full-width ancestor of its label, which quotes the selected text.
  double getSelectionToolbarTop(String selectedText) {
    final label = tester
        .elementList(
          find.byWidgetPredicate(
            (widget) =>
                widget is Text &&
                (widget.data ?? widget.textSpan?.toPlainText() ?? '').contains(selectedText) &&
                (widget.data ?? widget.textSpan?.toPlainText() ?? '').length <= selectedText.length + 2,
          ),
        )
        .last;
    double? top;
    label.visitAncestorElements((ancestor) {
      final box = ancestor.renderObject;
      if (box is RenderBox && box.hasSize && box.size.width >= device.logicalScreenSize.width * 0.9) {
        top = box.localToGlobal(Offset.zero).dy;
        return false;
      }
      return true;
    });
    return top!;
  }

  Future<void> scrollTextAboveToolbar(String text) async {
    final position = readerScrollPosition;
    position.jumpTo(position.pixels + getTextRect(text).bottom - (getSelectionToolbarTop(text) - 10));
    await settle();
  }

  Future<void> tap(Finder finder) async {
    await tester.tap(finder, warnIfMissed: false);
    await settle();
  }

  Future<void> save(String name) async {
    await tester.runAsync(() async {
      await writePng(frameKey, '${outputDirectory.path}/${device.name}/$name.png');
      await writePng(screenKey, '${outputDirectory.path}/${device.name}/screen/$name.png');
    });
  }

  Future<void> writePng(GlobalKey key, String path, {double? pixelRatio}) async {
    final boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: pixelRatio ?? device.viewPixelRatio);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    final file = File(path);
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes!.buffer.asUint8List());
  }

  Future<void> tearDown() async {
    await tester.pumpWidget(SizedBox());
    await settle(rounds: 4);
    // Outlasts HttpClient's 15 second idle timeout on connections opened for video artwork.
    await tester.pump(Duration(seconds: 20));
    ref.invalidate(verseOfTheDayProvider);
    // The container lives outside the test's fake clock, so auto-disposal (which cancels midnight timers) needs real time.
    await tester.runAsync(() => Future.delayed(Duration(milliseconds: 200)));
    await tester.pump();
  }
}

void screenshotTest(
  String name,
  Future<void> Function(Screenshot screenshot) body, {
  List<ScreenshotDevice> devices = ScreenshotDevice.store,
}) {
  for (final device in devices) {
    testWidgets('${device.name}/$name', (tester) async {
      // flutter_test flattens shadows into solid shapes by default.
      debugDisableShadows = false;
      debugDefaultTargetPlatformOverride = device.platform;
      final screenshot = Screenshot(tester, device);
      try {
        await body(screenshot);
        await screenshot.save(name);
        await screenshot.tearDown();
      } finally {
        debugDisableShadows = true;
        debugDefaultTargetPlatformOverride = null;
      }
    });
  }
}
