import 'day.dart';
import 'epoch.dart';
import 'minute.dart';
import 'week.dart';
import 'year.dart';

// TODO "field" is now and "epoch" argument, so documentation needs to be updated.

/// Time intervals provide a convenient and flexible API for date calculations
/// based on conventional or custom units of time on top of [DateTime].
class TimeInterval {
  final DateTime Function(DateTime) _floor;
  final DateTime Function(DateTime, int) _offset;
  final num Function(DateTime, DateTime)? _count;
  final DateTime? _epoch;

  /// Constructs a new custom interval given the specified [floor] and [offset]
  /// functions and an optional [count] function.
  ///
  /// ```dart
  /// final timeDay = TimeInterval(
  ///   (date) {
  ///     return date.copyWith(
  ///       hour: 0,
  ///       minute: 0,
  ///       second: 0,
  ///       millisecond: 0,
  ///       microsecond: 0,
  ///     );
  ///   },
  ///   (date, step) {
  ///     return date.copyWith(
  ///       day: date.day + step,
  ///     );
  ///   },
  ///   (start, end) {
  ///     return (end.millisecondsSinceEpoch -
  ///             start.millisecondsSinceEpoch -
  ///             (start.timeZoneOffset.inMilliseconds -
  ///                 end.timeZoneOffset.inMilliseconds)) /
  ///         86400000;
  ///   },
  /// );
  /// ```
  ///
  /// The [floor] function takes a single date as an argument and rounds it
  /// down to the nearest interval boundary.
  ///
  /// The [offset] function takes a date and an integer step as arguments and
  /// advances the specified date by the specified number of boundaries; the
  /// step may be positive, negative or zero.
  ///
  /// The optional count function takes a start date and an end date, already
  /// floored to the current interval, and returns the number of boundaries
  /// between the start (exclusive) and end (inclusive). If a [count] function
  /// is not specified, the returned interval does not support [count] or
  /// [every] methods, always returning null for each of them. Note: due to an
  /// internal optimization, the specified [count] function must not invoke
  /// [TimeInterval.count] on other time intervals.
  ///
  /// The optional field function takes a date, already floored to the current
  /// interval, and returns the field value of the specified date, corresponding
  /// to the number of boundaries between this date (exclusive) and the latest
  /// previous parent boundary. For example, for the [timeDay] interval, this
  /// returns the number of days since the start of the month. If a field
  /// function is not specified, it defaults to counting the number of interval
  /// boundaries since the UNIX epoch of January 1, 1970 UTC. The field function
  /// defines the behavior of [every].
  TimeInterval(DateTime Function(DateTime) floor,
      DateTime Function(DateTime, int) offset,
      [num Function(DateTime, DateTime)? count, DateTime? epoch])
      : _floor = floor,
        _offset = offset,
        _count = count,
        _epoch = epoch;

  /// Equivalent to [floor], except if [date] is not specified, it defaults to
  /// the current time.
  ///
  /// For example, [timeYear]\([date]) and timeYear.floor([date]) are
  /// equivalent.
  ///
  /// ```dart
  /// utcMonday(); // the latest preceding Monday, UTC time
  /// ```
  DateTime call([DateTime? date]) {
    return _floor(date ?? DateTime.timestamp());
  }

  /// Returns a new date representing the latest interval boundary date before
  /// or equal to date.
  ///
  /// For example, [timeDay].floor([date]) typically returns 12:00 AM on the
  /// given [date].
  ///
  /// ```dart
  /// utcMonday.floor(DateTime.timestamp()); // the latest preceding Monday, UTC time
  /// ```
  ///
  /// This method is idempotent: if the specified [date] is already floored to
  /// the current interval, a new date with an identical time is returned.
  /// Furthermore, the returned date is the minimum expressible value of the
  /// associated interval, such that *interval*.floor(*interval*.floor(*date*) -
  /// 1) returns the preceeding interval boundary date.
  DateTime floor(DateTime date) {
    return _floor(date);
  }

