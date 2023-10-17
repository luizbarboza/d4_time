import 'package:d4_time/d4_time.dart';
import 'package:test/test.dart';

import 'date.dart';

void main() {
  test("timeHour.floor(date) returns hours", () {
    expect(
        timeHour.floor(local(2010, 11, 31, 23, 59)), local(2010, 11, 31, 23));
    expect(timeHour.floor(local(2011, 0, 1, 0, 0)), local(2011, 0, 1, 0));
    expect(timeHour.floor(local(2011, 0, 1, 0, 1)), local(2011, 0, 1, 0));
  });

  test("timeHour.floor(date) observes start of daylight savings time", () {
    expect(timeHour.floor(utc(2011, 2, 13, 8, 59)), utc(2011, 2, 13, 8));
    expect(timeHour.floor(utc(2011, 2, 13, 9, 0)), utc(2011, 2, 13, 9));
    expect(timeHour.floor(utc(2011, 2, 13, 9, 1)), utc(2011, 2, 13, 9));
    expect(timeHour.floor(utc(2011, 2, 13, 9, 59)), utc(2011, 2, 13, 9));
    expect(timeHour.floor(utc(2011, 2, 13, 10, 0)), utc(2011, 2, 13, 10));
    expect(timeHour.floor(utc(2011, 2, 13, 10, 1)), utc(2011, 2, 13, 10));
  });

  test("timeHour.floor(date) observes end of daylight savings time", () {
    expect(timeHour.floor(utc(2011, 10, 6, 7, 59)), utc(2011, 10, 6, 7));
    expect(timeHour.floor(utc(2011, 10, 6, 8, 0)), utc(2011, 10, 6, 8));
    expect(timeHour.floor(utc(2011, 10, 6, 8, 1)), utc(2011, 10, 6, 8));
    expect(timeHour.floor(utc(2011, 10, 6, 8, 59)), utc(2011, 10, 6, 8));
    expect(timeHour.floor(utc(2011, 10, 6, 9, 0)), utc(2011, 10, 6, 9));
    expect(timeHour.floor(utc(2011, 10, 6, 9, 1)), utc(2011, 10, 6, 9));
  });

  test("timeHour.ceil(date) returns hours", () {
    expect(timeHour.ceil(local(2010, 11, 31, 23, 59)), local(2011, 0, 1, 0));
    expect(timeHour.ceil(local(2011, 0, 1, 0, 0)), local(2011, 0, 1, 0));
    expect(timeHour.ceil(local(2011, 0, 1, 0, 1)), local(2011, 0, 1, 1));
  });

  test("timeHour.ceil(date) observes start of daylight savings time", () {
    expect(timeHour.ceil(utc(2011, 2, 13, 8, 59)), utc(2011, 2, 13, 9));
    expect(timeHour.ceil(utc(2011, 2, 13, 9, 0)), utc(2011, 2, 13, 9));
    expect(timeHour.ceil(utc(2011, 2, 13, 9, 1)), utc(2011, 2, 13, 10));
    expect(timeHour.ceil(utc(2011, 2, 13, 9, 59)), utc(2011, 2, 13, 10));
    expect(timeHour.ceil(utc(2011, 2, 13, 10, 0)), utc(2011, 2, 13, 10));
    expect(timeHour.ceil(utc(2011, 2, 13, 10, 1)), utc(2011, 2, 13, 11));
  });

  test("timeHour.ceil(date) observes end of daylight savings time", () {
    expect(timeHour.ceil(utc(2011, 10, 6, 7, 59)), utc(2011, 10, 6, 8));
    expect(timeHour.ceil(utc(2011, 10, 6, 8, 0)), utc(2011, 10, 6, 8));
    expect(timeHour.ceil(utc(2011, 10, 6, 8, 1)), utc(2011, 10, 6, 9));
    expect(timeHour.ceil(utc(2011, 10, 6, 8, 59)), utc(2011, 10, 6, 9));
    expect(timeHour.ceil(utc(2011, 10, 6, 9, 0)), utc(2011, 10, 6, 9));
    expect(timeHour.ceil(utc(2011, 10, 6, 9, 1)), utc(2011, 10, 6, 10));
  });

  test("timeHour.offset(date) does not modify the passed-in date", () {
    final d = local(2010, 11, 31, 23, 59, 59, 999);
    timeHour.offset(d, 1);
    expect(d, local(2010, 11, 31, 23, 59, 59, 999));
  });

  test("timeHour.offset(date) does not round the passed-in-date", () {
    expect(timeHour.offset(local(2010, 11, 31, 23, 59, 59, 999), 1),
        local(2011, 0, 1, 0, 59, 59, 999));
    expect(timeHour.offset(local(2010, 11, 31, 23, 59, 59, 456), -2),
        local(2010, 11, 31, 21, 59, 59, 456));
  });

  test("timeHour.offset(date) allows negative offsets", () {
    expect(
        timeHour.offset(local(2010, 11, 31, 12), -1), local(2010, 11, 31, 11));
    expect(timeHour.offset(local(2011, 0, 1, 1), -2), local(2010, 11, 31, 23));
    expect(timeHour.offset(local(2011, 0, 1, 0), -1), local(2010, 11, 31, 23));
  });

  test("timeHour.offset(date) allows positive offsets", () {
    expect(
        timeHour.offset(local(2010, 11, 31, 11), 1), local(2010, 11, 31, 12));
    expect(timeHour.offset(local(2010, 11, 31, 23), 2), local(2011, 0, 1, 1));
    expect(timeHour.offset(local(2010, 11, 31, 23), 1), local(2011, 0, 1, 0));
  });

  test("timeHour.offset(date) allows zero offset", () {
    expect(timeHour.offset(local(2010, 11, 31, 23, 59, 59, 999), 0),
        local(2010, 11, 31, 23, 59, 59, 999));
    expect(timeHour.offset(local(2010, 11, 31, 23, 59, 58, 0), 0),
        local(2010, 11, 31, 23, 59, 58, 0));
  });

  test("timeHour.range(start, stop) returns hours", () {
    expect(
        timeHour.range(
            local(2010, 11, 31, 12, 30), local(2010, 11, 31, 15, 30)),
        [
          local(2010, 11, 31, 13),
          local(2010, 11, 31, 14),
          local(2010, 11, 31, 15)
        ]);
  });

  test("timeHour.range(start, stop) has an inclusive lower bound", () {
    expect(timeHour.range(local(2010, 11, 31, 23), local(2011, 0, 1, 2))[0],
        local(2010, 11, 31, 23));
  });

  test("timeHour.range(start, stop) has an exclusive upper bound", () {
    expect(timeHour.range(local(2010, 11, 31, 23), local(2011, 0, 1, 2))[2],
        local(2011, 0, 1, 1));
  });

  test("timeHour.range(start, stop) can skip hours", () {
    expect(timeHour.range(local(2011, 1, 1, 1), local(2011, 1, 1, 13), 3), [
      local(2011, 1, 1, 1),
      local(2011, 1, 1, 4),
      local(2011, 1, 1, 7),
      local(2011, 1, 1, 10)
    ]);
  });

  test("timeHour.range(start, stop) observes start of daylight savings time",
      () {
    expect(timeHour.range(local(2011, 2, 13, 1), local(2011, 2, 13, 5)), [
      isAtSameMomentAs(utc(2011, 2, 13, 9)),
      isAtSameMomentAs(utc(2011, 2, 13, 10)),
      isAtSameMomentAs(utc(2011, 2, 13, 11))
    ]);
  });

  test("timeHour.range(start, stop) observes end of daylight savings time", () {
    expect(timeHour.range(local(2011, 10, 6, 0), local(2011, 10, 6, 2)), [
      isAtSameMomentAs(utc(2011, 10, 6, 7)),
      isAtSameMomentAs(utc(2011, 10, 6, 8)),
      isAtSameMomentAs(utc(2011, 10, 6, 9))
    ]);
  });

  test(
      "timeHour.every(step) returns every stepth hour, starting with the first hour of the day",
      () {
    expect(
        timeHour
            .every(4)!
            .range(local(2008, 11, 30, 12, 47), local(2008, 11, 31, 13, 57)),
        [
          local(2008, 11, 30, 16),
          local(2008, 11, 30, 20),
          local(2008, 11, 31, 0),
          local(2008, 11, 31, 4),
          local(2008, 11, 31, 8),
          local(2008, 11, 31, 12)
        ]);
    expect(
        timeHour
            .every(12)!
            .range(local(2008, 11, 30, 12, 47), local(2008, 11, 31, 13, 57)),
        [local(2008, 11, 31, 0), local(2008, 11, 31, 12)]);
  });

  test(
      "timeHour.range(start, stop) returns every hour crossing the daylight savings boundary",
      () {
    expect(
        timeHour.range(
            DateTime.fromMillisecondsSinceEpoch(1478422800000 - 2 * 3600000),
            DateTime.fromMillisecondsSinceEpoch(1478422800000 + 2 * 3600000)),
        [
          DateTime.fromMillisecondsSinceEpoch(
              1478415600000), // Sun Nov  6 2016  0:00:00 GMT-0700 (PDT)
          DateTime.fromMillisecondsSinceEpoch(
              1478419200000), // Sun Nov  6 2016  1:00:00 GMT-0700 (PDT)
          DateTime.fromMillisecondsSinceEpoch(
              1478422800000), // Sun Nov  6 2016  1:00:00 GMT-0800 (PDT)
          DateTime.fromMillisecondsSinceEpoch(
              1478426400000) // Sun Nov  6 2016  2:00:00 GMT-0800 (PDT)
        ]);
  });
}
