import 'dart:async';

import 'package:day_07_clock_craft/presentation/pages/home_page.dart';
import 'package:day_07_clock_craft/provider/clock_provider.dart';
import 'package:day_07_clock_craft/services/widget_expert_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_widget/home_widget.dart';
import 'package:provider/provider.dart';

// Register the background callback handler
@pragma('vm:entry-point')
void backgroundCallback(Uri? uri) async {
  if (uri?.host == 'updatewidget') {
    await WidgetExpertService.updateWidgetsFromBackground();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the home widget service
  await WidgetExpertService.initHomeWidget();

  // Set the app group ID for iOS
  await HomeWidget.setAppGroupId('group.com.moshaddaque.day07clockcraft');

  // Register the background callback
  HomeWidget.registerBackgroundCallback(backgroundCallback);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Set up periodic widget updates
    _setupPeriodicUpdates();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Update widgets when app is resumed
      WidgetExpertService.updateWidgetsFromBackground();
    }
  }

  void _setupPeriodicUpdates() {
    // Set up the app group ID and register background callback
    HomeWidget.setAppGroupId('group.com.moshaddaque.day07clockcraft');
    HomeWidget.registerBackgroundCallback(backgroundCallback);

    // Listen for widget click events
    HomeWidget.widgetClicked.listen((uri) {
      debugPrint('Widget clicked: ${uri?.toString()}');
      if (uri?.host == 'updatewidget') {
        WidgetExpertService.updateWidgetsFromBackground();
      }
    });

    // Update widgets immediately when app starts
    WidgetExpertService.updateWidgetsFromBackground();

    // Set up a timer to update widgets periodically when app is in foreground
    Timer.periodic(const Duration(minutes: 1), (timer) {
      WidgetExpertService.updateWidgetsFromBackground();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ClockProvider())],
      child: MaterialApp(
        title: 'Clock Craft',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.poppinsTextTheme(),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
