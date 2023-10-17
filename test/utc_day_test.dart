import 'package:d4_time/d4_time.dart';
import 'package:test/test.dart';

import 'date.dart';

void main() {
  test("timeDay.floor(date) returns days", () {
    expect(timeDay.floor(utc(2010, 11, 31, 23)), utc(2010, 11, 31));
    expect(timeDay.floor(utc(2011, 0, 1, 0)), utc(2011, 0, 1));
    expect(timeDay.floor(utc(2011, 0, 1, 1)), utc(2011, 0, 1));
  });

  test("timeDay.floor(date) does not observe daylight saving", () {
    expect(timeDay.floor(utc(2011, 2, 13, 7)), utc(2011, 2, 13));
    expect(timeDay.floor(utc(2011, 2, 13, 8)), utc(2011, 2, 13));
    expect(timeDay.floor(utc(2011, 2, 13, 9)), utc(2011, 2, 13));
    expect(timeDay.floor(utc(2011, 2, 13, 10)), utc(2011, 2, 13));
    expect(timeDay.floor(utc(2011, 10, 6, 5)), utc(2011, 10, 6));
    expect(timeDay.floor(utc(2011, 10, 6, 6)), utc(2011, 10, 6));
    expect(timeDay.floor(utc(2011, 10, 6, 7)), utc(2011, 10, 6));
    expect(timeDay.floor(utc(2011, 10, 6, 8)), utc(2011, 10, 6));
  });

  test("timeDay.round(date) returns days", () {
    expect(timeDay.round(utc(2010, 11, 30, 13)), utc(2010, 11, 31));
    expect(timeDay.round(utc(2010, 11, 30, 11)), utc(2010, 11, 30));
  });

  test("timeDay.ceil(date) returns days", () {
    expect(timeDay.ceil(utc(2010, 11, 30, 23)), utc(2010, 11, 31));
    expect(timeDay.ceil(utc(2010, 11, 31, 0)), utc(2010, 11, 31));
    expect(timeDay.ceil(utc(2010, 11, 31, 1)), utc(2011, 0, 1));
  });

  test("timeDay.ceil(date) does not observe daylight saving", () {
    expect(timeDay.ceil(utc(2011, 2, 13, 7)), utc(2011, 2, 14));
    expect(timeDay.ceil(utc(2011, 2, 13, 8)), utc(2011, 2, 14));
    expect(timeDay.ceil(utc(2011, 2, 13, 9)), utc(2011, 2, 14));
    expect(timeDay.ceil(utc(2011, 2, 13, 10)), utc(2011, 2, 14));
    expect(timeDay.ceil(utc(2011, 10, 6, 5)), utc(2011, 10, 7));
    expect(timeDay.ceil(utc(2011, 10, 6, 6)), utc(2011, 10, 7));
    expect(timeDay.ceil(utc(2011, 10, 6, 7)), utc(2011, 10, 7));
    expect(timeDay.ceil(utc(2011, 10, 6, 8)), utc(2011, 10, 7));
  });

  test("timeDay.offset(date) is an alias for timeDay.offset(date, 1)", () {
    expect(timeDay.offset(utc(2010, 11, 31, 23, 59, 59, 999)),
        utc(2011, 0, 1, 23, 59, 59, 999));
  });

  test("timeDay.offset(date, step) does not modify the passed-in date", () {
    final d = utc(2010, 11, 31, 23, 59, 59, 999);
    timeDay.offset(d, 1);
    expect(d, utc(2010, 11, 31, 23, 59, 59, 999));
  });

  test("timeDay.offset(date, step) does not round the passed-in date", () {
    expect(timeDay.offset(utc(2010, 11, 31, 23, 59, 59, 999), 1),
        utc(2011, 0, 1, 23, 59, 59, 999));
    expect(timeDay.offset(utc(2010, 11, 31, 23, 59, 59, 456), -2),
        utc(2010, 11, 29, 23, 59, 59, 456));
  });

  test("timeDay.offset(date, step) allows step to be negative", () {
    expect(timeDay.offset(utc(2010, 11, 31), -1), utc(2010, 11, 30));
    expect(timeDay.offset(utc(2011, 0, 1), -2), utc(2010, 11, 30));
    expect(timeDay.offset(utc(2011, 0, 1), -1), utc(2010, 11, 31));
  });

  test("timeDay.offset(date, step) allows step to be positive", () {
    expect(timeDay.offset(utc(2010, 11, 31), 1), utc(2011, 0, 1));
    expect(timeDay.offset(utc(2010, 11, 30), 2), utc(2011, 0, 1));
    expect(timeDay.offset(utc(2010, 11, 30), 1), utc(2010, 11, 31));
  });

  test("timeDay.offset(date, step) allows step to be zero", () {
    expect(timeDay.offset(utc(2010, 11, 31, 23, 59, 59, 999), 0),
        utc(2010, 11, 31, 23, 59, 59, 999));
    expect(timeDay.offset(utc(2010, 11, 31, 23, 59, 58, 0), 0),
        utc(2010, 11, 31, 23, 59, 58, 0));
  });

  test(
      "timeDay.count(start, end) counts days after start (exclusive) and before end (inclusive)",
      () {
    expect(timeDay.count(utc(2011, 0, 1, 0), utc(2011, 4, 9, 0)), 128);
    expect(timeDay.count(utc(2011, 0, 1, 1), utc(2011, 4, 9, 0)), 128);
    expect(timeDay.count(utc(2010, 11, 31, 23), utc(2011, 4, 9, 0)), 129);
    expect(timeDay.count(utc(2011, 0, 1, 0), utc(2011, 4, 8, 23)), 127);
    expect(timeDay.count(utc(2011, 0, 1, 0), utc(2011, 4, 9, 1)), 128);
  });

  test("timeDay.count(start, end) does not observe daylight saving", () {
    expect(timeDay.count(utc(2011, 0, 1), utc(2011, 2, 13, 1)), 71);
    expect(timeDay.count(utc(2011, 0, 1), utc(2011, 2, 13, 3)), 71);
    expect(timeDay.count(utc(2011, 0, 1), utc(2011, 2, 13, 4)), 71);
    expect(timeDay.count(utc(2011, 0, 1), utc(2011, 10, 6, 0)), 309);
    expect(timeDay.count(utc(2011, 0, 1), utc(2011, 10, 6, 1)), 309);
    expect(timeDay.count(utc(2011, 0, 1), utc(2011, 10, 6, 2)), 309);
  });

  test("timeDay.count(start, end) returns 364 or 365 for a full year", () {
    expect(timeDay.count(utc(1999, 0, 1), utc(1999, 11, 31)), 364);
    expect(timeDay.count(utc(2000, 0, 1), utc(2000, 11, 31)), 365); // leap year
    expect(timeDay.count(utc(2001, 0, 1), utc(2001, 11, 31)), 364);
    expect(timeDay.count(utc(2002, 0, 1), utc(2002, 11, 31)), 364);
    expect(timeDay.count(utc(2003, 0, 1), utc(2003, 11, 31)), 364);
    expect(timeDay.count(utc(2004, 0, 1), utc(2004, 11, 31)), 365); // leap year
    expect(timeDay.count(utc(2005, 0, 1), utc(2005, 11, 31)), 364);
    expect(timeDay.count(utc(2006, 0, 1), utc(2006, 11, 31)), 364);
    expect(timeDay.count(utc(2007, 0, 1), utc(2007, 11, 31)), 364);
    expect(timeDay.count(utc(2008, 0, 1), utc(2008, 11, 31)), 365); // leap year
    expect(timeDay.count(utc(2009, 0, 1), utc(2009, 11, 31)), 364);
    expect(timeDay.count(utc(2010, 0, 1), utc(2010, 11, 31)), 364);
    expect(timeDay.count(utc(2011, 0, 1), utc(2011, 11, 31)), 364);
  });

  test(
      "utcDay.every(step) returns every stepth day without resetting on the first of the month",
      () {
    expect(
        timeDay
            .every(3)!
            .range(utc(2008, 11, 30, 0, 12), utc(2009, 0, 5, 23, 48)),
        [utc(2008, 11, 31), utc(2009, 0, 3)]);
    expect(
        timeDay
            .every(5)!
            .range(utc(2008, 11, 25, 0, 12), utc(2009, 0, 6, 23, 48)),
        [utc(2008, 11, 27), utc(2009, 0, 1), utc(2009, 0, 6)]);
    expect(
        timeDay
            .every(7)!
            .range(utc(2008, 11, 23, 0, 12), utc(2009, 0, 8, 23, 48)),
        [utc(2008, 11, 25), utc(2009, 0, 1), utc(2009, 0, 8)]);
  });
}
