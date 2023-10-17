import 'duration.dart';
import 'interval.dart';

/// Hours (e.g., 01:00 AM); 60 minutes. Note that advancing time by one hour in
/// local time can return the same hour or skip an hour due to daylight saving.
final timeHour = TimeInterval(
  (date) {
    return DateTime.fromMillisecondsSinceEpoch(
      date.millisecondsSinceEpoch -
          date.millisecond -
          date.second * durationSecond -
          date.minute * durationMinute,
      isUtc: date.isUtc,
    );
  },
  (date, step) {
    return DateTime.fromMillisecondsSinceEpoch(
      date.millisecondsSinceEpoch + step * durationHour,
      isUtc: date.isUtc,
    );
  },
  (start, end) {
    return (end.millisecondsSinceEpoch - start.millisecondsSinceEpoch) /
        durationHour;
  },
);

/// Alias for [timeHour].range.
final timeHours = timeHour.range;
