import 'package:d4_time/d4_time.dart';
import 'package:test/test.dart';

import 'date.dart';

void main() {
  test("timeSaturdays in an alias for timeSaturday.range", () {
    expect(timeSaturdays, timeSaturday.range);
  });

  test("timeSaturday.floor(date) returns Saturdays", () {
    expect(timeSaturday.floor(utc(2011, 0, 6, 23, 59, 59)), utc(2011, 0, 1));
    expect(timeSaturday.floor(utc(2011, 0, 7, 0, 0, 0)), utc(2011, 0, 1));
    expect(timeSaturday.floor(utc(2011, 0, 7, 0, 0, 1)), utc(2011, 0, 1));
    expect(timeSaturday.floor(utc(2011, 0, 7, 23, 59, 59)), utc(2011, 0, 1));
    expect(timeSaturday.floor(utc(2011, 0, 8, 0, 0, 0)), utc(2011, 0, 8));
    expect(timeSaturday.floor(utc(2011, 0, 8, 0, 0, 1)), utc(2011, 0, 8));
  });

  test(
      "timeSaturday.count(start, end) counts Saturdays after start (exclusive) and before end (inclusive)",
      () {
    //       January 2012
    // Su Mo Tu We Th Fr Sa
    //  1  2  3  4  5  6  7
    //  8  9 10 11 12 13 14
    // 15 16 17 18 19 20 21
    // 22 23 24 25 26 27 28
    // 29 30 31
    expect(timeSaturday.count(utc(2012, 0, 1), utc(2012, 0, 6)), 0);
    expect(timeSaturday.count(utc(2012, 0, 1), utc(2012, 0, 7)), 1);
    expect(timeSaturday.count(utc(2012, 0, 1), utc(2012, 0, 8)), 1);
    expect(timeSaturday.count(utc(2012, 0, 1), utc(2012, 0, 14)), 2);

    //     January 2011
    // Su Mo Tu We Th Fr Sa
    //                    1
    //  2  3  4  5  6  7  8
    //  9 10 11 12 13 14 15
    // 16 17 18 19 20 21 22
    // 23 24 25 26 27 28 29
    // 30 31
    expect(timeSaturday.count(utc(2011, 0, 1), utc(2011, 0, 7)), 0);
    expect(timeSaturday.count(utc(2011, 0, 1), utc(2011, 0, 8)), 1);
    expect(timeSaturday.count(utc(2011, 0, 1), utc(2011, 0, 9)), 1);
  });

  test("timeSaturday.count(start, end) does not observe daylight saving", () {
    expect(timeSaturday.count(utc(2011, 0, 1), utc(2011, 2, 13, 1)), 10);
    expect(timeSaturday.count(utc(2011, 0, 1), utc(2011, 2, 13, 3)), 10);
    expect(timeSaturday.count(utc(2011, 0, 1), utc(2011, 2, 13, 4)), 10);
    expect(timeSaturday.count(utc(2011, 0, 1), utc(2011, 10, 6, 0)), 44);
    expect(timeSaturday.count(utc(2011, 0, 1), utc(2011, 10, 6, 1)), 44);
    expect(timeSaturday.count(utc(2011, 0, 1), utc(2011, 10, 6, 2)), 44);
  });
}
