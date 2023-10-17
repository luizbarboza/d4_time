import 'package:d4_time/d4_time.dart';
import 'package:test/test.dart';

import 'date.dart';

void main() {
  test("timeRange(start, stop, interval) respects the specified interval", () {
    expect(
        timeRange(local(2011, 0, 1, 12, 1, 0), local(2011, 0, 1, 12, 4, 4),
            timeMinute),
        [
          local(2011, 0, 1, 12, 1),
          local(2011, 0, 1, 12, 2),
          local(2011, 0, 1, 12, 3),
          local(2011, 0, 1, 12, 4)
        ]);
  });

  test(
      "timeRange(start, stop, interval.every(step)) observes the specified tick interval and step",
      () {
    expect(
        timeRange(local(2011, 0, 1, 12, 0, 0), local(2011, 0, 1, 12, 33, 4),
            timeMinute.every(10)!),
        [
          local(2011, 0, 1, 12, 0),
          local(2011, 0, 1, 12, 10),
          local(2011, 0, 1, 12, 20),
          local(2011, 0, 1, 12, 30)
        ]);
  });

  test("timeTicks(start, stop, count) can generate sub-second ticks", () {
    expect(
        timeTicks(local(2011, 0, 1, 12, 0, 0), local(2011, 0, 1, 12, 0, 1), 4),
        [
          local(2011, 0, 1, 12, 0, 0, 0),
          local(2011, 0, 1, 12, 0, 0, 200),
          local(2011, 0, 1, 12, 0, 0, 400),
          local(2011, 0, 1, 12, 0, 0, 600),
          local(2011, 0, 1, 12, 0, 0, 800),
          local(2011, 0, 1, 12, 0, 1, 0)
        ]);
  });

  test("timeTicks(start, stop, count) can generate 1-second ticks", () {
    expect(
        timeTicks(local(2011, 0, 1, 12, 0, 0), local(2011, 0, 1, 12, 0, 4), 4),
        [
          local(2011, 0, 1, 12, 0, 0),
          local(2011, 0, 1, 12, 0, 1),
          local(2011, 0, 1, 12, 0, 2),
          local(2011, 0, 1, 12, 0, 3),
          local(2011, 0, 1, 12, 0, 4)
        ]);
  });

  test("timeTicks(start, stop, count) can generate 5-second ticks", () {
    expect(
        timeTicks(local(2011, 0, 1, 12, 0, 0), local(2011, 0, 1, 12, 0, 20), 4),
        [
          local(2011, 0, 1, 12, 0, 0),
          local(2011, 0, 1, 12, 0, 5),
          local(2011, 0, 1, 12, 0, 10),
          local(2011, 0, 1, 12, 0, 15),
          local(2011, 0, 1, 12, 0, 20)
        ]);
  });

  test("timeTicks(start, stop, count) can generate 15-second ticks", () {
    expect(
        timeTicks(local(2011, 0, 1, 12, 0, 0), local(2011, 0, 1, 12, 0, 50), 4),
        [
          local(2011, 0, 1, 12, 0, 0),
          local(2011, 0, 1, 12, 0, 15),
          local(2011, 0, 1, 12, 0, 30),
          local(2011, 0, 1, 12, 0, 45)
        ]);
  });

  test("timeTicks(start, stop, count) can generate 30-second ticks", () {
    expect(
        timeTicks(local(2011, 0, 1, 12, 0, 0), local(2011, 0, 1, 12, 1, 50), 4),
        [
          local(2011, 0, 1, 12, 0, 0),
          local(2011, 0, 1, 12, 0, 30),
          local(2011, 0, 1, 12, 1, 0),
          local(2011, 0, 1, 12, 1, 30)
        ]);
  });

  test("timeTicks(start, stop, count) can generate 1-minute ticks", () {
    expect(
        timeTicks(
            local(2011, 0, 1, 12, 0, 27), local(2011, 0, 1, 12, 4, 12), 4),
        [
          local(2011, 0, 1, 12, 1),
          local(2011, 0, 1, 12, 2),
          local(2011, 0, 1, 12, 3),
          local(2011, 0, 1, 12, 4)
        ]);
  });

  test("timeTicks(start, stop, count) can generate 5-minute ticks", () {
    expect(
        timeTicks(
            local(2011, 0, 1, 12, 3, 27), local(2011, 0, 1, 12, 21, 12), 4),
        [
          local(2011, 0, 1, 12, 5),
          local(2011, 0, 1, 12, 10),
          local(2011, 0, 1, 12, 15),
          local(2011, 0, 1, 12, 20)
        ]);
  });

  test("timeTicks(start, stop, count) can generate 15-minute ticks", () {
    expect(
        timeTicks(
            local(2011, 0, 1, 12, 8, 27), local(2011, 0, 1, 13, 4, 12), 4),
        [
          local(2011, 0, 1, 12, 15),
          local(2011, 0, 1, 12, 30),
          local(2011, 0, 1, 12, 45),
          local(2011, 0, 1, 13, 0)
        ]);
  });

  test("timeTicks(start, stop, count) can generate 30-minute ticks", () {
    expect(
        timeTicks(
            local(2011, 0, 1, 12, 28, 27), local(2011, 0, 1, 14, 4, 12), 4),
        [
          local(2011, 0, 1, 12, 30),
          local(2011, 0, 1, 13, 0),
          local(2011, 0, 1, 13, 30),
          local(2011, 0, 1, 14, 0)
        ]);
  });

  test("timeTicks(start, stop, count) can generate 1-hour ticks", () {
    expect(
        timeTicks(
            local(2011, 0, 1, 12, 28, 27), local(2011, 0, 1, 16, 34, 12), 4),
        [
          local(2011, 0, 1, 13, 0),
          local(2011, 0, 1, 14, 0),
          local(2011, 0, 1, 15, 0),
          local(2011, 0, 1, 16, 0)
        ]);
  });

  test("timeTicks(start, stop, count) can generate 3-hour ticks", () {
    expect(
        timeTicks(
            local(2011, 0, 1, 14, 28, 27), local(2011, 0, 2, 1, 34, 12), 4),
        [
          local(2011, 0, 1, 15, 0),
          local(2011, 0, 1, 18, 0),
          local(2011, 0, 1, 21, 0),
          local(2011, 0, 2, 0, 0)
        ]);
  });

  test("timeTicks(start, stop, count) can generate 6-hour ticks", () {
    expect(
        timeTicks(
            local(2011, 0, 1, 16, 28, 27), local(2011, 0, 2, 14, 34, 12), 4),
        [
          local(2011, 0, 1, 18, 0),
          local(2011, 0, 2, 0, 0),
          local(2011, 0, 2, 6, 0),
          local(2011, 0, 2, 12, 0)
        ]);
  });

// Note: not aligned at midnight because of daylight savings time!
  test(
      "timeTicks(start, stop, count) can generate 6-hour ticks across daylight savings time",
      () {
    expect(
        timeTicks(
            local(2011, 3, 1, 16, 28, 27), local(2011, 3, 2, 14, 34, 12), 4),
        [
          local(2011, 3, 1, 19, 0),
          local(2011, 3, 2, 1, 0),
          local(2011, 3, 2, 7, 0),
          local(2011, 3, 2, 13, 0)
        ]);
  });

  test("timeTicks(start, stop, count) can generate 12-hour ticks", () {
    expect(
        timeTicks(
            local(2011, 0, 1, 16, 28, 27), local(2011, 0, 3, 21, 34, 12), 4),
        [
          local(2011, 0, 2, 0, 0),
          local(2011, 0, 2, 12, 0),
          local(2011, 0, 3, 0, 0),
          local(2011, 0, 3, 12, 0)
        ]);
  });

  test("timeTicks(start, stop, count) can generate 1-day ticks", () {
    expect(
        timeTicks(
            local(2011, 0, 1, 16, 28, 27), local(2011, 0, 5, 21, 34, 12), 4),
        [
          local(2011, 0, 2, 0, 0),
          local(2011, 0, 3, 0, 0),
          local(2011, 0, 4, 0, 0),
          local(2011, 0, 5, 0, 0)
        ]);
  });

  test("timeTicks(start, stop, count) can generate 2-day ticks", () {
    expect(
        timeTicks(
            local(2011, 0, 2, 16, 28, 27), local(2011, 0, 9, 21, 34, 12), 4),
        [
          local(2011, 0, 4, 0, 0),
          local(2011, 0, 6, 0, 0),
          local(2011, 0, 8, 0, 0)
        ]);
  });

  test("timeTicks(start, stop, count) can generate 1-week ticks", () {
    expect(
        timeTicks(
            local(2011, 0, 1, 16, 28, 27), local(2011, 0, 23, 21, 34, 12), 4),
        [
          local(2011, 0, 2, 0, 0),
          local(2011, 0, 9, 0, 0),
          local(2011, 0, 16, 0, 0),
          local(2011, 0, 23, 0, 0)
        ]);
  });

  test("timeTicks(start, stop, count) can generate 1-month ticks", () {
    expect(timeTicks(local(2011, 0, 18), local(2011, 4, 2), 4), [
      local(2011, 1, 1, 0, 0),
      local(2011, 2, 1, 0, 0),
      local(2011, 3, 1, 0, 0),
      local(2011, 4, 1, 0, 0)
    ]);
  });

  test("timeTicks(start, stop, count) can generate 3-month ticks", () {
    expect(timeTicks(local(2010, 11, 18), local(2011, 10, 2), 4), [
      local(2011, 0, 1, 0, 0),
      local(2011, 3, 1, 0, 0),
      local(2011, 6, 1, 0, 0),
      local(2011, 9, 1, 0, 0)
    ]);
  });

  test("timeTicks(start, stop, count) can generate 1-year ticks", () {
    expect(timeTicks(local(2010, 11, 18), local(2014, 2, 2), 4), [
      local(2011, 0, 1, 0, 0),
      local(2012, 0, 1, 0, 0),
      local(2013, 0, 1, 0, 0),
      local(2014, 0, 1, 0, 0)
    ]);
  });

  test("timeTicks(start, stop, count) can generate multi-year ticks", () {
    expect(timeTicks(local(0, 11, 18), local(2014, 2, 2), 6), [
      local(500, 0, 1, 0, 0),
      local(1000, 0, 1, 0, 0),
      local(1500, 0, 1, 0, 0),
      local(2000, 0, 1, 0, 0)
    ]);
  });

  test("timeTicks(start, stop, count) returns one tick for an empty domain",
      () {
    expect(timeTicks(local(2014, 2, 2), local(2014, 2, 2), 6),
        [local(2014, 2, 2)]);
  });

  test(
      "timeTicks(start, stop, count) returns descending ticks for a descending domain",
      () {
    expect(timeTicks(local(2014, 2, 2), local(2010, 11, 18), 4), [
      local(2014, 0, 1, 0, 0),
      local(2013, 0, 1, 0, 0),
      local(2012, 0, 1, 0, 0),
      local(2011, 0, 1, 0, 0)
    ]);
    expect(timeTicks(local(2011, 10, 2), local(2010, 11, 18), 4), [
      local(2011, 9, 1, 0, 0),
      local(2011, 6, 1, 0, 0),
      local(2011, 3, 1, 0, 0),
      local(2011, 0, 1, 0, 0)
    ]);
  });
}
