import 'duration.dart';
import 'epoch.dart';
import 'interval.dart';

/// Seconds in local time (e.g., 01:23:45.0000 AM); 1,000 milliseconds.
final timeSecond = TimeInterval(
  (date) {
    return DateTime.fromMillisecondsSinceEpoch(
      date.millisecondsSinceEpoch - date.millisecond,
      isUtc: date.isUtc,
    );
  },
  (date, step) {
    return DateTime.fromMillisecondsSinceEpoch(
      date.millisecondsSinceEpoch + step * durationSecond,
      isUtc: date.isUtc,
    );
  },
  (start, end) {
    return (end.millisecondsSinceEpoch - start.millisecondsSinceEpoch) /
        durationSecond;
  },
  utcEpoch,
);

/// Alias for [timeSecond].range.
final timeSeconds = timeSecond.range;
