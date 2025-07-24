import 'package:day_07_clock_craft/core/utils/time_utils.dart';
import 'package:day_07_clock_craft/data/models/clock_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:google_fonts/google_fonts.dart';

class DigitalClockWidget extends StatefulWidget {
  final ClockModel clock;
  const DigitalClockWidget({super.key, required this.clock});

  @override
  State<DigitalClockWidget> createState() => _DigitalClockWidgetState();
}

class _DigitalClockWidgetState extends State<DigitalClockWidget> {
  late Stream<DateTime> _timeStream;

  @override
  void initState() {
    super.initState();
    _timeStream = TimeUtils.getTimeStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _timeStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: const CircularProgressIndicator(),
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: widget.clock.backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              GlowText(
                TimeUtils.getFormattedTime(is24Hour: widget.clock.is24hour),
                style: GoogleFonts.getFont(
                  widget.clock.fontFamily,
                ).copyWith(fontSize: 32, color: widget.clock.needleColor),
              ),
              const SizedBox(height: 8),
              Text(
                TimeUtils.getFormattedDate(),
                style: GoogleFonts.getFont(widget.clock.fontFamily).copyWith(
                  fontSize: 16,
                  color: widget.clock.needleColor.withOpacity(0.7),
                ),
              ),
              if (widget.clock.showWeather)
                Icon(Icons.cloud, color: widget.clock.needleColor, size: 24),
            ],
          ),
        );
      },
    );
  }
}
