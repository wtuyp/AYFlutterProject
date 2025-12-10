
extension DateTimeExtension on DateTime {

  // 周第一天 （firstDayOfWeek 周起始日）
  DateTime firstDayOfWeek({int firstWeekDay = DateTime.monday}) {
    assert(firstWeekDay >= 1 && firstWeekDay <= 7);
    int offset = (weekday - firstWeekDay) % DateTime.daysPerWeek;
    return subtract(Duration(days: offset));
  }

  // 周最后一天 firstDayOfWeek 周起始日）
  DateTime lastDayOfWeek({int firstWeekDay = DateTime.monday}) {
    DateTime firstDay = firstDayOfWeek(firstWeekDay: firstWeekDay);
    return firstDay.add(Duration(days: DateTime.daysPerWeek - 1));
  }

  // 月第一天0点
  DateTime get firstDayOfMonth => DateTime(year, month, 1);
  // 月最后一天0点
  DateTime get lastDayOfMonth => DateTime(year, month + 1, 0);

  // 年第一天0点
  DateTime get firstDayOfYear => DateTime(year, 1, 1);
  // 年最后一天0点
  DateTime get lastDayOfYear => DateTime(year, 12, 31);

  // 0点的时间
  DateTime dateAtZero() {
    return DateTime(year, month, day);
  }

  // 23点59分59秒 的时间
  DateTime dateAtLatest() {
    return DateTime(year, month, day, 23, 59, 59);
  }

  // 是否同一天
  bool isSameDay(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }

  // 时间戳（秒）后续改成 secondsSinceEpoch
  int get timestampOfSecond => millisecondsSinceEpoch ~/ 1000;

  // 时间戳（秒）转 DateTime
  static DateTime fromSecondsSinceEpoch(int secondsSinceEpoch, {bool isUtc = false,}) {
    return DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000, isUtc: isUtc);
  }

  // DateTime 转 时间戳（秒）
  int secondsSinceEpoch() {
    return millisecondsSinceEpoch ~/ 1000;
  }

  // 获取当前时间的分钟所对应的时间戳（秒）
  int getMinuteTimestamp() {
    DateTime date = DateTime(year, month, day, hour, minute);
    return date.secondsSinceEpoch();
  }

  // 获取当前时间的时所对应的时间戳（秒）
  int getHourTimestamp() {
    DateTime date = DateTime(year, month, day, hour);
    return date.secondsSinceEpoch();
  }

  // 获取分钟数
  int getMinutes() {
    return hour * 60 + minute;
  }

}
