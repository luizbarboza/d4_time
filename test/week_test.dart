import 'package:d4_time/d4_time.dart';
import 'package:test/test.dart';

import 'date.dart';

void main() {
  test("timeWeek.floor(date) returns sundays", () {
    expect(
        timeWeek.floor(local(2010, 11, 31, 23, 59, 59)), local(2010, 11, 26));
    expect(timeWeek.floor(local(2011, 0, 1, 0, 0, 0)), local(2010, 11, 26));
    expect(timeWeek.floor(local(2011, 0, 1, 0, 0, 1)), local(2010, 11, 26));
    expect(timeWeek.floor(local(2011, 0, 1, 23, 59, 59)), local(2010, 11, 26));
    expect(timeWeek.floor(local(2011, 0, 2, 0, 0, 0)), local(2011, 0, 2));
    expect(timeWeek.floor(local(2011, 0, 2, 0, 0, 1)), local(2011, 0, 2));
  });

  test("timeWeek.floor(date) observes the start of daylight savings time", () {
    expect(timeWeek.floor(local(2011, 2, 13, 1)), local(2011, 2, 13));
  });

  test("timeWeek.floor(date) observes the end of the daylight savings time",
      () {
    expect(timeWeek.floor(local(2011, 10, 6, 1)), local(2011, 10, 6));
  });

  test("timeWeek.floor(date) correctly handles years in the first century", () {
    expect(timeWeek.floor(local(9, 10, 6, 7)), local(9, 10, 1));
  });

  test("timeWeek.ceil(date) returns sundays", () {
    expect(timeWeek.ceil(local(2010, 11, 31, 23, 59, 59)), local(2011, 0, 2));
    expect(timeWeek.ceil(local(2011, 0, 1, 0, 0, 0)), local(2011, 0, 2));
    expect(timeWeek.ceil(local(2011, 0, 1, 0, 0, 1)), local(2011, 0, 2));
    expect(timeWeek.ceil(local(2011, 0, 1, 23, 59, 59)), local(2011, 0, 2));
    expect(timeWeek.ceil(local(2011, 0, 2, 0, 0, 0)), local(2011, 0, 2));
    expect(timeWeek.ceil(local(2011, 0, 2, 0, 0, 1)), local(2011, 0, 9));
  });

  test("timeWeek.ceil(date) observes the start of daylight savings time", () {
    expect(timeWeek.ceil(local(2011, 2, 13, 1)), local(2011, 2, 20));
  });

  test("timeWeek.ceil(date) observes the end of the daylight savings time", () {
    expect(timeWeek.ceil(local(2011, 10, 6, 1)), local(2011, 10, 13));
  });

  test("timeWeek.offset(date, step) does not modify the passed-in date", () {
    final d = local(2010, 11, 31, 23, 59, 59, 999);
    timeWeek.offset(d, 1);
    expect(d, local(2010, 11, 31, 23, 59, 59, 999));
  });

  test("timeWeek.offset(date, step) does not round the passed-in-date", () {
    expect(timeWeek.offset(local(2010, 11, 31, 23, 59, 59, 999), 1),
        local(2011, 0, 7, 23, 59, 59, 999));
    expect(timeWeek.offset(local(2010, 11, 31, 23, 59, 59, 456), -2),
        local(2010, 11, 17, 23, 59, 59, 456));
  });

  test("timeWeek.offset(date, step) allows negative offsets", () {
    expect(timeWeek.offset(local(2010, 11, 1), -1), local(2010, 10, 24));
    expect(timeWeek.offset(local(2011, 0, 1), -2), local(2010, 11, 18));
    expect(timeWeek.offset(local(2011, 0, 1), -1), local(2010, 11, 25));
  });

  test("timeWeek.offset(date, step) allows positive offsets", () {
    expect(timeWeek.offset(local(2010, 10, 24), 1), local(2010, 11, 1));
    expect(timeWeek.offset(local(2010, 11, 18), 2), local(2011, 0, 1));
    expect(timeWeek.offset(local(2010, 11, 25), 1), local(2011, 0, 1));
  });

  test("timeWeek.offset(date, step) allows zero offset", () {
    expect(timeWeek.offset(local(2010, 11, 31, 23, 59, 59, 999), 0),
        local(2010, 11, 31, 23, 59, 59, 999));
    expect(timeWeek.offset(local(2010, 11, 31, 23, 59, 58, 0), 0),
        local(2010, 11, 31, 23, 59, 58, 0));
  });

  test("timeWeek.range(start, stop) returns sundays", () {
    expect(timeWeek.range(local(2010, 11, 21), local(2011, 0, 12)),
        [local(2010, 11, 26), local(2011, 0, 2), local(2011, 0, 9)]);
  });

  test("timeWeek.range(start, stop) has an inclusive lower bound", () {
    expect(timeWeek.range(local(2010, 11, 21), local(2011, 0, 12))[0],
        local(2010, 11, 26));
  });

  test("timeWeek.range(start, stop) has an exclusive upper bound", () {
    expect(timeWeek.range(local(2010, 11, 21), local(2011, 0, 12))[2],
        local(2011, 0, 9));
  });

  test("timeWeek.range(start, stop) can skip weeks", () {
    expect(timeWeek.range(local(2011, 0, 1), local(2011, 3, 1), 4), [
      local(2011, 0, 2),
      local(2011, 0, 30),
      local(2011, 1, 27),
      local(2011, 2, 27)
    ]);
  });

  test("timeWeek.range(start, stop) observes start of daylight savings time",
      () {
    expect(timeWeek.range(local(2011, 2, 1), local(2011, 2, 28)), [
      local(2011, 2, 6),
      local(2011, 2, 13),
      local(2011, 2, 20),
      local(2011, 2, 27)
    ]);
  });

  test("timeWeek.range(start, stop) observes end of daylight savings time", () {
    expect(timeWeek.range(local(2011, 10, 1), local(2011, 10, 30)), [
      local(2011, 10, 6),
      local(2011, 10, 13),
      local(2011, 10, 20),
      local(2011, 10, 27)
    ]);
  });

  test("timeWeek is an alias for timeSunday", () {
    expect(timeWeek, timeSunday);
  });

  test(
      "timeWeek.every(step) returns every stepth Sunday, starting with the first Sunday of the month",
      () {
    expect(timeWeek.every(2)!.range(local(2008, 11, 3), local(2009, 1, 5)), [
      local(2008, 11, 7),
      local(2008, 11, 21),
      local(2009, 0, 4),
      local(2009, 0, 18),
      local(2009, 1, 1)
    ]);
  });
}
