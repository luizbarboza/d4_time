import 'dart:math' as math;

import 'package:d4_array/d4_array.dart';

import 'day.dart';
import 'duration.dart';
import 'hour.dart';
import 'interval.dart';
import 'millisecond.dart';
import 'minute.dart';
import 'month.dart';
import 'second.dart';
import 'week.dart';
import 'year.dart';

final _tickIntervals = <(TimeInterval, int, int)>[
  (timeSecond, 1, durationSecond),
  (timeSecond, 5, 5 * durationSecond),
  (timeSecond, 15, 15 * durationSecond),
  (timeSecond, 30, 30 * durationSecond),
  (timeMinute, 1, durationMinute),
  (timeMinute, 5, 5 * durationMinute),
  (timeMinute, 15, 15 * durationMinute),
  (timeMinute, 30, 30 * durationMinute),
  (timeHour, 1, durationHour),
  (timeHour, 3, 3 * durationHour),
  (timeHour, 6, 6 * durationHour),
  (timeHour, 12, 12 * durationHour),
  (timeDay, 1, durationDay),
  (timeDay, 2, 2 * durationDay),
  (timeWeek, 1, durationWeek),
  (timeMonth, 1, durationMonth),
  (timeMonth, 3, 3 * durationMonth),
  (timeYear, 1, durationYear)
];

List<DateTime> _timeSeq(DateTime start, DateTime stop, Object countOrInterval) {
  final reversed = stop.isBefore(start);
  if (reversed) [start, stop] = [stop, start];
  final interval = countOrInterval is TimeInterval
      ? countOrInterval
      : timeTickInterval(start, stop, countOrInterval as num);
  final ticks = interval?.range(
          start,
          DateTime.fromMillisecondsSinceEpoch(
            stop.millisecondsSinceEpoch + 1, // inclusive stop
            isUtc: stop.isUtc,
          )) ??
      [];
  return reversed ? reverse(ticks) : ticks;
}

/// Returns an list of approximately [count] dates at regular intervals between
/// [start] and [stop] (inclusive).
///
/// If [stop] is before [start], dates are returned in reverse chronological
/// order; otherwise dates are returned in chronological order. The following
/// time intervals are considered:
///
/// * 1 second
/// * 5 seconds
/// * 15 seconds
/// * 30 seconds
/// * 1 minute
/// * 5 minutes
/// * 15 minutes
/// * 30 minutes
/// * 1 hour
/// * 3 hours
/// * 6 hours
/// * 12 hours
/// * 1 day
/// * 2 days
/// * 1 week
/// * 1 month
/// * 3 months
/// * 1 year
///
/// Multiples of milliseconds (for small ranges) and years (for large ranges)
/// are also considered, following the rules of [ticks]. The interval producing
/// the number of dates that is closest to [count] is used. For example:
///
/// ```dart
/// final start = DateTime(1970, 3, 1);
/// final stop = DateTime(1996, 3, 19);
/// final count = 4;
/// final ticks = timeTicks(start, stop, count); // [1975-01-01, 1980-01-01, 1985-01-01, 1990-01-01, 1995-01-01]
/// ```
///
/// See also [timeRange].
List<DateTime> timeTicks(DateTime start, DateTime stop, num count) =>
    _timeSeq(start, stop, count);

/// Equivalent to [timeTicks], but takes a time [interval] instead of count.
///
/// This method behaves similarly to [TimeInterval.range] except that both
/// [start] and [stop] are inclusive and it may return dates in reverse
/// chronological order if [stop] is before [start].
List<DateTime> timeRange(
        DateTime start, DateTime stop, TimeInterval interval) =>
    _timeSeq(start, stop, interval);

/// Returns the time interval that would be used by [timeTicks] given the same
/// arguments.
TimeInterval? timeTickInterval(DateTime start, DateTime stop, num count) {
  final target =
      (stop.millisecondsSinceEpoch - start.millisecondsSinceEpoch).abs() /
          count;
  final i = bisectRight(map(_tickIntervals, (i) => i.$3), target);
  if (i == _tickIntervals.length) {
    return timeYear.every(tickStep(start.millisecondsSinceEpoch / durationYear,
        stop.millisecondsSinceEpoch / durationYear, count));
  }
  if (i == 0) {
    return timeMillisecond.every(math.max(
        tickStep(
            start.millisecondsSinceEpoch, stop.millisecondsSinceEpoch, count),
        1));
  }
  final (t, step, _) = _tickIntervals[
      target / _tickIntervals[i - 1].$3 < _tickIntervals[i].$3 / target
          ? i - 1
          : i];
  return t.every(step);
}
