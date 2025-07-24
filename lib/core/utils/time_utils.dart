import 'package:intl/intl.dart';

class TimeUtils {
  static String getFormattedTime({bool is24Hour = false}) {
    final now = DateTime.now();
    return is24Hour
        ? DateFormat('HH:mm:ss').format(now)
        : DateFormat('hh:mm:ss a').format(now);
  }

  static String getFormattedDate() {
    return DateFormat('EEEE, MMMM d').format(DateTime.now());
  }

  static Stream<DateTime> getTimeStream() {
    return Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
  }
}
