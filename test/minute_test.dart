import 'package:d4_time/d4_time.dart';
import 'package:test/test.dart';

import 'date.dart';

void main() {
  test("timeMinute.floor(date) returns minutes", () {
    expect(timeMinute.floor(local(2010, 11, 31, 23, 59, 59)),
        local(2010, 11, 31, 23, 59));
    expect(
        timeMinute.floor(local(2011, 0, 1, 0, 0, 0)), local(2011, 0, 1, 0, 0));
    expect(
        timeMinute.floor(local(2011, 0, 1, 0, 0, 59)), local(2011, 0, 1, 0, 0));
    expect(
        timeMinute.floor(local(2011, 0, 1, 0, 1, 0)), local(2011, 0, 1, 0, 1));
  });

  test("timeMinute.ceil(date) returns minutes", () {
    expect(timeMinute.ceil(local(2010, 11, 31, 23, 59, 59)),
        local(2011, 0, 1, 0, 0));
    expect(
        timeMinute.ceil(local(2011, 0, 1, 0, 0, 0)), local(2011, 0, 1, 0, 0));
    expect(
        timeMinute.ceil(local(2011, 0, 1, 0, 0, 59)), local(2011, 0, 1, 0, 1));
    expect(
        timeMinute.ceil(local(2011, 0, 1, 0, 1, 0)), local(2011, 0, 1, 0, 1));
  });

  test("timeMinute.offset(date) does not modify the passed-in date", () {
    final d = local(2010, 11, 31, 23, 59, 59, 999);
    timeMinute.offset(d, 1);
    expect(d, local(2010, 11, 31, 23, 59, 59, 999));
  });

  test("timeMinute.offset(date) does not round the passed-in-date", () {
    expect(timeMinute.offset(local(2010, 11, 31, 23, 59, 59, 999), 1),
        local(2011, 0, 1, 0, 0, 59, 999));
    expect(timeMinute.offset(local(2010, 11, 31, 23, 59, 59, 456), -2),
        local(2010, 11, 31, 23, 57, 59, 456));
  });

  test("timeMinute.offset(date) allows negative offsets", () {
    expect(timeMinute.offset(local(2010, 11, 31, 23, 12), -1),
        local(2010, 11, 31, 23, 11));
    expect(timeMinute.offset(local(2011, 0, 1, 0, 1), -2),
        local(2010, 11, 31, 23, 59));
    expect(timeMinute.offset(local(2011, 0, 1, 0, 0), -1),
        local(2010, 11, 31, 23, 59));
  });

  test("timeMinute.offset(date) allows positive offsets", () {
    expect(timeMinute.offset(local(2010, 11, 31, 23, 11), 1),
        local(2010, 11, 31, 23, 12));
    expect(timeMinute.offset(local(2010, 11, 31, 23, 59), 2),
        local(2011, 0, 1, 0, 1));
    expect(timeMinute.offset(local(2010, 11, 31, 23, 59), 1),
        local(2011, 0, 1, 0, 0));
  });

  test("timeMinute.offset(date) allows zero offset", () {
    expect(timeMinute.offset(local(2010, 11, 31, 23, 59, 59, 999), 0),
        local(2010, 11, 31, 23, 59, 59, 999));
    expect(timeMinute.offset(local(2010, 11, 31, 23, 59, 58, 0), 0),
        local(2010, 11, 31, 23, 59, 58, 0));
  });

  test("timeMinute.range(start, stop), returns minutes", () {
    expect(
        timeMinute.range(local(2010, 11, 31, 23, 59), local(2011, 0, 1, 0, 2)),
        [
          local(2010, 11, 31, 23, 59),
          local(2011, 0, 1, 0, 0),
          local(2011, 0, 1, 0, 1)
        ]);
  });

  test("timeMinute.range(start, stop), has an inclusive lower bound", () {
    expect(
        timeMinute.range(
            local(2010, 11, 31, 23, 59), local(2011, 0, 1, 0, 2))[0],
        local(2010, 11, 31, 23, 59));
  });

  test("timeMinute.range(start, stop), has an exclusive upper bound", () {
    expect(
        timeMinute.range(
            local(2010, 11, 31, 23, 59), local(2011, 0, 1, 0, 2))[2],
        local(2011, 0, 1, 0, 1));
  });

  test("timeMinute.range(start, stop), can skip minutes", () {
    expect(
        timeMinute.range(
            local(2011, 1, 1, 12, 7), local(2011, 1, 1, 13, 7), 15),
        [
          local(2011, 1, 1, 12, 7),
          local(2011, 1, 1, 12, 22),
          local(2011, 1, 1, 12, 37),
          local(2011, 1, 1, 12, 52)
        ]);
  });

  test("timeMinute.range(start, stop), observes start of daylight savings time",
      () {
    expect(timeMinute.range(utc(2011, 2, 13, 9, 59), utc(2011, 2, 13, 10, 2)), [
      utc(2011, 2, 13, 9, 59),
      utc(2011, 2, 13, 10, 0),
      utc(2011, 2, 13, 10, 1)
    ]);
  });

  test("timeMinute.range(start, stop), observes end of daylight savings time",
      () {
    expect(
        timeMinute.range(utc(2011, 10, 6, 8, 59), (utc(2011, 10, 6, 9, 2))), [
      utc(2011, 10, 6, 8, 59),
      utc(2011, 10, 6, 9, 0),
      utc(2011, 10, 6, 9, 1)
    ]);
  });

  test(
      "timeMinute.every(step) returns every stepth minute, starting with the first minute of the hour",
      () {
    expect(
        timeMinute
            .every(15)!
            .range(local(2008, 11, 30, 12, 47), local(2008, 11, 30, 13, 57)),
        [
          local(2008, 11, 30, 13, 0),
          local(2008, 11, 30, 13, 15),
          local(2008, 11, 30, 13, 30),
          local(2008, 11, 30, 13, 45)
        ]);
    expect(
        timeMinute
            .every(30)!
            .range(local(2008, 11, 30, 12, 47), local(2008, 11, 30, 13, 57)),
        [local(2008, 11, 30, 13, 0), local(2008, 11, 30, 13, 30)]);
  });

  test(
      "timeMinute.range(start, stop) returns every minute crossing the daylight savings boundary",
      () {
    expect(
        timeMinute.range(
            DateTime.fromMillisecondsSinceEpoch(1478422800000 - 2 * 60000),
            DateTime.fromMillisecondsSinceEpoch(1478422800000 + 2 * 60000)),
        [
          DateTime.fromMillisecondsSinceEpoch(
              1478422680000), // Sun Nov  6 2016  1:58:00 GMT-0700 (PDT)
          DateTime.fromMillisecondsSinceEpoch(
              1478422740000), // Sun Nov  6 2016  1:59:00 GMT-0700 (PDT)
          DateTime.fromMillisecondsSinceEpoch(
              1478422800000), // Sun Nov  6 2016  1:00:00 GMT-0800 (PDT)
          DateTime.fromMillisecondsSinceEpoch(
              1478422860000) // Sun Nov  6 2016  1:01:00 GMT-0800 (PDT)
        ]);
  });
}
