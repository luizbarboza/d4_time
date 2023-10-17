import 'interval.dart';

/// Milliseconds; the shortest available time unit.
final timeMillisecond = _TimeMillisecond();

class _TimeMillisecond extends TimeInterval {
  _TimeMillisecond()
      : super(
          (date) {
            return DateTime.fromMillisecondsSinceEpoch(
              date.millisecondsSinceEpoch,
              isUtc: date.isUtc,
            );
          },
          (date, step) {
            return DateTime.fromMillisecondsSinceEpoch(
              date.millisecondsSinceEpoch + step,
              isUtc: date.isUtc,
            );
          },
          (start, end) {
            return end.millisecondsSinceEpoch - start.millisecondsSinceEpoch;
          },
        );

  @override
  every(k) {
    if (!k.isFinite || !((k = k.floor()) > 0)) return null;
    if (!(k > 1)) return timeMillisecond;
    return TimeInterval(
      (date) {
        return DateTime.fromMillisecondsSinceEpoch(
          (date.millisecondsSinceEpoch / k).floor() * k as int,
          isUtc: date.isUtc,
        );
      },
      (date, step) {
        return DateTime.fromMillisecondsSinceEpoch(
          date.millisecondsSinceEpoch + step * k as int,
          isUtc: date.isUtc,
        );
      },
      (start, end) {
        return (end.millisecondsSinceEpoch - start.millisecondsSinceEpoch) / k;
      },
    );
  }
}

/// Alias for [timeMillisecond].range.
final timeMilliseconds = timeMillisecond.range;
