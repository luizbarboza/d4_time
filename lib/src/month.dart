import 'interval.dart';

/// Months (e.g., February 1, 2012 at 12:00 AM); ranges from 28 to 31 days.
final timeMonth = TimeInterval(
  (date) {
    return date.copyWith(
      day: 1,
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
  },
  (date, step) {
    return date.copyWith(
      month: date.month + step,
    );
  },
  (start, end) {
    return (end.month - start.month + (end.year - start.year) * 12);
  },
);

/// Alias for [timeMonth].range.
final timeMonths = timeMonth.range;
