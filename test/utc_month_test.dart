import 'package:d4_time/d4_time.dart';
import 'package:test/test.dart';

import 'date.dart';

void main() {
  test("timeMonth.floor(date) returns months", () {
    expect(timeMonth.floor(utc(2010, 11, 31, 23)), utc(2010, 11, 1));
    expect(timeMonth.floor(utc(2011, 0, 1, 0)), utc(2011, 0, 1));
    expect(timeMonth.floor(utc(2011, 0, 1, 1)), utc(2011, 0, 1));
  });

  test("timeMonth.floor(date) observes daylight saving", () {
    expect(timeMonth.floor(utc(2011, 2, 13, 7)), utc(2011, 2, 1));
    expect(timeMonth.floor(utc(2011, 2, 13, 8)), utc(2011, 2, 1));
    expect(timeMonth.floor(utc(2011, 2, 13, 9)), utc(2011, 2, 1));
    expect(timeMonth.floor(utc(2011, 2, 13, 10)), utc(2011, 2, 1));
    expect(timeMonth.floor(utc(2011, 10, 6, 7)), utc(2011, 10, 1));
    expect(timeMonth.floor(utc(2011, 10, 6, 8)), utc(2011, 10, 1));
    expect(timeMonth.floor(utc(2011, 10, 6, 9)), utc(2011, 10, 1));
    expect(timeMonth.floor(utc(2011, 10, 6, 10)), utc(2011, 10, 1));
  });

  test("timeMonth.floor(date) handles years in the first century", () {
    expect(timeMonth.floor(utc(9, 10, 6, 7)), utc(9, 10, 1));
  });

  test("timeMonth.round(date) returns months", () {
    expect(timeMonth.round(utc(2010, 11, 16, 12)), utc(2011, 0, 1));
    expect(timeMonth.round(utc(2010, 11, 16, 11)), utc(2010, 11, 1));
  });

  test("timeMonth.round(date) observes daylight saving", () {
    expect(timeMonth.round(utc(2011, 2, 13, 7)), utc(2011, 2, 1));
    expect(timeMonth.round(utc(2011, 2, 13, 8)), utc(2011, 2, 1));
    expect(timeMonth.round(utc(2011, 2, 13, 9)), utc(2011, 2, 1));
    expect(timeMonth.round(utc(2011, 2, 13, 20)), utc(2011, 2, 1));
    expect(timeMonth.round(utc(2011, 10, 6, 7)), utc(2011, 10, 1));
    expect(timeMonth.round(utc(2011, 10, 6, 8)), utc(2011, 10, 1));
    expect(timeMonth.round(utc(2011, 10, 6, 9)), utc(2011, 10, 1));
    expect(timeMonth.round(utc(2011, 10, 6, 20)), utc(2011, 10, 1));
  });

  test("timeMonth.round(date) handles midnight for leap years", () {
    expect(timeMonth.round(utc(2012, 2, 1, 0)), utc(2012, 2, 1));
    expect(timeMonth.round(utc(2012, 2, 1, 0)), utc(2012, 2, 1));
  });

  test("timeMonth.ceil(date) returns months", () {
    expect(timeMonth.ceil(utc(2010, 10, 30, 23)), utc(2010, 11, 1));
    expect(timeMonth.ceil(utc(2010, 11, 1, 1)), utc(2011, 0, 1));
  });

  test("timeMonth.ceil(date) observes daylight saving", () {
    expect(timeMonth.ceil(utc(2011, 2, 13, 7)), utc(2011, 3, 1));
    expect(timeMonth.ceil(utc(2011, 2, 13, 8)), utc(2011, 3, 1));
    expect(timeMonth.ceil(utc(2011, 2, 13, 9)), utc(2011, 3, 1));
    expect(timeMonth.ceil(utc(2011, 2, 13, 10)), utc(2011, 3, 1));
    expect(timeMonth.ceil(utc(2011, 10, 6, 7)), utc(2011, 11, 1));
    expect(timeMonth.ceil(utc(2011, 10, 6, 8)), utc(2011, 11, 1));
    expect(timeMonth.ceil(utc(2011, 10, 6, 9)), utc(2011, 11, 1));
    expect(timeMonth.ceil(utc(2011, 10, 6, 10)), utc(2011, 11, 1));
  });

  test("timeMonth.ceil(date) handles midnight for leap years", () {
    expect(timeMonth.ceil(utc(2012, 2, 1, 0)), utc(2012, 2, 1));
    expect(timeMonth.ceil(utc(2012, 2, 1, 0)), utc(2012, 2, 1));
  });

  test("timeMonth.offset(date) is an alias for timeMonth.offset(date, 1)", () {
    expect(timeMonth.offset(utc(2010, 11, 31, 23, 59, 59, 999)),
        utc(2011, 0, 31, 23, 59, 59, 999));
  });

  test("timeMonth.offset(date, step) does not modify the passed-in date", () {
    final d = utc(2010, 11, 31, 23, 59, 59, 999);
    timeMonth.offset(d, 1);
    expect(d, utc(2010, 11, 31, 23, 59, 59, 999));
  });

  test("timeMonth.offset(date, step) does not round the passed-in date", () {
    expect(timeMonth.offset(utc(2010, 11, 31, 23, 59, 59, 999), 1),
        utc(2011, 0, 31, 23, 59, 59, 999));
    expect(timeMonth.offset(utc(2010, 11, 31, 23, 59, 59, 456), -2),
        utc(2010, 9, 31, 23, 59, 59, 456));
  });

  test("timeMonth.offset(date, step) allows step to be negative", () {
    expect(timeMonth.offset(utc(2010, 11, 31), -1), utc(2010, 10, 31));
    expect(timeMonth.offset(utc(2011, 0, 1), -2), utc(2010, 10, 1));
    expect(timeMonth.offset(utc(2011, 0, 1), -1), utc(2010, 11, 1));
  });

  test("timeMonth.offset(date, step) allows step to be positive", () {
    expect(timeMonth.offset(utc(2010, 11, 31), 1), utc(2011, 0, 31));
    expect(timeMonth.offset(utc(2010, 11, 30), 2), utc(2011, 1, 30));
    expect(timeMonth.offset(utc(2010, 11, 30), 1), utc(2011, 0, 30));
  });

  test("timeMonth.offset(date, step) allows step to be zero", () {
    expect(timeMonth.offset(utc(2010, 11, 31, 23, 59, 59, 999), 0),
        utc(2010, 11, 31, 23, 59, 59, 999));
    expect(timeMonth.offset(utc(2010, 11, 31, 23, 59, 58, 0), 0),
        utc(2010, 11, 31, 23, 59, 58, 0));
  });

  test(
      "timeMonth.range(start, stop) returns months between start (inclusive) and stop (exclusive)",
      () {
    expect(timeMonth.range(utc(2011, 11, 1), utc(2012, 5, 1)), [
      utc(2011, 11, 1),
      utc(2012, 0, 1),
      utc(2012, 1, 1),
      utc(2012, 2, 1),
      utc(2012, 3, 1),
      utc(2012, 4, 1)
    ]);
  });

  test("timeMonth.range(start, stop) returns months", () {
    expect(timeMonth.range(utc(2011, 10, 4, 2), utc(2012, 4, 10, 13)), [
      utc(2011, 11, 1),
      utc(2012, 0, 1),
      utc(2012, 1, 1),
      utc(2012, 2, 1),
      utc(2012, 3, 1),
      utc(2012, 4, 1)
    ]);
  });

  test("timeMonth.range(start, stop) returns the empty array if start >= stop",
      () {
    expect(timeMonth.range(utc(2011, 11, 10), utc(2011, 10, 4)), []);
    expect(timeMonth.range(utc(2011, 10, 1), utc(2011, 10, 1)), []);
  });

  test("timeMonth.range(start, stop) returns months", () {
    expect(timeMonth.range(utc(2010, 10, 31), utc(2011, 2, 1)),
        [utc(2010, 11, 1), utc(2011, 0, 1), utc(2011, 1, 1)]);
  });

  test("timeMonth.range(start, stop) has an inclusive lower bound", () {
    expect(timeMonth.range(utc(2010, 10, 31), utc(2011, 2, 1))[0],
        utc(2010, 11, 1));
  });

  test("timeMonth.range(start, stop) has an exclusive upper bound", () {
    expect(timeMonth.range(utc(2010, 10, 31), utc(2011, 2, 1))[2],
        utc(2011, 1, 1));
  });

  test("timeMonth.range(start, stop) can skip months", () {
    expect(timeMonth.range(utc(2011, 1, 1), utc(2012, 1, 1), 3),
        [utc(2011, 1, 1), utc(2011, 4, 1), utc(2011, 7, 1), utc(2011, 10, 1)]);
  });

  test("timeMonth.range(start, stop) observes start of daylight savings time",
      () {
    expect(timeMonth.range(utc(2011, 0, 1), utc(2011, 4, 1)),
        [utc(2011, 0, 1), utc(2011, 1, 1), utc(2011, 2, 1), utc(2011, 3, 1)]);
  });

  test("timeMonth.range(start, stop) observes end of daylight savings time",
      () {
    expect(timeMonth.range(utc(2011, 9, 1), utc(2012, 1, 1)),
        [utc(2011, 9, 1), utc(2011, 10, 1), utc(2011, 11, 1), utc(2012, 0, 1)]);
  });

  test(
      "timeMonth.count(start, end) counts months after start (exclusive) and before end (inclusive)",
      () {
    expect(timeMonth.count(utc(2011, 0, 1), utc(2011, 4, 1)), 4);
    expect(timeMonth.count(utc(2011, 0, 1), utc(2011, 3, 30)), 3);
    expect(timeMonth.count(utc(2010, 11, 31), utc(2011, 3, 30)), 4);
    expect(timeMonth.count(utc(2010, 11, 31), utc(2011, 4, 1)), 5);
    expect(timeMonth.count(utc(2009, 11, 31), utc(2012, 4, 1)), 29);
    expect(timeMonth.count(utc(2012, 4, 1), utc(2009, 11, 31)), -29);
  });

  test(
      "timeMonth.every(step) returns every stepth month, starting with the first month of the year",
      () {
    expect(timeMonth.every(3)!.range(utc(2008, 11, 3), utc(2010, 6, 5)), [
      utc(2009, 0, 1),
      utc(2009, 3, 1),
      utc(2009, 6, 1),
      utc(2009, 9, 1),
      utc(2010, 0, 1),
      utc(2010, 3, 1),
      utc(2010, 6, 1)
    ]);
  });
}
