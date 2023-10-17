import 'package:d4_time/d4_time.dart';
import 'package:test/test.dart';

import 'date.dart';

void main() {
  test("timeSundays in an alias for timeSunday.range", () {
    expect(timeSundays, timeSunday.range);
  });

  test("timeSunday.floor(date) returns Sundays", () {
    expect(
        timeSunday.floor(local(2010, 11, 31, 23, 59, 59)), local(2010, 11, 26));
    expect(timeSunday.floor(local(2011, 0, 1, 0, 0, 0)), local(2010, 11, 26));
    expect(timeSunday.floor(local(2011, 0, 1, 0, 0, 1)), local(2010, 11, 26));
    expect(
        timeSunday.floor(local(2011, 0, 1, 23, 59, 59)), local(2010, 11, 26));
    expect(timeSunday.floor(local(2011, 0, 2, 0, 0, 0)), local(2011, 0, 2));
    expect(timeSunday.floor(local(2011, 0, 2, 0, 0, 1)), local(2011, 0, 2));
  });

  test("timeSunday.floor(date) observes daylight saving", () {
    expect(timeSunday.floor(local(2011, 2, 13, 1)), local(2011, 2, 13));
    expect(timeSunday.floor(local(2011, 10, 6, 1)), local(2011, 10, 6));
  });

  test("timeSunday.floor(date) handles years in the first century", () {
    expect(timeSunday.floor(local(9, 10, 6, 7)), local(9, 10, 1));
  });

  test("timeSunday.ceil(date) returns Sundays", () {
    expect(timeSunday.ceil(local(2010, 11, 31, 23, 59, 59)), local(2011, 0, 2));
    expect(timeSunday.ceil(local(2011, 0, 1, 0, 0, 0)), local(2011, 0, 2));
    expect(timeSunday.ceil(local(2011, 0, 1, 0, 0, 1)), local(2011, 0, 2));
    expect(timeSunday.ceil(local(2011, 0, 1, 23, 59, 59)), local(2011, 0, 2));
    expect(timeSunday.ceil(local(2011, 0, 2, 0, 0, 0)), local(2011, 0, 2));
    expect(timeSunday.ceil(local(2011, 0, 2, 0, 0, 1)), local(2011, 0, 9));
  });

  test("timeSunday.ceil(date) observes daylight saving", () {
    expect(timeSunday.ceil(local(2011, 2, 13, 1)), local(2011, 2, 20));
    expect(timeSunday.ceil(local(2011, 10, 6, 1)), local(2011, 10, 13));
  });

  test("timeSunday.offset(date) is an alias for timeSunday.offset(date, 1)",
      () {
    expect(timeSunday.offset(local(2010, 11, 31, 23, 59, 59, 999)),
        local(2011, 0, 7, 23, 59, 59, 999));
  });

  test("timeSunday.offset(date, step) does not modify the passed-in date", () {
    final d = local(2010, 11, 31, 23, 59, 59, 999);
    timeSunday.offset(d, 1);
    expect(d, local(2010, 11, 31, 23, 59, 59, 999));
  });

  test("timeSunday.offset(date, step) does not round the passed-in date", () {
    expect(timeSunday.offset(local(2010, 11, 31, 23, 59, 59, 999), 1),
        local(2011, 0, 7, 23, 59, 59, 999));
    expect(timeSunday.offset(local(2010, 11, 31, 23, 59, 59, 456), -2),
        local(2010, 11, 17, 23, 59, 59, 456));
  });

  test("timeSunday.offset(date, step) allows step to be negative", () {
    expect(timeSunday.offset(local(2010, 11, 1), -1), local(2010, 10, 24));
    expect(timeSunday.offset(local(2011, 0, 1), -2), local(2010, 11, 18));
    expect(timeSunday.offset(local(2011, 0, 1), -1), local(2010, 11, 25));
  });

  test("timeSunday.offset(date, step) allows step to be positive", () {
    expect(timeSunday.offset(local(2010, 10, 24), 1), local(2010, 11, 1));
    expect(timeSunday.offset(local(2010, 11, 18), 2), local(2011, 0, 1));
    expect(timeSunday.offset(local(2010, 11, 25), 1), local(2011, 0, 1));
  });

  test("timeSunday.offset(date, step) allows step to be zero", () {
    expect(timeSunday.offset(local(2010, 11, 31, 23, 59, 59, 999), 0),
        local(2010, 11, 31, 23, 59, 59, 999));
    expect(timeSunday.offset(local(2010, 11, 31, 23, 59, 58, 0), 0),
        local(2010, 11, 31, 23, 59, 58, 0));
  });

  test(
      "timeSunday.range(start, stop) returns Sundays between start (inclusive) and stop (exclusive)",
      () {
    expect(timeSunday.range(local(2011, 11, 1), local(2012, 0, 15)), [
      local(2011, 11, 4),
      local(2011, 11, 11),
      local(2011, 11, 18),
      local(2011, 11, 25),
      local(2012, 0, 1),
      local(2012, 0, 8)
    ]);
  });

  test("timeSunday.range(start, stop) returns Sundays", () {
    expect(
        timeSunday.range(
            local(2011, 11, 1, 12, 23), local(2012, 0, 14, 12, 23)),
        [
          local(2011, 11, 4),
          local(2011, 11, 11),
          local(2011, 11, 18),
          local(2011, 11, 25),
          local(2012, 0, 1),
          local(2012, 0, 8)
        ]);
  });

  test("timeSunday.range(start, stop) returns the empty array if start >= stop",
      () {
    expect(timeSunday.range(local(2011, 11, 10), local(2011, 10, 4)), []);
    expect(timeSunday.range(local(2011, 10, 1), local(2011, 10, 1)), []);
  });

  test("timeSunday.range(start, stop, step) returns every step Sunday", () {
    expect(timeSunday.range(local(2011, 11, 1), local(2012, 0, 15), 2),
        [local(2011, 11, 4), local(2011, 11, 18), local(2012, 0, 1)]);
  });

  test(
      "timeSunday.count(start, end) counts Sundays after start (exclusive) and before end (inclusive)",
      () {
    //     January 2014
    // Su Mo Tu We Th Fr Sa
    //           1  2  3  4
    //  5  6  7  8  9 10 11
    // 12 13 14 15 16 17 18
    // 19 20 21 22 23 24 25
    // 26 27 28 29 30 31
    expect(timeSunday.count(local(2014, 0, 1), local(2014, 0, 4)), 0);
    expect(timeSunday.count(local(2014, 0, 1), local(2014, 0, 5)), 1);
    expect(timeSunday.count(local(2014, 0, 1), local(2014, 0, 6)), 1);
    expect(timeSunday.count(local(2014, 0, 1), local(2014, 0, 12)), 2);

    //       January 2012
    // Su Mo Tu We Th Fr Sa
    //  1  2  3  4  5  6  7
    //  8  9 10 11 12 13 14
    // 15 16 17 18 19 20 21
    // 22 23 24 25 26 27 28
    // 29 30 31
    expect(timeSunday.count(local(2012, 0, 1), local(2012, 0, 7)), 0);
    expect(timeSunday.count(local(2012, 0, 1), local(2012, 0, 8)), 1);
    expect(timeSunday.count(local(2012, 0, 1), local(2012, 0, 9)), 1);
  });

  test("timeSunday.count(start, end) observes daylight saving", () {
    expect(timeSunday.count(local(2011, 0, 1), local(2011, 2, 13, 1)), 11);
    expect(timeSunday.count(local(2011, 0, 1), local(2011, 2, 13, 3)), 11);
    expect(timeSunday.count(local(2011, 0, 1), local(2011, 2, 13, 4)), 11);
    expect(timeSunday.count(local(2011, 0, 1), local(2011, 10, 6, 0)), 45);
    expect(timeSunday.count(local(2011, 0, 1), local(2011, 10, 6, 1)), 45);
    expect(timeSunday.count(local(2011, 0, 1), local(2011, 10, 6, 2)), 45);
  });
}
