import WidgetKit
import SwiftUI

@available(iOS 14.0, *)
struct NativeFormView: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "my_custom_widget", provider: MyCustomWidgetProvider()) { entry in
            MyCustomWidgetView(entry: entry)
        }
    }
}

@available(iOS 14.0, *)
struct MyCustomWidgetProvider: TimelineProvider {
    
    func placeholder(in context: Context) -> MyCustomWidgetProvider.Entry {
        MyCustomWidgetProvider.Entry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (MyCustomWidgetProvider.Entry) -> Void) {
        let entry = MyCustomWidgetProvider.Entry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<MyCustomWidgetProvider.Entry>) -> Void) {
        let currentDate = Date()
        let entry = MyCustomWidgetProvider.Entry(date: currentDate)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
    
    struct Entry: TimelineEntry {
        let date: Date
    }
}

@available(iOS 14.0, *)
struct MyCustomWidgetView: View {
    var entry: MyCustomWidgetProvider.Entry
    
    var body: some View {
        Text("Widget Content")
    }
}
