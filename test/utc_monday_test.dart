import 'package:d4_time/d4_time.dart';
import 'package:test/test.dart';

import 'date.dart';

void main() {
  test("timeMondays in an alias for timeMonday.range", () {
    expect(timeMondays, timeMonday.range);
  });

  test("timeMonday.floor(date) returns Mondays", () {
    expect(timeMonday.floor(utc(2011, 0, 1, 23, 59, 59)), utc(2010, 11, 27));
    expect(timeMonday.floor(utc(2011, 0, 2, 0, 0, 0)), utc(2010, 11, 27));
    expect(timeMonday.floor(utc(2011, 0, 2, 0, 0, 1)), utc(2010, 11, 27));
    expect(timeMonday.floor(utc(2011, 0, 2, 23, 59, 59)), utc(2010, 11, 27));
    expect(timeMonday.floor(utc(2011, 0, 3, 0, 0, 0)), utc(2011, 0, 3));
    expect(timeMonday.floor(utc(2011, 0, 3, 0, 0, 1)), utc(2011, 0, 3));
  });

  test("timeMonday.range(start, stop, step) returns every step Monday", () {
    expect(timeMonday.range(utc(2011, 11, 1), utc(2012, 0, 15), 2),
        [utc(2011, 11, 5), utc(2011, 11, 19), utc(2012, 0, 2)]);
  });

  test(
      "timeMonday.count(start, end) counts Mondays after start (exclusive) and before end (inclusive)",
      () {
    //     January 2014
    // Su Mo Tu We Th Fr Sa
    //           1  2  3  4
    //  5  6  7  8  9 10 11
    // 12 13 14 15 16 17 18
    // 19 20 21 22 23 24 25
    // 26 27 28 29 30 31
    expect(timeMonday.count(utc(2014, 0, 1), utc(2014, 0, 5)), 0);
    expect(timeMonday.count(utc(2014, 0, 1), utc(2014, 0, 6)), 1);
    expect(timeMonday.count(utc(2014, 0, 1), utc(2014, 0, 7)), 1);
    expect(timeMonday.count(utc(2014, 0, 1), utc(2014, 0, 13)), 2);

    //     January 2018
    // Su Mo Tu We Th Fr Sa
    //     1  2  3  4  5  6
    //  7  8  9 10 11 12 13
    // 14 15 16 17 18 19 20
    // 21 22 23 24 25 26 27
    // 28 29 30 31
    expect(timeMonday.count(utc(2018, 0, 1), utc(2018, 0, 7)), 0);
    expect(timeMonday.count(utc(2018, 0, 1), utc(2018, 0, 8)), 1);
    expect(timeMonday.count(utc(2018, 0, 1), utc(2018, 0, 9)), 1);
  });

  test("timeMonday.count(start, end) does not observe daylight saving", () {
    expect(timeMonday.count(utc(2011, 0, 1), utc(2011, 2, 13, 1)), 10);
    expect(timeMonday.count(utc(2011, 0, 1), utc(2011, 2, 13, 3)), 10);
    expect(timeMonday.count(utc(2011, 0, 1), utc(2011, 2, 13, 4)), 10);
    expect(timeMonday.count(utc(2011, 0, 1), utc(2011, 10, 6, 0)), 44);
    expect(timeMonday.count(utc(2011, 0, 1), utc(2011, 10, 6, 1)), 44);
    expect(timeMonday.count(utc(2011, 0, 1), utc(2011, 10, 6, 2)), 44);
  });
}
