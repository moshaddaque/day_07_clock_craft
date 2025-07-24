import 'dart:convert';
import 'dart:ui';

import 'package:day_07_clock_craft/data/models/clock_model.dart';
import 'package:day_07_clock_craft/provider/clock_provider.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WidgetExpertService {
  static const String appGroupId = 'group.com.moshaddaque.day07clockcraft';
  static const String androidWidgetName = 'ClockWidgetProvider';
  static const String iOSWidgetName = 'ClockWidget';

  // Initialize the home widget service
  static Future<void> initHomeWidget() async {
    await HomeWidget.setAppGroupId(appGroupId);
    
    // Schedule periodic updates
    await schedulePeriodicUpdates();
  }
  
  // Schedule periodic updates for the widget
  static Future<void> schedulePeriodicUpdates() async {
    try {
      // Schedule updates every 30 minutes
      final androidRefreshRate = const Duration(minutes: 30);
      final iosRefreshRate = const Duration(minutes: 30);
      
      // Set up the update URI
      const updateUri = 'homewidget://updatewidget';
      
      // Save current time and date to widget data
      await updateWidgetsFromBackground();
      
      // Schedule for Android
      await HomeWidget.updateWidget(
        name: androidWidgetName,
        androidName: 'ClockWidgetProvider',
        qualifiedAndroidName: 'com.moshaddaque.day_07_clock_craft.ClockWidgetProvider',
      );
      
      // Schedule for iOS
      await HomeWidget.updateWidget(
        name: iOSWidgetName,
        iOSName: 'ClockWidget',
      );
      
      // Set up periodic updates
      await HomeWidget.saveWidgetData<String>('lastUpdated', DateTime.now().toIso8601String());
      
      debugPrint('Scheduled periodic widget updates');
    } catch (e) {
      debugPrint('Error scheduling periodic updates: $e');
    }
  }

  // Update the widget with the current clock data
  static Future<void> updateClockWidget(ClockModel clock) async {
    try {
      // Convert clock model to a map that can be stored in the widget
      final Map<String, dynamic> clockData = {
        'type': clock.type.index,
        'style': clock.style.index,
        'backgroundColor': clock.backgroundColor.value,
        'needleColor': clock.needleColor.value,
        'dialColor': clock.dialColor.value,
        'hourNumberColor': clock.hourNumberColor.value,
        'centerPointColor': clock.centerPointColor.value,
        'fontFamily': clock.fontFamily,
        'is24hour': clock.is24hour,
        'showWeather': clock.showWeather,
        'lastUpdated': DateTime.now().millisecondsSinceEpoch,
      };

      // Save the clock data to the widget
      await HomeWidget.saveWidgetData<String>(
        'clockData',
        jsonEncode(clockData),
      );
      
      // Save individual properties for easier access in native widgets
      await HomeWidget.saveWidgetData<String>('clockType', clock.type == ClockType.digital ? 'digital' : 'analog');
      await HomeWidget.saveWidgetData<int>('backgroundColor', clock.backgroundColor.value);
      await HomeWidget.saveWidgetData<int>('needleColor', clock.needleColor.value);
      await HomeWidget.saveWidgetData<int>('dialColor', clock.dialColor.value);
      await HomeWidget.saveWidgetData<int>('hourNumberColor', clock.hourNumberColor.value);
      await HomeWidget.saveWidgetData<int>('centerPointColor', clock.centerPointColor.value);
      await HomeWidget.saveWidgetData<String>('fontFamily', clock.fontFamily);
      await HomeWidget.saveWidgetData<bool>('is24hour', clock.is24hour);
      await HomeWidget.saveWidgetData<bool>('showWeather', clock.showWeather);

      // Update time data
      final now = DateTime.now();
      await HomeWidget.saveWidgetData<String>(
        'time',
        DateFormat(clock.is24hour ? 'HH:mm' : 'hh:mm a').format(now),
      );
      await HomeWidget.saveWidgetData<String>(
        'date',
        DateFormat('EEE, MMM d').format(now),
      );

      // Update the widget
      await _updateWidget();
    } catch (e) {
      debugPrint('Error updating clock widget: $e');
    }
  }

  // Update all saved clocks to the widget
  static Future<void> updateAllSavedClocks(BuildContext context) async {
    try {
      final clockProvider = Provider.of<ClockProvider>(context, listen: false);
      final savedClocks = clockProvider.savedClock;

      if (savedClocks.isEmpty) {
        return;
      }

      // Save the list of saved clocks
      final List<Map<String, dynamic>> clocksData = savedClocks.map((clock) => {
        'type': clock.type.index,
        'style': clock.style.index,
        'backgroundColor': clock.backgroundColor.value,
        'needleColor': clock.needleColor.value,
        'dialColor': clock.dialColor.value,
        'hourNumberColor': clock.hourNumberColor.value,
        'centerPointColor': clock.centerPointColor.value,
        'fontFamily': clock.fontFamily,
        'is24hour': clock.is24hour,
        'showWeather': clock.showWeather,
      }).toList();

      await HomeWidget.saveWidgetData<String>(
        'savedClocks',
        jsonEncode(clocksData),
      );
      
      // If there are saved clocks, update the widget with the first one
      if (savedClocks.isNotEmpty) {
        await updateClockWidget(savedClocks[0]);
      }

      // Update the widget
      await _updateWidget();
    } catch (e) {
      debugPrint('Error updating all saved clocks: $e');
    }
  }

  // Private method to update the widget on both platforms
  static Future<void> _updateWidget() async {
    try {
      // Update Android widget
      await HomeWidget.updateWidget(
        name: androidWidgetName,
        androidName: 'ClockWidgetProvider',
      );

      // Update iOS widget
      await HomeWidget.updateWidget(
        name: iOSWidgetName,
        iOSName: 'ClockWidget',
      );
    } catch (e) {
      debugPrint('Error updating widget: $e');
    }
  }
  
  // Update widgets from background callback
  static Future<void> updateWidgetsFromBackground() async {
    try {
      // Update time data
      final now = DateTime.now();
      
      // Get clock preferences from storage
      final clockTypeStr = await HomeWidget.getWidgetData<String>('clockType') ?? 'digital';
      final is24hour = await HomeWidget.getWidgetData<bool>('is24hour') ?? false;
      
      // Update time and date
      await HomeWidget.saveWidgetData<String>(
        'time',
        DateFormat(is24hour ? 'HH:mm' : 'hh:mm a').format(now),
      );
      await HomeWidget.saveWidgetData<String>(
        'date',
        DateFormat('EEE, MMM d').format(now),
      );
      
      // Update the widgets
      await _updateWidget();
    } catch (e) {
      debugPrint('Error updating widgets from background: $e');
    }
  }
}