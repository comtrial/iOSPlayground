//
//  WidgetWithDeeplink_widget.swift
//  WidgetWithDeeplink_widget
//
//  Created by 최승원 on 2022/09/15.
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
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
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

struct WidgetWithDeeplink_widgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        let url = URL(string: "Deeplink-test://numoo")!
        VStack(alignment: .center) {
            Link(destination: URL(string: "Deeplink-test://widget?mode=text")!) {
                Text("Write Text")
            }
            
            Divider()
            
            HStack(alignment: .center) {
                Link(destination: URL(string: "Deeplink-test://widget?mode=image")!) {
                    Text("Write Img")
                }
                Spacer()
                Link(destination: URL(string: "Deeplink-test://widget?mode=link")!) {
                    Text("Write link")
                }
            }
   
            }
            .padding(.all, 16)
        }
}


@main
struct WidgetWithDeeplink_widget: Widget {
    let kind: String = "WidgetWithDeeplink_widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WidgetWithDeeplink_widgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

struct WidgetWithDeeplink_widget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetWithDeeplink_widgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
