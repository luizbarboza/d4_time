import 'package:d4_time/d4_time.dart';
import 'package:test/test.dart';

import 'date.dart';

void main() {
  test("timeFridays in an alias for timeFriday.range", () {
    expect(timeFridays, timeFriday.range);
  });

  test("timeFriday.floor(date) returns Fridays", () {
    expect(timeFriday.floor(utc(2011, 0, 5, 23, 59, 59)), utc(2010, 11, 31));
    expect(timeFriday.floor(utc(2011, 0, 6, 0, 0, 0)), utc(2010, 11, 31));
    expect(timeFriday.floor(utc(2011, 0, 6, 0, 0, 1)), utc(2010, 11, 31));
    expect(timeFriday.floor(utc(2011, 0, 6, 23, 59, 59)), utc(2010, 11, 31));
    expect(timeFriday.floor(utc(2011, 0, 7, 0, 0, 0)), utc(2011, 0, 7));
    expect(timeFriday.floor(utc(2011, 0, 7, 0, 0, 1)), utc(2011, 0, 7));
  });

  test(
      "timeFriday.count(start, end) counts Fridays after start (exclusive) and before end (inclusive)",
      () {
    //       January 2012
    // Su Mo Tu We Th Fr Sa
    //  1  2  3  4  5  6  7
    //  8  9 10 11 12 13 14
    // 15 16 17 18 19 20 21
    // 22 23 24 25 26 27 28
    // 29 30 31
    expect(timeFriday.count(utc(2012, 0, 1), utc(2012, 0, 5)), 0);
    expect(timeFriday.count(utc(2012, 0, 1), utc(2012, 0, 6)), 1);
    expect(timeFriday.count(utc(2012, 0, 1), utc(2012, 0, 7)), 1);
    expect(timeFriday.count(utc(2012, 0, 1), utc(2012, 0, 13)), 2);

    //     January 2010
    // Su Mo Tu We Th Fr Sa
    //                 1  2
    //  3  4  5  6  7  8  9
    // 10 11 12 13 14 15 16
    // 17 18 19 20 21 22 23
    // 24 25 26 27 28 29 30
    // 31
    expect(timeFriday.count(utc(2010, 0, 1), utc(2010, 0, 7)), 0);
    expect(timeFriday.count(utc(2010, 0, 1), utc(2010, 0, 8)), 1);
    expect(timeFriday.count(utc(2010, 0, 1), utc(2010, 0, 9)), 1);
  });

  test("timeFriday.count(start, end) does not observe daylight saving", () {
    expect(timeFriday.count(utc(2011, 0, 1), utc(2011, 2, 13, 1)), 10);
    expect(timeFriday.count(utc(2011, 0, 1), utc(2011, 2, 13, 3)), 10);
    expect(timeFriday.count(utc(2011, 0, 1), utc(2011, 2, 13, 4)), 10);
    expect(timeFriday.count(utc(2011, 0, 1), utc(2011, 10, 6, 0)), 44);
    expect(timeFriday.count(utc(2011, 0, 1), utc(2011, 10, 6, 1)), 44);
    expect(timeFriday.count(utc(2011, 0, 1), utc(2011, 10, 6, 2)), 44);
  });
}
