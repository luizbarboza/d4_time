/// A calculator for humanity’s peculiar conventions of time.
///
/// When visualizing time series data, analyzing temporal patterns, or working
/// with time in general, the irregularities of conventional time units quickly
/// become apparent. In the
/// [Gregorian calendar](https://en.wikipedia.org/wiki/Gregorian_calendar), for
/// example, most months have 31 days but some have 28, 29 or 30; most years
/// have 365 days but [leap years](https://en.wikipedia.org/wiki/Leap_year) have
/// 366; and with
/// [daylight saving](https://en.wikipedia.org/wiki/Daylight_saving_time), most
/// days have 24 hours but some have 23 or 25. Adding to complexity, daylight
/// saving conventions vary around the world.
///
/// As a result of these temporal peculiarities, it can be difficult to perform
/// seemingly-trivial tasks. For example, if you want to compute the number of
/// days that have passed between two dates, you can’t simply subtract and
/// divide by 24 hours (86,400,000 ms):
///
/// ```dart
/// final start = DateTime(2015, 3, 01); // 2015-03-01T00:00
/// final end = new Date(2015, 4, 01); // 2015-04-01T00:00
/// final days = (end - start) / 864e5; // 30.958333333333332, oops! 🤯
/// ```
///
/// You can, however, use [timeDay].count:
///
/// ```dart
/// timeDay.count(start, end) // 31 😌
/// ```
///
/// The day interval is one of several provided by d4_time. Each interval
/// represents a conventional unit of time — hours, weeks, months, etc. — and
/// has methods to calculate boundary dates. For example, [timeDay] computes
/// midnight (typically 12:00 AM local time) of the corresponding day. In
/// addition to rounding and counting, intervals can also be used to generate
/// lists of boundary dates. For example, to compute each Sunday in the current
/// month:
///
/// ```dart
/// final start = timeMonth.floor(DateTime(2015, 1, 15)); // 2015-01-01T00:00
/// final stop = timeMonth.ceil(DateTime(2015, 1, 15)); // 2015-02-01T00:00
/// final weeks = timeWeek.range(start, stop); // [2015-01-04T00:00, 2015-01-11T00:00, 2015-01-18T00:00, 2015-01-25T00:00]
/// ```
///
/// The d4_time package does not implement its own calendaring system; it merely
/// implements a convenient API for calendar math on top of [DateTime]. Thus, it
/// ignores leap seconds and can only work with the local time zone and
/// [Coordinated Universal Time](https://en.wikipedia.org/wiki/Coordinated_Universal_Time)
/// (UTC).
///
/// This package is used by D4’s time scales to generate sensible ticks, by D4’s
/// time format, and can also be used directly to do things like
/// calendar layouts.
export 'src/d4_time.dart';
import 'src/d4_time.dart';
