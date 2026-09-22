import WidgetKit

struct VerseOfTheDayTimelineEntry: TimelineEntry {
  let date: Date
  let verse: VerseOfTheDayWidgetEntry?

  static let sample = VerseOfTheDayTimelineEntry(
    date: Date(),
    verse: VerseOfTheDayWidgetEntry(
      date: VerseOfTheDayWidgetStore.string(from: Date()),
      reference: "Psalm 119:105",
      translation: "BSB",
      text: "Your word is a lamp to my feet and a light to my path."
    )
  )
}

/// Serves one entry per local day from the horizon the app last wrote to the shared app group.
///
/// The app refreshes that horizon on launch and on resume, so the timeline only runs dry when Lux
/// has not been opened for the length of the horizon. The widget shows a prompt to open Lux then.
struct VerseOfTheDayProvider: TimelineProvider {
  func placeholder(in context: Context) -> VerseOfTheDayTimelineEntry {
    .sample
  }

  func getSnapshot(in context: Context, completion: @escaping (VerseOfTheDayTimelineEntry) -> Void) {
    let today = VerseOfTheDayWidgetStore.calendar.startOfDay(for: Date())
    let entry = upcomingEntries(from: today).first { $0.date == today }
    completion(context.isPreview ? .sample : entry ?? .sample)
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<VerseOfTheDayTimelineEntry>) -> Void) {
    let today = VerseOfTheDayWidgetStore.calendar.startOfDay(for: Date())
    let upcoming = upcomingEntries(from: today)

    let entries = upcoming.isEmpty ? [VerseOfTheDayTimelineEntry(date: today, verse: nil)] : upcoming
    let nextRefresh = VerseOfTheDayWidgetStore.calendar.date(byAdding: .day, value: 1, to: entries.last?.date ?? today)

    completion(Timeline(entries: entries, policy: .after(nextRefresh ?? today.addingTimeInterval(86400))))
  }

  private func upcomingEntries(from today: Date) -> [VerseOfTheDayTimelineEntry] {
    VerseOfTheDayWidgetStore.read()
      .compactMap { verse -> VerseOfTheDayTimelineEntry? in
        guard let startOfDay = VerseOfTheDayWidgetStore.startOfDay(for: verse), startOfDay >= today else { return nil }
        return VerseOfTheDayTimelineEntry(date: startOfDay, verse: verse)
      }
      .sorted { $0.date < $1.date }
  }
}