  /// Returns a new date representing the earliest interval boundary date after
  /// or equal to [date].
  ///
  /// For example, timeDay.ceil([date]) typically returns 12:00 AM on the date
  /// following the given date.
  ///
  /// ```dart
  /// utcMonday.ceil(DateTime;timestamp()); // the following Monday
  /// ```
  ///
  /// This method is idempotent: if the specified [date] is already ceilinged to
  /// the current interval, a new date with an identical time is returned.
  /// Furthermore, the returned date is the maximum expressible value of the
  /// associated interval, such that *interval*.ceil(*interval*.ceil([date]) +
  /// 1) returns the following interval boundary date.
  DateTime ceil(DateTime date) {
    return _floor(_offset(
        _floor(DateTime.fromMillisecondsSinceEpoch(
          date.millisecondsSinceEpoch - 1,
          isUtc: date.isUtc,
        )),
        1));
  }

  /// Returns a new date representing the closest interval boundary date to
  /// date.
  ///
  /// For example, [timeDay].round([date]) typically returns 12:00 AM on the
  /// given [date] if it is on or before noon, and 12:00 AM of the following day
  /// if it is after noon.
  ///
  /// ```dart
  /// utcMonday.round(DateTime.timestamp()); // the previous or following Monday, whichever is closer
  /// ```
  ///
  /// This method is idempotent: if the specified [date] is already rounded to
  /// the current interval, a new date with an identical time is returned.
  DateTime round(DateTime date) {
    final d0 = call(date), d1 = ceil(date);
    return date.difference(d0) < d1.difference(date) ? d0 : d1;
  }

  /// Returns a new date equal to [date] plus [step] intervals.
  ///
  /// ```dart
  /// utcDay.offset(DateTime.timestamp(), 1); // the same time tomorrow
  /// ```
  ///
  /// If [step] is not specified it defaults to 1. If [step] is negative, then
  /// the returned date will be before the specified [date]; if [step] is zero,
  /// then a copy of the specified [date] is returned; This method does not
  /// round the specified [date] to the interval. For example, if [date] is
  /// today at 5:34 PM, then [timeDay].offset([date], 1) returns 5:34 PM
  /// tomorrow (even if daylight saving changes!).
  DateTime offset(DateTime date, [int step = 1]) {
    return _offset(date, step);
  }

  /// Returns an list of dates representing every interval boundary after or
  /// equal to [start] (inclusive) and before [stop] (exclusive).
  ///
  /// ```dart
  /// utcDay.range(DateTime(2014, 1, 1), DateTime(2015, 1, 1)); // every day in 2014
  /// ```
  ///
  /// If [step] is specified, then every [step]th boundary will be returned; for
  /// example, for the [timeDay] interval a [step] of 2 will return every other
  /// day. If [step] is not an integer, it is floored with [num.floor].
  ///
  /// The first date in the returned list is the earliest boundary after or
  /// equal to [start]; subsequent dates are [offset] by [step] intervals and
  /// [floor]ed. Thus, two overlapping ranges may be consistent. For example,
  /// this range contains odd days:
  ///
  /// ```dart
  /// timeDay.range(DateTime(2015, 1, 1), DateTime(2015, 1, 7), 2); // [2015-01-01T00:00, 2015-01-03T00:00, 2015-01-05T00:00]
  /// ```
  ///
  /// While this contains even days:
  ///
  /// ```dart
  /// timeDay.range(DateTime(2015, 1, 2), DateTime(2015, 1, 8), 2); // [2015-01-02T00:00, 2015-01-04T00:00, 2015-01-06T00:00]
  /// ```
  ///
  /// To make ranges consistent when a [step] is specified, use [every] instead.
  ///
  /// For convenience, aliases for [range] are also provided as plural forms of
  /// the corresponding interval, such as [timeMondays].
  List<DateTime> range(DateTime start, DateTime stop, [num step = 1]) {
    final range = <DateTime>[];
    start = ceil(start);
    if (!(start.isBefore(stop)) ||
        !step.isFinite ||
        !((step = step.floor()) > 0)) return range;
    DateTime previous;
    do {
      range.add(previous = start);
      start = _floor(_offset(start, step as int));
    } while (previous.isBefore(start) && start.isBefore(stop));
    return range;
  }

