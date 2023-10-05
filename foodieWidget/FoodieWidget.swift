//
//  FoodieWidget.swift
//  foodieWidget
//
//  Created by Konrad Groschang on 01/07/2023.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for minutesOffset in stride(from: 0, to: 5, by: 2) {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minutesOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct FoodieWidgetEntryView : View {

    @State var isLoading = true

    var entry: Provider.Entry

    let formatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }()

   var date: String { formatter.string(from: entry.date) }

    var body: some View {
        VStack(alignment: .center) {
            Text(formatter.string(from: entry.date))
                .multilineTextAlignment(.center)
            Text(entry.date, style: .time)
                .multilineTextAlignment(.center)

            Text(entry.date, style: .timer)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.orange)
    }
}

struct FoodieWidget: Widget {

    let kind: String = "foodieWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: ConfigurationIntent.self,
            provider: Provider()
        ) { entry in
            FoodieWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("foodie Widget")
        .description("This is an example widget.")
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
            .systemLarge,
        ])
    }
}

struct FoodieWidget_Previews: PreviewProvider {
    static var previews: some View {
        FoodieWidgetEntryView(
            entry: SimpleEntry(
                date: Date(),
                configuration: ConfigurationIntent())
        )
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
