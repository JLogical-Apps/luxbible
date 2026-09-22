import SwiftUI
import WidgetKit

struct VerseOfTheDayWidget: Widget {
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: "app.luxbible.app.VerseOfTheDayWidget", provider: VerseOfTheDayProvider()) { entry in
      VerseOfTheDayEntryView(entry: entry)
    }
    .configurationDisplayName("widget.title")
    .description("widget.description")
    .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
  }
}

@main
struct LuxWidgetBundle: WidgetBundle {
  var body: some Widget {
    VerseOfTheDayWidget()
  }
}
