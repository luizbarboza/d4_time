import 'package:d4_time/d4_time.dart';
import 'package:test/test.dart';

import 'date.dart';

void main() {
  test("timeYear.floor(date) returns years", () {
    expect(timeYear.floor(utc(2010, 11, 31, 23, 59, 59)), utc(2010, 0, 1));
    expect(timeYear.floor(utc(2011, 0, 1, 0, 0, 0)), utc(2011, 0, 1));
    expect(timeYear.floor(utc(2011, 0, 1, 0, 0, 1)), utc(2011, 0, 1));
  });

  test("timeYear.floor(date) does not modify the specified date", () {
    final d = utc(2010, 11, 31, 23, 59, 59);
    expect(timeYear.floor(d), utc(2010, 0, 1));
    expect(d, utc(2010, 11, 31, 23, 59, 59));
  });

  test("timeYear.floor(date) correctly handles years in the first century", () {
    expect(timeYear.floor(utc(9, 10, 6, 7)), utc(9, 0, 1));
  });

  test("timeYear.ceil(date) returns years", () {
    expect(timeYear.ceil(utc(2010, 11, 31, 23, 59, 59)), utc(2011, 0, 1));
    expect(timeYear.ceil(utc(2011, 0, 1, 0, 0, 0)), utc(2011, 0, 1));
    expect(timeYear.ceil(utc(2011, 0, 1, 0, 0, 1)), utc(2012, 0, 1));
  });

  test("timeYear.offset(date, count) does not modify the passed-in date", () {
    final d = utc(2010, 11, 31, 23, 59, 59, 999);
    timeYear.offset(d, 1);
    expect(d, utc(2010, 11, 31, 23, 59, 59, 999));
  });

  test("timeYear.offset(date, count) does not round the passed-in-date", () {
    expect(timeYear.offset(utc(2010, 11, 31, 23, 59, 59, 999), 1),
        utc(2011, 11, 31, 23, 59, 59, 999));
    expect(timeYear.offset(utc(2010, 11, 31, 23, 59, 59, 456), -2),
        utc(2008, 11, 31, 23, 59, 59, 456));
  });

  test("timeYear.offset(date, count) allows negative offsets", () {
    expect(timeYear.offset(utc(2010, 11, 1), -1), utc(2009, 11, 1));
    expect(timeYear.offset(utc(2011, 0, 1), -2), utc(2009, 0, 1));
    expect(timeYear.offset(utc(2011, 0, 1), -1), utc(2010, 0, 1));
  });

  test("timeYear.offset(date, count) allows positive offsets", () {
    expect(timeYear.offset(utc(2009, 11, 1), 1), utc(2010, 11, 1));
    expect(timeYear.offset(utc(2009, 0, 1), 2), utc(2011, 0, 1));
    expect(timeYear.offset(utc(2010, 0, 1), 1), utc(2011, 0, 1));
  });

  test("timeYear.offset(date, count) allows zero offset", () {
    expect(timeYear.offset(utc(2010, 11, 31, 23, 59, 59, 999), 0),
        utc(2010, 11, 31, 23, 59, 59, 999));
    expect(timeYear.offset(utc(2010, 11, 31, 23, 59, 58, 0), 0),
        utc(2010, 11, 31, 23, 59, 58, 0));
  });

  test(
      "timeYear.every(step) returns every stepth year, starting with year zero",
      () {
    expect(timeYear.every(5)!.range(utc(2008), utc(2023)),
        [utc(2010), utc(2015), utc(2020)]);
  });

  test("timeYear.range(start, stop) returns years", () {
    expect(timeYear.range(utc(2010, 0, 1), utc(2013, 0, 1)),
        [utc(2010, 0, 1), utc(2011, 0, 1), utc(2012, 0, 1)]);
  });

  test("timeYear.range(start, stop) has an inclusive lower bound", () {
    expect(
        timeYear.range(utc(2010, 0, 1), utc(2013, 0, 1))[0], utc(2010, 0, 1));
  });

  test("timeYear.range(start, stop) has an exclusive upper bound", () {
    expect(
        timeYear.range(utc(2010, 0, 1), utc(2013, 0, 1))[2], utc(2012, 0, 1));
  });

  test("timeYear.range(start, stop, step) can skip years", () {
    expect(timeYear.range(utc(2009, 0, 1), utc(2029, 0, 1), 5),
        [utc(2009, 0, 1), utc(2014, 0, 1), utc(2019, 0, 1), utc(2024, 0, 1)]);
  });
}
