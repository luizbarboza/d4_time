import 'duration.dart';
import 'interval.dart';

TimeInterval _timeWeekday(int i) {
  return TimeInterval(
    (date) {
      return date.copyWith(
        day: date.day - (date.weekday + 7 - i).remainder(7),
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      );
    },
    (date, step) {
      return date.copyWith(
        day: date.day + step * 7,
      );
    },
    (start, end) {
      return (end.millisecondsSinceEpoch -
              start.millisecondsSinceEpoch -
              (start.timeZoneOffset.inMilliseconds -
                  end.timeZoneOffset.inMilliseconds)) /
          durationWeek;
    },
  );
}

/// Alias for [timeSunday]; 7 days and typically 168 hours. Weeks in local time
/// may range from 167 to 169 hours due to daylight saving.
final timeWeek = timeSunday;

/// Sunday-based weeks (e.g., February 5, 2012 at 12:00 AM).
final timeSunday = _timeWeekday(0);

/// Monday-based weeks (e.g., February 6, 2012 at 12:00 AM).
final timeMonday = _timeWeekday(1);

/// Tuesday-based weeks (e.g., February 7, 2012 at 12:00 AM).
final timeTuesday = _timeWeekday(2);

/// Wednesday-based weeks (e.g., February 8, 2012 at 12:00 AM).
final timeWednesday = _timeWeekday(3);

/// Thursday-based weeks (e.g., February 9, 2012 at 12:00 AM).
final timeThursday = _timeWeekday(4);

/// Friday-based weeks (e.g., February 10, 2012 at 12:00 AM).
final timeFriday = _timeWeekday(5);

/// Saturday-based weeks (e.g., February 11, 2012 at 12:00 AM).
final timeSaturday = _timeWeekday(6);

/// Alias for [timeWeeks].range.
final timeWeeks = timeSundays;

/// Alias for [timeSundays].range.
final timeSundays = timeSunday.range;

/// Alias for [timeMondays].range.
final timeMondays = timeMonday.range;

/// Alias for [timeTuesdays].range.
final timeTuesdays = timeTuesday.range;

/// Alias for [timeWednesdays].range.
final timeWednesdays = timeWednesday.range;

/// Alias for [timeThursdays].range.
final timeThursdays = timeThursday.range;

/// Alias for [timeFridays].range.
final timeFridays = timeFriday.range;

/// Alias for [timeSaturdays].range.
final timeSaturdays = timeSaturday.range;
