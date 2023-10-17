import 'duration.dart';
import 'interval.dart';

/// Days (e.g., February 7, 2012 at 12:00 AM); typically 24 hours. Days in local
/// time may range from 23 to 25 hours due to daylight saving.
final timeDay = TimeInterval(
  (date) {
    return date.copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
  },
  (date, step) {
    return date.copyWith(
      day: date.day + step,
    );
  },
  (start, end) {
    return (end.millisecondsSinceEpoch -
            start.millisecondsSinceEpoch -
            (start.timeZoneOffset.inMilliseconds -
                end.timeZoneOffset.inMilliseconds)) /
        durationDay;
  },
);

/// Alias for [timeDay].range.
final timeDays = timeDay.range;
