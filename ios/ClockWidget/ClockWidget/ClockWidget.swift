import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), clockType: "digital", backgroundColor: "#000000", fontFamily: "Poppins", needleColor: "#FFFFFF", dialColor: "#FFFFFF", hourNumberColor: "#FFFFFF", centerPointColor: "#FFFFFF", showWeather: false, style: 0)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), clockType: "digital", backgroundColor: "#000000", fontFamily: "Poppins", needleColor: "#FFFFFF", dialColor: "#FFFFFF", hourNumberColor: "#FFFFFF", centerPointColor: "#FFFFFF", showWeather: false, style: 0)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Get clock data from UserDefaults (shared with Flutter)
        let userDefaults = UserDefaults(suiteName: "group.com.moshaddaque.day07clockcraft")
        
        // Get basic clock properties
        let clockType = userDefaults?.string(forKey: "clockType") ?? "digital"
        let backgroundColor = userDefaults?.string(forKey: "backgroundColor") ?? "#000000"
        let fontFamily = userDefaults?.string(forKey: "fontFamily") ?? "Poppins"
        let needleColor = userDefaults?.string(forKey: "needleColor") ?? "#FFFFFF"
        let dialColor = userDefaults?.string(forKey: "dialColor") ?? "#FFFFFF"
        let hourNumberColor = userDefaults?.string(forKey: "hourNumberColor") ?? "#FFFFFF"
        let centerPointColor = userDefaults?.string(forKey: "centerPointColor") ?? "#FFFFFF"
        let showWeather = userDefaults?.bool(forKey: "showWeather") ?? false
        let style = userDefaults?.integer(forKey: "style") ?? 0
        
        // Check for time and date overrides from background updates
        let timeOverride = userDefaults?.string(forKey: "time")
        let dateOverride = userDefaults?.string(forKey: "date")

        // Generate a timeline consisting of entries a minute apart, starting from the current date.
        let currentDate = Date()
        for minuteOffset in 0 ..< 60 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
            let entry = SimpleEntry(
                date: entryDate,
                clockType: clockType,
                backgroundColor: backgroundColor,
                fontFamily: fontFamily,
                needleColor: needleColor,
                dialColor: dialColor,
                hourNumberColor: hourNumberColor,
                centerPointColor: centerPointColor,
                showWeather: showWeather,
                style: style,
                timeOverride: timeOverride,
                dateOverride: dateOverride
            )
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let clockType: String
    let backgroundColor: String
    let fontFamily: String
    let needleColor: String
    let dialColor: String
    let hourNumberColor: String
    let centerPointColor: String
    let showWeather: Bool
    let style: Int
    let timeOverride: String?
    let dateOverride: String?
    
    init(date: Date, clockType: String, backgroundColor: String, fontFamily: String, needleColor: String, dialColor: String, hourNumberColor: String, centerPointColor: String, showWeather: Bool, style: Int = 0, timeOverride: String? = nil, dateOverride: String? = nil) {
        self.date = date
        self.clockType = clockType
        self.backgroundColor = backgroundColor
        self.fontFamily = fontFamily
        self.needleColor = needleColor
        self.dialColor = dialColor
        self.hourNumberColor = hourNumberColor
        self.centerPointColor = centerPointColor
        self.showWeather = showWeather
        self.style = style
        self.timeOverride = timeOverride
        self.dateOverride = dateOverride
    }
}

struct ClockWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            // Background
            Color(hex: entry.backgroundColor)
                .edgesIgnoringSafeArea(.all)
            
            // Always show a clock based on the type
            if entry.clockType == "digital" || entry.date.timeIntervalSinceNow > 60 {
                // Digital Clock
                VStack {
                    Text(entry.timeOverride ?? formattedTime())
                        .font(getTimeFont())
                        .foregroundColor(Color(hex: entry.needleColor))
                        .shadow(color: getGlowColor(), radius: getGlowRadius(), x: 0, y: 0)
                    
                    Text(entry.dateOverride ?? formattedDate())
                        .font(getDateFont())
                        .foregroundColor(Color(hex: entry.hourNumberColor))
                    
                    if entry.showWeather {
                        HStack {
                            Image(systemName: "cloud.sun.fill")
                                .foregroundColor(Color(hex: entry.dialColor))
                                .font(.system(size: getWeatherIconSize()))
                            Text("25°C")
                                .foregroundColor(Color(hex: entry.dialColor))
                                .font(.system(size: getWeatherTextSize()))
                        }
                        .padding(.top, 8)
                    }
                }
            } else {
                // Analog Clock
                AnalogClockView(
                    date: entry.date,
                    needleColor: Color(hex: entry.needleColor),
                    dialColor: Color(hex: entry.dialColor),
                    hourNumberColor: Color(hex: entry.hourNumberColor),
                    centerPointColor: Color(hex: entry.centerPointColor)
                )
            }
        }
    }
    
    func formattedTime() -> String {
        let formatter = DateFormatter()
        
        // Check if we should use 24-hour format
        let userDefaults = UserDefaults(suiteName: "group.com.moshaddaque.day07clockcraft")
        let is24hour = userDefaults?.bool(forKey: "is24hour") ?? false
        
        formatter.dateFormat = is24hour ? "HH:mm" : "h:mm a"
        return formatter.string(from: entry.date)
    }
    
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMM d"
        return formatter.string(from: entry.date)
    }
    
    // Helper methods for styling based on clock style
    func getTimeFont() -> Font {
        switch entry.style {
        case 1: // Neon style
            return .system(size: 42, weight: .bold)
        case 2: // Minimal style
            return .system(size: 36, weight: .light)
        case 3: // Modern style
            return .system(size: 38, weight: .medium)
        default: // Default style
            return .system(size: 40, weight: .bold)
        }
    }
    
    func getDateFont() -> Font {
        switch entry.style {
        case 1: // Neon style
            return .system(size: 18, weight: .medium)
        case 2: // Minimal style
            return .system(size: 14, weight: .light)
        case 3: // Modern style
            return .system(size: 16, weight: .regular)
        default: // Default style
            return .system(size: 16, weight: .regular)
        }
    }
    
    func getGlowColor() -> Color {
        if entry.style == 1 { // Only Neon style has glow
            return Color(hex: entry.needleColor).opacity(0.7)
        }
        return Color.clear
    }
    
    func getGlowRadius() -> CGFloat {
        if entry.style == 1 { // Only Neon style has glow
            return 5.0
        }
        return 0.0
    }
    
    func getWeatherIconSize() -> CGFloat {
        switch entry.style {
        case 1: // Neon style
            return 18
        case 2: // Minimal style
            return 14
        case 3: // Modern style
            return 16
        default: // Default style
            return 16
        }
    }
    
    func getWeatherTextSize() -> CGFloat {
        switch entry.style {
        case 1: // Neon style
            return 16
        case 2: // Minimal style
            return 12
        case 3: // Modern style
            return 14
        default: // Default style
            return 14
        }
    }
}

