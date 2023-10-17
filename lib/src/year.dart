import 'interval.dart';

/// Years (e.g., January 1, 2012 at 12:00 AM); ranges from 365 to 366 days.
final timeYear = _TimeYear();

class _TimeYear extends TimeInterval {
  _TimeYear()
      : super(
          (date) {
            return date.copyWith(
              month: 1,
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
              year: date.year + step,
            );
          },
          (start, end) {
            return end.year - start.year;
          },
        );

  @override
  every(k) {
    return !k.isFinite || !((k = k.floor()) > 0)
        ? null
        : TimeInterval(
            (date) {
              return date.copyWith(
                year: (date.year / k).floor() * k as int,
                month: 1,
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
                year: date.year + step * k as int,
              );
            },
          );
  }
}

/// Alias for [timeYear].range.
final timeYears = timeYear.range;
