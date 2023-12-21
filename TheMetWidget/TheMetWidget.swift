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

        let objects = readObjects()
        for index in 0 ..< objects.count {
            let entryDate = Calendar.current.date(
                byAdding: .second,
                value: index * interval,
                to: currentDate)!
            let entry = SimpleEntry(
                date: entryDate,
                object: objects[index])
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

    func readObjects() -> [Object] {
        var objects: [Object] = []
        let archiveURL =
        FileManager.sharedContainerURL().appendingPathComponent("objects.json")
        print(">>> \(archiveURL)")

        if let codeData = try? Data(contentsOf: archiveURL) {
            do {
                objects = try JSONDecoder().decode([Object].self, from: codeData)
            } catch {
                print("Error: Can't decode contents")
            }
        }
        return objects
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
