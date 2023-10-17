import 'package:d4_time/d4_time.dart';
import 'package:test/test.dart';

import 'date.dart';

void main() {
  test(
      "timeMillisecond.every(step) returns every stepth millisecond, starting with the first millisecond of the second",
      () {
    expect(
        timeMillisecond.every(50)!.range(local(2008, 11, 30, 12, 36, 0, 947),
            local(2008, 11, 30, 12, 36, 1, 157)),
        [
          local(2008, 11, 30, 12, 36, 0, 950),
          local(2008, 11, 30, 12, 36, 1, 0),
          local(2008, 11, 30, 12, 36, 1, 50),
          local(2008, 11, 30, 12, 36, 1, 100),
          local(2008, 11, 30, 12, 36, 1, 150)
        ]);
    expect(
        timeMillisecond.every(100)!.range(local(2008, 11, 30, 12, 36, 0, 947),
            local(2008, 11, 30, 12, 36, 1, 157)),
        [
          local(2008, 11, 30, 12, 36, 1, 0),
          local(2008, 11, 30, 12, 36, 1, 100)
        ]);
    expect(
        timeMillisecond.every(50)!.range(utc(2008, 11, 30, 12, 36, 0, 947),
            utc(2008, 11, 30, 12, 36, 1, 157)),
        [
          utc(2008, 11, 30, 12, 36, 0, 950),
          utc(2008, 11, 30, 12, 36, 1, 0),
          utc(2008, 11, 30, 12, 36, 1, 50),
          utc(2008, 11, 30, 12, 36, 1, 100),
          utc(2008, 11, 30, 12, 36, 1, 150)
        ]);
    expect(
        timeMillisecond.every(100)!.range(utc(2008, 11, 30, 12, 36, 0, 947),
            utc(2008, 11, 30, 12, 36, 1, 157)),
        [utc(2008, 11, 30, 12, 36, 1, 0), utc(2008, 11, 30, 12, 36, 1, 100)]);
  });
}
