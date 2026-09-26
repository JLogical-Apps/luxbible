import Flutter
import UIKit
import WidgetKit

/// A method channel that hands Dart the links a scene delivers to Lux.
///
/// The link that cold-launched the app is buffered until Dart asks for it, and every later one is
/// pushed over the same channel as it arrives.
class LaunchLinkBridge: NSObject, FlutterSceneLifeCycleDelegate {
  private let channelName: String
  private let launchMethod: String
  private let openMethod: String

  private var channel: FlutterMethodChannel?
  private var pending: String?
  private var isDartReady = false

  init(channelName: String, launchMethod: String, openMethod: String) {
    self.channelName = channelName
    self.launchMethod = launchMethod
    self.openMethod = openMethod
  }

  /// The value to hand Dart for `url`, or nil when the URL does not belong to this bridge.
  func value(for url: URL) -> String? { nil }

  /// Handles a method beyond the launch method, returning whether it was recognized.
  func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Bool { false }

  func register(with engineBridge: FlutterImplicitEngineBridge) {
    let channel = FlutterMethodChannel(
      name: channelName,
      binaryMessenger: engineBridge.applicationRegistrar.messenger()
    )
    channel.setMethodCallHandler { [weak self] call, result in
      guard let self else { return }
      if call.method == self.launchMethod {
        self.isDartReady = true
        result(self.pending)
        self.pending = nil
      } else if !self.handle(call, result: result) {
        result(FlutterMethodNotImplemented)
      }
    }
    self.channel = channel

    let name = String(describing: type(of: self))
    engineBridge.pluginRegistry.registrar(forPlugin: name)?.addSceneDelegate(self)
  }

  /// Returns whether the URL belonged to this bridge, regardless of whether Dart could receive it yet.
  @discardableResult
  private func deliver(_ url: URL) -> Bool {
    guard let value = value(for: url) else { return false }

    if isDartReady {
      channel?.invokeMethod(openMethod, arguments: value)
    } else {
      pending = value
    }
    return true
  }

  private func webpageURLs(of activities: some Sequence<NSUserActivity>) -> [URL] {
    activities.filter { $0.activityType == NSUserActivityTypeBrowsingWeb }.compactMap(\.webpageURL)
  }

  // MARK: - FlutterSceneLifeCycleDelegate

  /// A link that cold-launches Lux arrives with the scene connection rather than through the later
  /// callbacks. The connection itself is left unhandled so every other plugin still sees it.
  @objc(scene:willConnectToSession:options:)
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions?
  ) -> Bool {
    guard let connectionOptions else { return false }

    webpageURLs(of: connectionOptions.userActivities).forEach { deliver($0) }
    connectionOptions.urlContexts.forEach { deliver($0.url) }
    return false
  }

  @objc(scene:openURLContexts:)
  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) -> Bool {
    URLContexts.reduce(false) { handled, context in deliver(context.url) || handled }
  }

  @objc(scene:continueUserActivity:)
  func scene(_ scene: UIScene, continue userActivity: NSUserActivity) -> Bool {
    webpageURLs(of: [userActivity]).reduce(false) { handled, url in deliver(url) || handled }
  }
}

/// Links to a passage, as `https://app.luxbible.app/passage/<osisId>`. They arrive as universal links,
/// or as a URL when the website's Smart App Banner opens Lux.
final class PassageLinkBridge: LaunchLinkBridge {
  static let shared = PassageLinkBridge()

  private init() {
    super.init(channelName: "app.luxbible.app/passage-link", launchMethod: "getLaunchLink", openMethod: "openPassage")
  }

  override func value(for url: URL) -> String? {
    let isPassage =
      url.scheme == "https" && url.host == "app.luxbible.app"
      && url.pathComponents.count == 3 && url.pathComponents[1] == "passage"
    return isPassage ? url.absoluteString : nil
  }
}

/// Bible plan files opened from elsewhere on the device, delivered to Dart as their contents.
final class BiblePlanOpenBridge: LaunchLinkBridge {
  static let shared = BiblePlanOpenBridge()

  private init() {
    super.init(channelName: "app.luxbible.app/bible-plan-open", launchMethod: "getLaunchPlan", openMethod: "openPlan")
  }

  override func value(for url: URL) -> String? {
    guard url.isFileURL, url.pathExtension.lowercased() == "lxbp" else { return nil }

    let hasAccess = url.startAccessingSecurityScopedResource()
    defer { if hasAccess { url.stopAccessingSecurityScopedResource() } }
    return (try? String(contentsOf: url, encoding: .utf8)) ?? ""
  }
}

/// Connects the Flutter app to the Verse of the Day widget.
///
/// Dart pushes the horizon of verses the widget should show, and the bridge stores it in the shared
/// app group and reloads the widget timelines. Widget taps arrive back as `luxbible://` URLs.
final class LuxWidgetBridge: LaunchLinkBridge {
  static let shared = LuxWidgetBridge()

  private init() {
    super.init(channelName: "app.luxbible.app/widgets", launchMethod: "getLaunchLink", openMethod: "openLink")
  }

  override func value(for url: URL) -> String? {
    url.scheme == "luxbible" ? url.absoluteString : nil
  }

  override func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Bool {
    guard call.method == "setVerses" else { return false }

    guard let json = call.arguments as? String else {
      result(FlutterError(code: "invalid-arguments", message: "Expected a JSON string.", details: nil))
      return true
    }
    VerseOfTheDayWidgetStore.write(json)
    WidgetCenter.shared.reloadAllTimelines()
    result(nil)
    return true
  }
}
