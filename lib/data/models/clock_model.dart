import 'package:flutter/material.dart';

enum ClockType { digital, analog }

enum ClockStyle { flip, neon, minimal, modern, classic, wooden, transparent }

class ClockModel {
  final ClockType type;
  final ClockStyle style;
  final Color backgroundColor;
  final String fontFamily;
  final bool is24hour;
  final bool showWeather;
  final String? backgroundImage;
  final Color needleColor;
  final Color dialColor;
  final Color hourNumberColor;
  final Color centerPointColor;

  ClockModel({
    required this.type,
    required this.style,
    this.backgroundColor = Colors.black,
    this.fontFamily = 'Roboto',
    this.is24hour = false,
    this.showWeather = false,
    this.backgroundImage,
    this.needleColor = Colors.white,
    this.dialColor = Colors.white,
    this.hourNumberColor = Colors.white,
    this.centerPointColor = Colors.white,
  });

  ClockModel copyWith({
    ClockType? type,
    ClockStyle? style,
    Color? backgroundColor,
    String? fontFamily,
    bool? is24hour,
    bool? showWeather,
    String? backgroundImage,
    Color? needleColor,
    Color? dialColor,
    Color? hourNumberColor,
    Color? centerPointColor,
  }) {
    return ClockModel(
      type: type ?? this.type,
      style: style ?? this.style,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fontFamily: fontFamily ?? this.fontFamily,
      is24hour: is24hour ?? this.is24hour,
      showWeather: showWeather ?? this.showWeather,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      needleColor: needleColor ?? this.needleColor,
      dialColor: dialColor ?? this.dialColor,
      hourNumberColor: hourNumberColor ?? this.hourNumberColor,
      centerPointColor: centerPointColor ?? this.centerPointColor,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ClockModel &&
        other.type == type &&
        other.style == style &&
        other.backgroundColor.value == backgroundColor.value &&
        other.fontFamily == fontFamily &&
        other.is24hour == is24hour &&
        other.showWeather == showWeather &&
        other.backgroundImage == backgroundImage &&
        other.needleColor.value == needleColor.value &&
        other.dialColor.value == dialColor.value &&
        other.hourNumberColor.value == hourNumberColor.value &&
        other.centerPointColor.value == centerPointColor.value;
  }

  @override
  int get hashCode => Object.hash(
        type,
        style,
        backgroundColor.value,
        fontFamily,
        is24hour,
        showWeather,
        backgroundImage,
        needleColor.value,
        dialColor.value,
        hourNumberColor.value,
        centerPointColor.value,
      );
}
