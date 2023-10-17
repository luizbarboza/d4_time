import 'package:d4_time/d4_time.dart';
import 'package:test/test.dart';

import 'date.dart';

void main() {
  test("timeYear.every(n).floor(date) returns integer multiples of n years",
      () {
    expect(timeYear.every(10)!.floor(utc(2009, 11, 31, 23, 59, 59)),
        utc(2000, 0, 1));
    expect(
        timeYear.every(10)!.floor(utc(2010, 0, 1, 0, 0, 0)), utc(2010, 0, 1));
    expect(
        timeYear.every(10)!.floor(utc(2010, 0, 1, 0, 0, 1)), utc(2010, 0, 1));
  });

  test("timeYear.every(n).ceil(date) returns integer multiples of n years", () {
    expect(timeYear.every(100)!.ceil(utc(1999, 11, 31, 23, 59, 59)),
        utc(2000, 0, 1));
    expect(
        timeYear.every(100)!.ceil(utc(2000, 0, 1, 0, 0, 0)), utc(2000, 0, 1));
    expect(
        timeYear.every(100)!.ceil(utc(2000, 0, 1, 0, 0, 1)), utc(2100, 0, 1));
  });

  test(
      "timeYear.every(n).offset(date, count) does not modify the passed-in date",
      () {
    final d = utc(2010, 11, 31, 23, 59, 59, 999);
    timeYear.every(5)!.offset(d, 1);
    expect(d, utc(2010, 11, 31, 23, 59, 59, 999));
  });

  test(
      "timeYear.every(n).offset(date, count) does not round the passed-in-date",
      () {
    expect(timeYear.every(5)!.offset(utc(2010, 11, 31, 23, 59, 59, 999), 1),
        utc(2015, 11, 31, 23, 59, 59, 999));
    expect(timeYear.every(5)!.offset(utc(2010, 11, 31, 23, 59, 59, 456), -2),
        utc(2000, 11, 31, 23, 59, 59, 456));
  });

  test("timeYear.every(n) does not define interval.count or interval.every",
      () {
    final decade = timeYear.every(10)!;
    expect(decade.count(utc(2003), utc(2023)), null);
    expect(decade.every(1), null);
  });

  test("timeYear.every(n).range(start, stop) returns multiples of n years", () {
    expect(timeYear.every(10)!.range(utc(2010, 0, 1), utc(2031, 0, 1)),
        [utc(2010, 0, 1), utc(2020, 0, 1), utc(2030, 0, 1)]);
  });
}
