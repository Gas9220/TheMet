//
//  TheMetWidget.swift
//  TheMetWidget
//
//  Created by Gaspare Monte on 21/12/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    let store = TheMetStore(6)
    let query = "persimmon"

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), object: Object.sample(isPublicDomain: true))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), object: Object.sample(isPublicDomain: false))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let interval = 3

        Task {
            do {
                try await store.fetchObjects(for: query)
            } catch {
                store.objects = [
                    Object.sample(isPublicDomain: true),
                    Object.sample(isPublicDomain: false)
                ]
            }
        }

        for index in 0 ..< store.objects.count {
            let entryDate = Calendar.current.date(
                byAdding: .second,
                value: index * interval,
                to: currentDate)!
            let entry = SimpleEntry(
                date: entryDate,
                object: store.objects[index])
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let object: Object
}

struct TheMetWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        WidgetView(entry: entry)
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
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

#Preview(as: .systemLarge) {
    TheMetWidget()
} timeline: {
    SimpleEntry(date: .now, object: Object.sample(isPublicDomain: true))
    SimpleEntry(date: .now, object: Object.sample(isPublicDomain: false))
}
