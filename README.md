# Clock Craft

[![Flutter Version](https://img.shields.io/badge/Flutter-3.7.0+-blue.svg)](https://flutter.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A beautiful Flutter clock application with customizable home screen widgets for Android and iOS. Part of the 100 Days of Flutter Challenge (Day 7).

## 📱 Screenshots

<table>
  <tr>
    <td><img src="https://github.com/yourusername/day_07_clock_craft/raw/main/screenshots/digital_clock.png" width="200"></td>
    <td><img src="https://github.com/yourusername/day_07_clock_craft/raw/main/screenshots/analog_clock.png" width="200"></td>
    <td><img src="https://github.com/yourusername/day_07_clock_craft/raw/main/screenshots/widget_android.png" width="200"></td>
    <td><img src="https://github.com/yourusername/day_07_clock_craft/raw/main/screenshots/widget_ios.png" width="200"></td>
  </tr>
  <tr>
    <td align="center">Digital Clock</td>
    <td align="center">Analog Clock</td>
    <td align="center">Android Widget</td>
    <td align="center">iOS Widget</td>
  </tr>
</table>

> Note: Replace the placeholder screenshot URLs with actual screenshots after uploading them to your repository.

## ✨ Features

- **Multiple Clock Types**: Choose between analog and digital clocks
- **Extensive Customization**: Customize colors, styles, and display options
- **Save Designs**: Save your favorite clock designs for later use
- **Home Screen Widgets**: Display your custom clocks on your device's home screen
- **Weather Integration**: Option to display weather information alongside the clock
- **Multiple Clock Styles**: Choose from Neon, Minimal, Modern, and Default styles
- **24-Hour Format**: Toggle between 12-hour and 24-hour time formats
- **Background Updates**: Widgets update periodically in the background

## 🛠️ Technical Implementation

### Architecture

The app follows a clean architecture approach with:

- **Provider** for state management
- **Home Widget** package for implementing home screen widgets
- **Flutter Analog Clock** for analog clock rendering
- **Custom implementation** for digital clock display

### Widget Implementation

- **Android**: Uses AppWidgetProvider with RemoteViews
- **iOS**: Uses WidgetKit with SwiftUI

### Key Components

- `WidgetExpertService`: Manages widget updates and configuration
- `ClockProvider`: Manages clock state and persistence
- `ClockWidgetProvider.kt`: Android widget implementation
- `ClockWidget.swift`: iOS widget implementation

## 🚀 Getting Started

### Prerequisites

- Flutter 3.7.0 or higher
- Android 8.0+ for widget support
- iOS 14.0+ for widget support
- Xcode 12.0+ (for iOS development)
- Android Studio (for Android development)

### Installation

1. Clone the repository

```bash
git clone https://github.com/yourusername/day_07_clock_craft.git
cd day_07_clock_craft
```

2. Install dependencies

```bash
flutter pub get
```

3. Run the app

```bash
flutter run
```

## 🔧 Home Widget Setup

### Android

The app includes a home screen widget for Android that displays your custom clock design. To add the widget to your home screen:

1. Long press on your home screen
2. Select "Widgets"
3. Find "Clock Craft" in the widget list
4. Drag and drop it to your home screen

The widget will display the most recently saved clock design by default. You can update the widget by saving a new design in the app.

### iOS

The app includes a home screen widget for iOS that displays your custom clock design. To add the widget to your home screen:

1. Long press on your home screen
2. Tap the "+" button in the top-left corner
3. Find "Clock Craft" in the widget list
4. Choose the widget size (small or medium)
5. Tap "Add Widget"

The widget will display the most recently saved clock design by default. You can update the widget by saving a new design in the app.

## 📦 Dependencies

- [provider](https://pub.dev/packages/provider): ^6.1.5
- [google_fonts](https://pub.dev/packages/google_fonts): ^6.2.1
- [intl](https://pub.dev/packages/intl): ^0.20.2
- [screenshot](https://pub.dev/packages/screenshot): ^3.0.0
- [home_widget](https://pub.dev/packages/home_widget): ^0.8.0
- [path_provider](https://pub.dev/packages/path_provider): ^2.1.2
- [flutter_analog_clock](https://pub.dev/packages/flutter_analog_clock): ^1.0.3
- [flutter_glow](https://pub.dev/packages/flutter_glow): ^0.3.2
- [animated_bubble_background](https://pub.dev/packages/animated_bubble_background): ^0.0.1

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2023 Your Name

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 📱 100 Days of Flutter Challenge

This project is part of the 100 Days of Flutter Challenge, where I build a new Flutter application every day for 100 days to improve my skills and explore different Flutter capabilities.

## 📞 Contact

Your Name - [@moshaddaque](https://twitter.com/yourusername) - info.moshaddaque@gmail.com

Project Link: [https://github.com/yourusername/day_07_clock_craft](https://github.com/yourusername/day_07_clock_craft)
