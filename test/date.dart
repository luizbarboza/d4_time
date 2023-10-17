import 'package:test/test.dart';

DateTime local(
  int year, [
  int month = 0,
  int day = 1,
  int hour = 0,
  int minute = 0,
  int second = 0,
  int millisecond = 0,
  int microsecond = 0,
]) {
  return DateTime(
      year, month + 1, day, hour, minute, second, millisecond, microsecond);
}

DateTime utc(
  int year, [
  int month = 0,
  int day = 1,
  int hour = 0,
  int minute = 0,
  int second = 0,
  int millisecond = 0,
  int microsecond = 0,
]) {
  return DateTime.utc(
      year, month + 1, day, hour, minute, second, millisecond, microsecond);
}

Matcher isAtSameMomentAs(DateTime expected) {
  return predicate(
      (actual) => actual is DateTime && actual.isAtSameMomentAs(expected),
      "A DateTime object that occurs at the same moment as $expected");
}
