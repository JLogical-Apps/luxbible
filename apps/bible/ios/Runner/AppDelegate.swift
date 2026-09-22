import Flutter
import UIKit
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    UNUserNotificationCenter.current().delegate = self
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    // Registered first so a widget tap that cold-launches Lux is seen before another plugin can
    // claim the scene connection that carries its URL.
    LuxWidgetBridge.shared.register(with: engineBridge)
    BiblePlanOpenBridge.shared.register(with: engineBridge)
    PassageLinkBridge.shared.register(with: engineBridge)
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
