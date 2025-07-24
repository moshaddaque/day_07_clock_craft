package com.moshaddaque.day_07_clock_craft

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.SharedPreferences
import android.graphics.Color
import android.view.View
import android.widget.RemoteViews
import org.json.JSONObject
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

/**
 * Implementation of App Widget functionality for Clock Craft app.
 */
class ClockWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    companion object {
        private const val PREFS_NAME = "FlutterSharedPreferences"
        private const val CLOCK_DATA_KEY = "flutter.clockData"
        private const val TIME_KEY = "flutter.time"
        private const val DATE_KEY = "flutter.date"

        internal fun updateAppWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int
        ) {
            // Get the shared preferences where Flutter stores the widget data
            val prefs: SharedPreferences = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
            
            // Get the clock data, time and date from shared preferences
            val clockDataString = prefs.getString(CLOCK_DATA_KEY, null)
            val timeString = prefs.getString(TIME_KEY, getCurrentTime())
            val dateString = prefs.getString(DATE_KEY, getCurrentDate())
            
            // Create a new RemoteViews object for the app widget layout
            val views = RemoteViews(context.packageName, R.layout.clock_widget)
            
            // Set date (use override if available)
            views.setTextViewText(R.id.widget_date, dateString)
            
            // Default time display (will be overridden if we have clock data)
            views.setTextViewText(R.id.widget_time, timeString ?: getCurrentTime())
            
            // If we have clock data, customize the widget appearance
            if (clockDataString != null) {
                try {
                    val clockData = JSONObject(clockDataString)
                    
                    // Get clock type (0 = digital, 1 = analog)
            val clockType = clockData.optInt("type", 0)
            val clockTypeStr = prefs.getString("flutter.clockType", "digital")
            
            // Get colors
            val backgroundColor = clockData.optInt("backgroundColor", Color.BLACK)
            val textColor = clockData.optInt("needleColor", Color.WHITE)
            val hourNumberColor = clockData.optInt("hourNumberColor", Color.WHITE)
            
            // Get font family and format preferences
            val is24hour = clockData.optBoolean("is24hour", false)
            
            // Set background color
            views.setInt(R.id.widget_container, "setBackgroundColor", backgroundColor)
            
            // Set text colors
            views.setTextColor(R.id.widget_time, textColor)
            views.setTextColor(R.id.widget_date, hourNumberColor)
            
            // Update time format based on preference
            val formattedTime = timeString ?: getCurrentTime(is24hour)
            views.setTextViewText(R.id.widget_time, formattedTime)
            
            // Show/hide elements based on clock type
            // Always show digital clock for widget
            // Analog clocks are not well supported in Android widgets without custom implementation
            views.setViewVisibility(R.id.widget_analog_clock, View.GONE)
            views.setViewVisibility(R.id.widget_digital_container, View.VISIBLE)
            
            // Show weather if enabled
            val showWeather = clockData.optBoolean("showWeather", false)
            views.setViewVisibility(R.id.widget_weather_icon, if (showWeather) View.VISIBLE else View.GONE)
            
            // Apply text style based on clock style
            val style = clockData.optInt("style", 0)
            when (style) {
                1 -> { // Neon style
                    views.setFloat(R.id.widget_time, "setTextSize", 36f)
                    views.setFloat(R.id.widget_date, "setTextSize", 16f)
                }
                2, 3 -> { // Minimal or Modern
                    views.setFloat(R.id.widget_time, "setTextSize", 32f)
                    views.setFloat(R.id.widget_date, "setTextSize", 14f)
                }
                else -> { // Default
                    views.setFloat(R.id.widget_time, "setTextSize", 32f)
                    views.setFloat(R.id.widget_date, "setTextSize", 14f)
                }
            }
                    
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
            
            // Tell the AppWidgetManager to perform an update on the current app widget
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
        
        private fun getCurrentTime(is24hour: Boolean = false): String {
            val timeFormat = if (is24hour) "HH:mm" else "hh:mm a"
            val dateFormat = SimpleDateFormat(timeFormat, Locale.getDefault())
            return dateFormat.format(Date())
        }
        
        private fun getCurrentDate(): String {
            val dateFormat = SimpleDateFormat("EEE, MMM d", Locale.getDefault())
            return dateFormat.format(Date())
        }
    }
}