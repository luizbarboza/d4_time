import 'package:d4_time/d4_time.dart';
import 'package:test/test.dart';

import 'date.dart';

void main() {
  test("timeSecond.floor(date) returns seconds", () {
    expect(timeSecond.floor(utc(2010, 11, 31, 23, 59, 59, 999)),
        utc(2010, 11, 31, 23, 59, 59));
    expect(timeSecond.floor(utc(2011, 0, 1, 0, 0, 0, 0)),
        utc(2011, 0, 1, 0, 0, 0));
    expect(timeSecond.floor(utc(2011, 0, 1, 0, 0, 0, 1)),
        utc(2011, 0, 1, 0, 0, 0));
  });

  test("timeSecond.round(date) returns seconds", () {
    expect(timeSecond.round(utc(2010, 11, 31, 23, 59, 59, 999)),
        utc(2011, 0, 1, 0, 0, 0));
    expect(timeSecond.round(utc(2011, 0, 1, 0, 0, 0, 499)),
        utc(2011, 0, 1, 0, 0, 0));
    expect(timeSecond.round(utc(2011, 0, 1, 0, 0, 0, 500)),
        utc(2011, 0, 1, 0, 0, 1));
  });

  test("timeSecond.ceil(date) returns seconds", () {
    expect(timeSecond.ceil(utc(2010, 11, 31, 23, 59, 59, 999)),
        utc(2011, 0, 1, 0, 0, 0));
    expect(
        timeSecond.ceil(utc(2011, 0, 1, 0, 0, 0, 0)), utc(2011, 0, 1, 0, 0, 0));
    expect(
        timeSecond.ceil(utc(2011, 0, 1, 0, 0, 0, 1)), utc(2011, 0, 1, 0, 0, 1));
  });

  test("timeSecond.offset(date, step) does not modify the passed-in date", () {
    final d = utc(2010, 11, 31, 23, 59, 59, 999);
    timeSecond.offset(d, 1);
    expect(d, utc(2010, 11, 31, 23, 59, 59, 999));
  });

  test("timeSecond.offset(date, step) does not round the passed-in-date", () {
    expect(timeSecond.offset(utc(2010, 11, 31, 23, 59, 59, 999), 1),
        utc(2011, 0, 1, 0, 0, 0, 999));
    expect(timeSecond.offset(utc(2010, 11, 31, 23, 59, 59, 456), -2),
        utc(2010, 11, 31, 23, 59, 57, 456));
  });

  test("timeSecond.offset(date, step) allows negative offsets", () {
    expect(timeSecond.offset(utc(2010, 11, 31, 23, 59, 59), -1),
        utc(2010, 11, 31, 23, 59, 58));
    expect(timeSecond.offset(utc(2011, 0, 1, 0, 0, 0), -2),
        utc(2010, 11, 31, 23, 59, 58));
    expect(timeSecond.offset(utc(2011, 0, 1, 0, 0, 0), -1),
        utc(2010, 11, 31, 23, 59, 59));
  });

  test("timeSecond.offset(date, step) allows positive offsets", () {
    expect(timeSecond.offset(utc(2010, 11, 31, 23, 59, 58), 1),
        utc(2010, 11, 31, 23, 59, 59));
    expect(timeSecond.offset(utc(2010, 11, 31, 23, 59, 58), 2),
        utc(2011, 0, 1, 0, 0, 0));
    expect(timeSecond.offset(utc(2010, 11, 31, 23, 59, 59), 1),
        utc(2011, 0, 1, 0, 0, 0));
  });

  test("timeSecond.offset(date, step) allows zero offset", () {
    expect(timeSecond.offset(utc(2010, 11, 31, 23, 59, 59, 999), 0),
        utc(2010, 11, 31, 23, 59, 59, 999));
    expect(timeSecond.offset(utc(2010, 11, 31, 23, 59, 58, 0), 0),
        utc(2010, 11, 31, 23, 59, 58, 0));
  });

  test("timeSecond.range(start, stop) returns seconds", () {
    expect(
        timeSecond.range(
            utc(2010, 11, 31, 23, 59, 59), utc(2011, 0, 1, 0, 0, 2)),
        [
          utc(2010, 11, 31, 23, 59, 59),
          utc(2011, 0, 1, 0, 0, 0),
          utc(2011, 0, 1, 0, 0, 1)
        ]);
  });

  test("timeSecond.range(start, stop) has an inclusive lower bound", () {
    expect(
        timeSecond.range(
            utc(2010, 11, 31, 23, 59, 59), utc(2011, 0, 1, 0, 0, 2))[0],
        utc(2010, 11, 31, 23, 59, 59));
  });

  test("timeSecond.range(start, stop) has an exclusive upper bound", () {
    expect(
        timeSecond.range(
            utc(2010, 11, 31, 23, 59, 59), utc(2011, 0, 1, 0, 0, 2))[2],
        utc(2011, 0, 1, 0, 0, 1));
  });

  test("timeSecond.range(start, stop, step) can skip seconds", () {
    expect(
        timeSecond.range(
            utc(2011, 1, 1, 12, 0, 7), utc(2011, 1, 1, 12, 1, 7), 15),
        [
          utc(2011, 1, 1, 12, 0, 7),
          utc(2011, 1, 1, 12, 0, 22),
          utc(2011, 1, 1, 12, 0, 37),
          utc(2011, 1, 1, 12, 0, 52)
        ]);
  });

  test("timeSecond.range(start, stop) observes start of daylight savings time",
      () {
    expect(
        timeSecond.range(
            utc(2011, 2, 13, 9, 59, 59), utc(2011, 2, 13, 10, 0, 2)),
        [
          utc(2011, 2, 13, 9, 59, 59),
          utc(2011, 2, 13, 10, 0, 0),
          utc(2011, 2, 13, 10, 0, 1)
        ]);
  });

  test("timeSecond.range(start, stop) observes end of daylight savings time",
      () {
    expect(
        timeSecond.range(
            utc(2011, 10, 6, 8, 59, 59), utc(2011, 10, 6, 9, 0, 2)),
        [
          utc(2011, 10, 6, 8, 59, 59),
          utc(2011, 10, 6, 9, 0, 0),
          utc(2011, 10, 6, 9, 0, 1)
        ]);
  });

  test(
      "timeSecond.every(step) returns every stepth second, starting with the first second of the minute",
      () {
    expect(
        timeSecond.every(15)!.range(
            utc(2008, 11, 30, 12, 36, 47), utc(2008, 11, 30, 12, 37, 57)),
        [
          utc(2008, 11, 30, 12, 37, 0),
          utc(2008, 11, 30, 12, 37, 15),
          utc(2008, 11, 30, 12, 37, 30),
          utc(2008, 11, 30, 12, 37, 45)
        ]);
    expect(
        timeSecond.every(30)!.range(
            utc(2008, 11, 30, 12, 36, 47), utc(2008, 11, 30, 12, 37, 57)),
        [utc(2008, 11, 30, 12, 37, 0), utc(2008, 11, 30, 12, 37, 30)]);
  });
}
