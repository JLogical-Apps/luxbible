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
    BiblePlanOpenBridge.shared.register(with: engineBridge)
    PassageLinkBridge.shared.register(with: engineBridge)
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}

final class PassageLinkBridge: NSObject, FlutterSceneLifeCycleDelegate {
  static let shared = PassageLinkBridge()

  private var channel: FlutterMethodChannel?
  private var pendingLink: String?
  private var isDartReady = false

  func register(with engineBridge: FlutterImplicitEngineBridge) {
    let channel = FlutterMethodChannel(
      name: "app.luxbible.app/passage-link",
      binaryMessenger: engineBridge.applicationRegistrar.messenger()
    )
    channel.setMethodCallHandler { [weak self] call, result in
      guard let self else { return }
      if call.method == "getLaunchLink" {
        self.isDartReady = true
        result(self.pendingLink)
        self.pendingLink = nil
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
    self.channel = channel
    engineBridge.pluginRegistry.registrar(forPlugin: "PassageLinkBridge")?.addSceneDelegate(self)
  }

  private func open(_ url: URL) -> Bool {
    guard url.scheme == "https", url.host == "app.luxbible.app",
          url.pathComponents.count == 3, url.pathComponents[1] == "passage" else { return false }
    if isDartReady {
      channel?.invokeMethod("openPassage", arguments: url.absoluteString)
    } else {
      pendingLink = url.absoluteString
    }
    return true
  }

  @objc(scene:willConnectToSession:options:)
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions?
  ) -> Bool {
    if let activity = connectionOptions?.userActivities.first,
       activity.activityType == NSUserActivityTypeBrowsingWeb,
       let url = activity.webpageURL {
      return open(url)
    }
    return false
  }

  @objc(scene:continueUserActivity:)
  func scene(_ scene: UIScene, continue userActivity: NSUserActivity) -> Bool {
    guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
          let url = userActivity.webpageURL else { return false }
    return open(url)
  }
}

final class BiblePlanOpenBridge: NSObject, FlutterSceneLifeCycleDelegate {
  static let shared = BiblePlanOpenBridge()

  private var channel: FlutterMethodChannel?
  private var pendingPlan: String?
  private var isDartReady = false

  func register(with engineBridge: FlutterImplicitEngineBridge) {
    let channel = FlutterMethodChannel(
      name: "app.luxbible.app/bible-plan-open",
      binaryMessenger: engineBridge.applicationRegistrar.messenger()
    )
    channel.setMethodCallHandler { [weak self] call, result in
      guard let self else { return }
      if call.method == "getLaunchPlan" {
        self.isDartReady = true
        result(self.pendingPlan)
        self.pendingPlan = nil
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
    self.channel = channel
    engineBridge.pluginRegistry.registrar(forPlugin: "BiblePlanOpenBridge")?.addSceneDelegate(self)
  }

  private func open(_ url: URL) -> Bool {
    guard url.isFileURL, url.pathExtension.lowercased() == "lxbp" else { return false }
    let hasAccess = url.startAccessingSecurityScopedResource()
    defer { if hasAccess { url.stopAccessingSecurityScopedResource() } }
    let contents = (try? String(contentsOf: url, encoding: .utf8)) ?? ""
    if isDartReady {
      channel?.invokeMethod("openPlan", arguments: contents)
    } else {
      pendingPlan = contents
    }
    return true
  }

  @objc(scene:willConnectToSession:options:)
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions?
  ) -> Bool {
    connectionOptions?.urlContexts.forEach { open($0.url) }
    return false
  }

  @objc(scene:openURLContexts:)
  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) -> Bool {
    URLContexts.reduce(false) { handled, context in open(context.url) || handled }
  }
}