struct AnalogClockView: View {
    let date: Date
    let needleColor: Color
    let dialColor: Color
    let hourNumberColor: Color
    let centerPointColor: Color
    
    var body: some View {
        ZStack {
            // Clock face
            Circle()
                .stroke(dialColor, lineWidth: 4)
                .padding(8)
            
            // Hour markers
            ForEach(0..<12) { hour in
                Rectangle()
                    .fill(hourNumberColor)
                    .frame(width: hour % 3 == 0 ? 4 : 2, height: hour % 3 == 0 ? 12 : 6)
                    .offset(y: -70)
                    .rotationEffect(.degrees(Double(hour) * 30))
            }
            
            // Hour hand
            Rectangle()
                .fill(needleColor)
                .frame(width: 4, height: 40)
                .offset(y: -20)
                .rotationEffect(.degrees(hourAngle()))
            
            // Minute hand
            Rectangle()
                .fill(needleColor)
                .frame(width: 3, height: 60)
                .offset(y: -30)
                .rotationEffect(.degrees(minuteAngle()))
            
            // Second hand
            Rectangle()
                .fill(Color.red)
                .frame(width: 1, height: 70)
                .offset(y: -35)
                .rotationEffect(.degrees(secondAngle()))
            
            // Center point
            Circle()
                .fill(centerPointColor)
                .frame(width: 12, height: 12)
        }
    }
    
    func hourAngle() -> Double {
        let calendar = Calendar.current
        let hour = Double(calendar.component(.hour, from: date) % 12)
        let minute = Double(calendar.component(.minute, from: date))
        return (hour * 30) + (minute * 0.5)
    }
    
    func minuteAngle() -> Double {
        let calendar = Calendar.current
        let minute = Double(calendar.component(.minute, from: date))
        let second = Double(calendar.component(.second, from: date))
        return (minute * 6) + (second * 0.1)
    }
    
    func secondAngle() -> Double {
        let calendar = Calendar.current
        let second = Double(calendar.component(.second, from: date))
        return second * 6
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct ClockWidget: Widget {
    let kind: String = "ClockWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ClockWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Clock Widget")
        .description("Display your custom clock on your home screen.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct ClockWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Default style
            ClockWidgetEntryView(entry: SimpleEntry(date: Date(), clockType: "digital", backgroundColor: "#000000", fontFamily: "Poppins", needleColor: "#FFFFFF", dialColor: "#FFFFFF", hourNumberColor: "#FFFFFF", centerPointColor: "#FFFFFF", showWeather: true, style: 0))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .previewDisplayName("Default Style")
            
            // Neon style
            ClockWidgetEntryView(entry: SimpleEntry(date: Date(), clockType: "digital", backgroundColor: "#000000", fontFamily: "Poppins", needleColor: "#00FFFF", dialColor: "#FFFFFF", hourNumberColor: "#FFFFFF", centerPointColor: "#FFFFFF", showWeather: true, style: 1))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .previewDisplayName("Neon Style")
            
            // Minimal style
            ClockWidgetEntryView(entry: SimpleEntry(date: Date(), clockType: "digital", backgroundColor: "#FFFFFF", fontFamily: "Poppins", needleColor: "#000000", dialColor: "#000000", hourNumberColor: "#555555", centerPointColor: "#000000", showWeather: false, style: 2))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .previewDisplayName("Minimal Style")
            
            // Analog clock
            ClockWidgetEntryView(entry: SimpleEntry(date: Date(), clockType: "analog", backgroundColor: "#000000", fontFamily: "Poppins", needleColor: "#FFFFFF", dialColor: "#FFFFFF", hourNumberColor: "#FFFFFF", centerPointColor: "#FFFFFF", showWeather: false, style: 0))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .previewDisplayName("Analog Clock")
        }
    }
}