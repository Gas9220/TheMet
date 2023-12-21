//
//  TheMetWidget.swift
//  TheMetWidget
//
//  Created by Gaspare Monte on 21/12/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), object: Object.sample(isPublicDomain: true), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), object: Object.sample(isPublicDomain: false), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, object: Object.sample(isPublicDomain: true), emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let object: Object
    let emoji: String
}

struct TheMetWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Emoji:")
            Text(entry.emoji)
        }
    }
}

struct TheMetWidget: Widget {
  let kind: String = "TheMetWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(
      kind: kind,
      provider: Provider()
    ) { entry in
      TheMetWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("The Met")
    .description("View objects from the Metropolitan Museum.")
  }
}

#Preview(as: .systemSmall) {
    TheMetWidget()
} timeline: {
    SimpleEntry(date: .now, object: Object.sample(isPublicDomain: true), emoji: "😀")
    SimpleEntry(date: .now, object: Object.sample(isPublicDomain: true), emoji: "🤩")
}
