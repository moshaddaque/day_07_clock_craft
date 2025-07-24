import 'package:day_07_clock_craft/data/models/clock_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';

class AnalogClockWidget extends StatelessWidget {
  final ClockModel clock;
  const AnalogClockWidget({super.key, required this.clock});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: AnalogClock(
        dateTime: DateTime.now(),
        dialBorderColor: clock.backgroundColor,
        dialColor: clock.dialColor,
        hourHandColor: clock.needleColor,
        minuteHandColor: clock.needleColor,
        secondHandColor: clock.needleColor,
        hourNumberColor: clock.hourNumberColor,
        centerPointColor: clock.centerPointColor,
        isKeepTime: true,
      ),
    );
  }
}
