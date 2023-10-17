import 'package:d4_time/d4_time.dart';
import 'package:test/test.dart';

import 'date.dart';

void main() {
  test("timeWeek.floor(date) returns sundays", () {
    expect(timeWeek.floor(utc(2010, 11, 31, 23, 59, 59)), utc(2010, 11, 26));
    expect(timeWeek.floor(utc(2011, 0, 1, 0, 0, 0)), utc(2010, 11, 26));
    expect(timeWeek.floor(utc(2011, 0, 1, 0, 0, 1)), utc(2010, 11, 26));
    expect(timeWeek.floor(utc(2011, 0, 1, 23, 59, 59)), utc(2010, 11, 26));
    expect(timeWeek.floor(utc(2011, 0, 2, 0, 0, 0)), utc(2011, 0, 2));
    expect(timeWeek.floor(utc(2011, 0, 2, 0, 0, 1)), utc(2011, 0, 2));
  });

  test("timeWeek.floor(date) observes the start of daylight savings time", () {
    expect(timeWeek.floor(utc(2011, 2, 13, 1)), utc(2011, 2, 13));
  });

  test("timeWeek.floor(date) observes the end of the daylight savings time",
      () {
    expect(timeWeek.floor(utc(2011, 10, 6, 1)), utc(2011, 10, 6));
  });

  test("timeWeek.floor(date) correctly handles years in the first century", () {
    expect(timeWeek.floor(utc(9, 10, 6, 7)), utc(9, 10, 1));
  });

  test("timeWeek.ceil(date) returns sundays", () {
    expect(timeWeek.ceil(utc(2010, 11, 31, 23, 59, 59)), utc(2011, 0, 2));
    expect(timeWeek.ceil(utc(2011, 0, 1, 0, 0, 0)), utc(2011, 0, 2));
    expect(timeWeek.ceil(utc(2011, 0, 1, 0, 0, 1)), utc(2011, 0, 2));
    expect(timeWeek.ceil(utc(2011, 0, 1, 23, 59, 59)), utc(2011, 0, 2));
    expect(timeWeek.ceil(utc(2011, 0, 2, 0, 0, 0)), utc(2011, 0, 2));
    expect(timeWeek.ceil(utc(2011, 0, 2, 0, 0, 1)), utc(2011, 0, 9));
  });

  test(
      "timeWeek.ceil(date) does not observe the start of daylight savings time",
      () {
    expect(timeWeek.ceil(utc(2011, 2, 13, 1)), utc(2011, 2, 20));
  });

  test(
      "timeWeek.ceil(date) does not observe the end of the daylight savings time",
      () {
    expect(timeWeek.ceil(utc(2011, 10, 6, 1)), utc(2011, 10, 13));
  });

  test("timeWeek.offset(date, step) does not modify the passed-in date", () {
    final d = utc(2010, 11, 31, 23, 59, 59, 999);
    timeWeek.offset(d, 1);
    expect(d, utc(2010, 11, 31, 23, 59, 59, 999));
  });

  test("timeWeek.offset(date, step) does not round the passed-in-date", () {
    expect(timeWeek.offset(utc(2010, 11, 31, 23, 59, 59, 999), 1),
        utc(2011, 0, 7, 23, 59, 59, 999));
    expect(timeWeek.offset(utc(2010, 11, 31, 23, 59, 59, 456), -2),
        utc(2010, 11, 17, 23, 59, 59, 456));
  });

  test("timeWeek.offset(date, step) allows negative offsets", () {
    expect(timeWeek.offset(utc(2010, 11, 1), -1), utc(2010, 10, 24));
    expect(timeWeek.offset(utc(2011, 0, 1), -2), utc(2010, 11, 18));
    expect(timeWeek.offset(utc(2011, 0, 1), -1), utc(2010, 11, 25));
  });

  test("timeWeek.offset(date, step) allows positive offsets", () {
    expect(timeWeek.offset(utc(2010, 10, 24), 1), utc(2010, 11, 1));
    expect(timeWeek.offset(utc(2010, 11, 18), 2), utc(2011, 0, 1));
    expect(timeWeek.offset(utc(2010, 11, 25), 1), utc(2011, 0, 1));
  });

  test("timeWeek.offset(date, step) allows zero offset", () {
    expect(timeWeek.offset(utc(2010, 11, 31, 23, 59, 59, 999), 0),
        utc(2010, 11, 31, 23, 59, 59, 999));
    expect(timeWeek.offset(utc(2010, 11, 31, 23, 59, 58, 0), 0),
        utc(2010, 11, 31, 23, 59, 58, 0));
  });

  test("timeWeek.range(start, stop) returns sundays", () {
    expect(timeWeek.range(utc(2010, 11, 21), utc(2011, 0, 12)),
        [utc(2010, 11, 26), utc(2011, 0, 2), utc(2011, 0, 9)]);
  });

  test("timeWeek.range(start, stop) has an inclusive lower bound", () {
    expect(timeWeek.range(utc(2010, 11, 21), utc(2011, 0, 12))[0],
        utc(2010, 11, 26));
  });

  test("timeWeek.range(start, stop) has an exclusive upper bound", () {
    expect(timeWeek.range(utc(2010, 11, 21), utc(2011, 0, 12))[2],
        utc(2011, 0, 9));
  });

  test("timeWeek.range(start, stop) can skip weeks", () {
    expect(timeWeek.range(utc(2011, 0, 1), utc(2011, 3, 1), 4), [
      utc(2011, 0, 2),
      utc(2011, 0, 30),
      utc(2011, 1, 27),
      utc(2011, 2, 27)
    ]);
  });

  test(
      "timeWeek.range(start, stop) does not observe start of daylight savings time",
      () {
    expect(timeWeek.range(utc(2011, 2, 1), utc(2011, 2, 28)), [
      utc(2011, 2, 6),
      utc(2011, 2, 13),
      utc(2011, 2, 20),
      utc(2011, 2, 27)
    ]);
  });

  test(
      "timeWeek.range(start, stop) does not observe end of daylight savings time",
      () {
    expect(timeWeek.range(utc(2011, 10, 1), utc(2011, 10, 30)), [
      utc(2011, 10, 6),
      utc(2011, 10, 13),
      utc(2011, 10, 20),
      utc(2011, 10, 27)
    ]);
  });

  test("timeWeek is an alias for utcSunday", () {
    expect(timeWeek, timeSunday);
  });

  test(
      "timeWeek.every(step) returns every stepth Sunday, starting with the first Sunday of the month",
      () {
    expect(timeWeek.every(2)!.range(utc(2008, 11, 3), utc(2009, 1, 5)), [
      utc(2008, 11, 7),
      utc(2008, 11, 21),
      utc(2009, 0, 4),
      utc(2009, 0, 18),
      utc(2009, 1, 1)
    ]);
  });
}
