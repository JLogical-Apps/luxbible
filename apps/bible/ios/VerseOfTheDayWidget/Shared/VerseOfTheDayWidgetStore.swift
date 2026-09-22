import Foundation

// The app resolves every user-facing string so the widget never has to.
struct VerseOfTheDayWidgetEntry: Codable, Equatable {
  let date: String
  let reference: String
  let translation: String
  let text: String
}

struct VerseOfTheDayWidgetPayload: Codable, Equatable {
  let entries: [VerseOfTheDayWidgetEntry]
}

enum VerseOfTheDayWidgetStore {
  static let appGroupIdentifier = "group.app.luxbible.app"
  static let payloadKey = "verseOfTheDay"

  // Computed per access so a time zone change mid-process can't leave stale state behind.
  static var calendar: Calendar {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = .current
    return calendar
  }

  private static var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.calendar = Calendar(identifier: .gregorian)
    formatter.timeZone = .current
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }

  private static var defaults: UserDefaults? {
    UserDefaults(suiteName: appGroupIdentifier)
  }

  static func write(_ json: String) {
    defaults?.set(json, forKey: payloadKey)
  }

  // Every field is required, so a payload from an older install fails to decode instead of half-reading.
  static func read() -> [VerseOfTheDayWidgetEntry] {
    guard let json = defaults?.string(forKey: payloadKey),
      let data = json.data(using: .utf8),
      let payload = try? JSONDecoder().decode(VerseOfTheDayWidgetPayload.self, from: data)
    else { return [] }

    return payload.entries
  }

  static func startOfDay(for entry: VerseOfTheDayWidgetEntry) -> Date? {
    dateFormatter.date(from: entry.date).map { calendar.startOfDay(for: $0) }
  }

  static func string(from date: Date) -> String {
    dateFormatter.string(from: date)
  }
}
