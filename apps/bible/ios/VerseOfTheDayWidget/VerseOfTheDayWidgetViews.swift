import SwiftUI
import WidgetKit

/// Lux's zinc-based palette, mirrored from `ColorLibrary` in `packages/style`.
enum LuxWidgetColor {
  static let surface = dynamic(light: 0xFFFFFF, dark: 0x27272A)
  static let contentPrimary = dynamic(light: 0x000000, dark: 0xFFFFFF)
  static let contentSecondary = dynamic(light: 0x3F3F46, dark: 0xD4D4D8)
  static let contentTertiary = dynamic(light: 0x52525B, dark: 0xA1A1AA)

  private static func dynamic(light: UInt32, dark: UInt32) -> Color {
    Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(hex: dark) : UIColor(hex: light) })
  }
}

private extension UIColor {
  convenience init(hex: UInt32) {
    self.init(
      red: CGFloat((hex >> 16) & 0xFF) / 255,
      green: CGFloat((hex >> 8) & 0xFF) / 255,
      blue: CGFloat(hex & 0xFF) / 255,
      alpha: 1
    )
  }
}

private extension View {
  /// iOS 17 expects every widget to declare its background through the container, so the system can
  /// strip it in StandBy.
  @ViewBuilder
  func widgetSurface() -> some View {
    if #available(iOS 17.0, *) {
      containerBackground(LuxWidgetColor.surface, for: .widget)
    } else {
      padding(16).background(LuxWidgetColor.surface)
    }
  }
}

private extension VerseOfTheDayWidgetEntry {
  var deepLink: URL? {
    URL(string: "luxbible://verse-of-the-day?date=\(date)")
  }

  /// `John 3:16 · BSB`, matching how the app pairs a passage with its effective translation.
  var attribution: String {
    "\(reference) · \(translation)"
  }
}

private let fallbackDeepLink = URL(string: "luxbible://verse-of-the-day")

struct VerseOfTheDayEntryView: View {
  @Environment(\.widgetFamily) private var family

  let entry: VerseOfTheDayTimelineEntry

  var body: some View {
    content
      .widgetSurface()
      .widgetURL(entry.verse?.deepLink ?? fallbackDeepLink)
  }

  @ViewBuilder
  private var content: some View {
    if let verse = entry.verse {
      switch family {
      case .systemSmall:
        SmallVerseView(verse: verse)
      default:
        ExpandedVerseView(verse: verse, lineLimit: family == .systemLarge ? 12 : 4)
      }
    } else {
      EmptyVerseView()
    }
  }
}

private struct SmallVerseView: View {
  let verse: VerseOfTheDayWidgetEntry

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(verse.text)
        .font(.system(size: 13, weight: .regular))
        .foregroundStyle(LuxWidgetColor.contentPrimary)
        .minimumScaleFactor(0.8)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

      Text(verse.attribution)
        .font(.system(size: 11, weight: .semibold))
        .foregroundStyle(LuxWidgetColor.contentTertiary)
        .lineLimit(1)
        .minimumScaleFactor(0.8)
        .widgetAccentable()
    }
  }
}

private struct ExpandedVerseView: View {
  let verse: VerseOfTheDayWidgetEntry
  let lineLimit: Int

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("widget.title")
        .font(.system(size: 11, weight: .semibold))
        .textCase(.uppercase)
        .foregroundStyle(LuxWidgetColor.contentTertiary)
        .widgetAccentable()

      Text(verse.text)
        .font(.system(size: 15, weight: .regular))
        .foregroundStyle(LuxWidgetColor.contentPrimary)
        .lineLimit(lineLimit)
        .minimumScaleFactor(0.8)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

      Text(verse.attribution)
        .font(.system(size: 13, weight: .semibold))
        .foregroundStyle(LuxWidgetColor.contentSecondary)
        .lineLimit(1)
    }
  }
}

private struct EmptyVerseView: View {
  var body: some View {
    Text("widget.empty")
      .font(.system(size: 13, weight: .regular))
      .foregroundStyle(LuxWidgetColor.contentTertiary)
      .multilineTextAlignment(.leading)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
  }
}
