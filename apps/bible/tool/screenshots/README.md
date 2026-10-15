# Store screenshots

Renders the real app headlessly with `flutter test`, inside a drawn device frame with a fixed status bar, from a seeded demo user. No simulator is involved.

```sh
cd apps/bible
flutter test tool/screenshots/screenshots_test.dart
flutter test tool/screenshots/screenshots_test.dart --plain-name 'ipad/'
flutter test tool/screenshots/screenshots_test.dart --plain-name 'iphone/8_compare'
```

Every scene renders on each `ScreenshotDevice`: an iPhone 6.9" (440×956 @3x), an iPad 13" (1032×1376 @2x, which uses the side-by-side study panel layout), and a Pixel (412×915 @3x). A full run takes about 7 minutes.

The iPad renders like iPadOS Display Zoom at 130%, so its content reads at a similar size to the phones in the store images. The zoom raises the pixel ratio rather than scaling with a transform, because the reader's word hit-testing doesn't account for transforms, so the frame and output size are unchanged.

Each scene writes `build/screenshots/<device>/<scene>.png` (framed, transparent background) and `build/screenshots/<device>/screen/<scene>.png` (screen only). Scene names start with their store slot.

- `screenshots_test.dart`: one `screenshotTest` per phone in the store images.
- `seed.dart`: the demo user (notebooks, highlight styles, annotations, plan progress) and the data preloaded before any scene runs.
- `harness.dart`: app bootstrap with the same overrides as `main.dart`, Firebase stubs, settling, and PNG capture.
- `device.dart`: device sizes, safe areas, platform, frame, camera cutout, and home indicator.
- `status_bar.dart`: the iPhone, iPad, and Android status bars.
- `preview_test.dart` and `recording.dart`: the store preview recordings.

One-off shots, such as release carousel screenshots, go in a temporary test file that uses `screenshotTest` with `devices: [.iphone]` and is deleted once the PNGs are copied out. See [Release carousels](../../../../context/bible/marketing.md#release-carousels).

## Store preview video

`preview_test.dart` records the app the same way, one PNG per 30 fps frame, for the App Store preview and Google Play promo video. Each scene drives the app with real gestures through `Recording` (`recording.dart`): taps, drags, long-press text selection, and typing. Frames advance the test clock by exactly one frame, so animations play at real speed.

```sh
cd apps/bible
flutter test tool/screenshots/preview_test.dart
```

Each scene writes `build/preview/iphone/<scene>/` with its frames, an H.264 `<scene>.mp4`, and `touches.json`, the gestures by frame, which the video draws as touch indicators. The edit, copy, and music live in the Remotion `StorePreview` template; see [`videos/README.md`](../../../../videos/README.md#store-preview).

## SF Pro

The iOS status bar uses SF Pro Text Semibold from `tool/screenshots/fonts/SF-Pro-Text-Semibold.otf`, which is gitignored because Apple's license forbids redistribution. Download SF Pro from [developer.apple.com/fonts](https://developer.apple.com/fonts/) and copy that file there; without it the status bar falls back to Inter. The license only allows SF Pro in mock-ups of apps for Apple platforms, so the Android status bar uses Inter.

## Gotchas

- Real IO, isolates, and network only complete inside `tester.runAsync`, so `settle` alternates real waits with frames. A file or network call awaited outside it hangs forever.
- A keep-alive provider whose load starts inside one scene and outlives it never completes in later scenes, so shared data is loaded in `setUpAll` through `preload`.
- `flutter_test` flattens shadows unless `debugDisableShadows` is turned off, and always reports Android unless `debugDefaultTargetPlatformOverride` is set. `screenshotTest` sets both per device. `dart:io`'s `Platform` reports macOS under `flutter test`, so platform checks in app code should use `defaultTargetPlatform`.
- The reader's animated scroll to a verse doesn't run under the test clock, so scenes either use verses near the top of a chapter or jump the scroll position directly with `revealText` and `scrollTextAboveToolbar`.
- A drag that ends without resting flings on, and a tap during the fling only stops the scroll. `Recording.drag` rests for a few frames before lifting.
- There is no software keyboard under `flutter test`, so typing shows the field without one, as with a hardware keyboard.
- UI text has no system font fallback, so Hebrew only renders where the app sets the Hebrew font itself, such as the reader.
