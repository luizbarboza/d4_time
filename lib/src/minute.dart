import 'duration.dart';
import 'interval.dart';

/// Minutes (e.g., 01:02:00 AM); 60 seconds. Note that [DateTime] class
/// [ignores leap seconds](https://api.dart.dev/stable/3.1.3/dart-core/Duration/secondsPerMinute-constant.html).
final timeMinute = TimeInterval(
  (date) {
    return DateTime.fromMillisecondsSinceEpoch(
      date.millisecondsSinceEpoch -
          date.millisecond -
          date.second * durationSecond,
      isUtc: date.isUtc,
    );
  },
  (date, step) {
    return DateTime.fromMillisecondsSinceEpoch(
      date.millisecondsSinceEpoch + step * durationMinute,
      isUtc: date.isUtc,
    );
  },
  (start, end) {
    return (end.millisecondsSinceEpoch - start.millisecondsSinceEpoch) /
        durationMinute;
  },
);

/// Alias for [timeMinute].range.
final timeMinutes = timeMinute.range;