  /// Returns a new interval that is a filtered subset of this interval using
  /// the specified [test] function.
  ///
  /// The [test] function is passed a date and should return true if and only if
  /// the specified date should be considered part of the interval. For example,
  /// to create an interval that returns the 1st, 11th, 21th and 31th (if it
  /// exists) of each month:
  ///
  /// ```dart
  /// timeDay.filter((d) => (d.day - 1).remainder(10) == 0);
  /// ```
  ///
  /// The returned filtered range does not support the [every] (another way of
  /// filtering) and [count] methods, always returning null for each of them.
  TimeInterval filter(bool Function(DateTime) test) {
    return TimeInterval((date) {
      while (!test(date = _floor(date))) {
        date = DateTime.fromMillisecondsSinceEpoch(
          date.millisecondsSinceEpoch - 1,
          isUtc: date.isUtc,
        );
      }
      return date;
    }, (date, step) {
      if (step < 0) {
        while (++step <= 0) {
          while (!test(date = _offset(date, -1))) {}
        }
      } else {
        while (--step >= 0) {
          while (!test(date = _offset(date, 1))) {}
        }
      }
      return date;
    });
  }

  /// Returns the number of interval boundaries after [start] (exclusive) and
  /// before or equal to [end] (inclusive).
  ///
  /// Note that this behavior is slightly different than [range] because its
  /// purpose is to return the zero-based number of the specified end date
  /// relative to the specified [start] date. For example, to compute the
  /// current zero-based day-of-year number:
  ///
  /// ```dart
  /// timeDay.count(timeYear(now), now) // 177
  /// ```
  ///
  /// Likewise, to compute the current zero-based week-of-year number for weeks
  /// that start on Sunday:
  ///
  /// ```dart
  /// timeSunday.count(timeYear(now), now) // 25
  /// ```
  int? count(DateTime start, DateTime end) {
    return _count != null ? _count!(_floor(start), _floor(end)).floor() : null;
  }

  /// Returns a filtered view of this interval representing every [step]th date.
  ///
  /// The meaning of [step] is dependent on this interval’s parent interval as
  /// defined by the field function. For example, [timeMinute].every(15) returns
  /// an interval representing every fifteen minutes, starting on the hour: :00,
  /// :15, :30, :45, etc. Note that for some intervals, the resulting dates may
  /// not be uniformly-spaced; timeDay’s parent interval is timeMonth, and thus
  /// the interval number resets at the start of each month. If [step] is not
  /// valid, returns null. If [step] is one, returns this interval.
  ///
  /// This method can be used in conjunction with [range] to ensure that two
  /// overlapping ranges are consistent. For example, this range contains odd
  /// days:
  ///
  /// ```dart
  /// timeDay.every(2).range(DateTime(2015, 1, 1), DateTime(2015, 1, 7)); // [2015-01-01T00:00, 2015-01-03T00:00, 2015-01-05T00:00]
  /// ```
  ///
  /// As does this one:
  ///
  /// ```dart
  /// timeDay.every(2).range(DateTime(2015, 1, 2), new Date(2015, 1, 8)) // [2015-01-03T00:00, 2015-01-05T00:00, 2015-01-07T00:00]
  /// ```
  ///
  /// The returned filtered range does not support the [filter] (another way of
  /// filtering) and [count] methods, always returning null for each of them.
  TimeInterval? every(num step) {
    return _count == null || !step.isFinite || !((step = step.floor()) > 0)
        ? null
        : !(step > 1)
            ? this
            : filter((d) =>
                count(_epoch ?? (d.isUtc ? utcEpoch : timeEpoch), d)!
                    .remainder(step) ==
                0);
  }
}
