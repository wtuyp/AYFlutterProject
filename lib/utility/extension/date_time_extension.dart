
extension DateTimeExtension on DateTime {

  /// 0点的时间
  DateTime get atZero => DateTime(year, month, day);

  /// 周第一天
  /// [firstWeekDay] 周起始日（默认：周一）
  DateTime firstDayOfWeek({int firstWeekDay = DateTime.monday}) {
    assert(firstWeekDay >= 1 && firstWeekDay <= 7);
    int offset = (weekday - firstWeekDay) % DateTime.daysPerWeek;
    return subtract(Duration(days: offset));
  }

  /// 周最后一天
  /// [firstWeekDay] 周起始日（默认：周一）
  DateTime lastDayOfWeek({int firstWeekDay = DateTime.monday}) {
    DateTime firstDay = firstDayOfWeek(firstWeekDay: firstWeekDay);
    return firstDay.add(Duration(days: DateTime.daysPerWeek - 1));
  }

  /// 月第一天
  DateTime firstDayOfMonth() => DateTime(year, month, 1, hour, minute, millisecond, microsecond);
  /// 月最后一天
  DateTime lastDayOfMonth() => DateTime(year, month + 1, 0, hour, minute, millisecond, microsecond);

  /// 年第一天
  DateTime firstDayOfYear() => DateTime(year, 1, 1, hour, minute, millisecond, microsecond);
  /// 年最后一天
  DateTime lastDayOfYear() => DateTime(year, 12, 31, hour, minute, millisecond, microsecond);

  /// 是否同一天
  bool isSameDay(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }

  /// 转换为相对时间字符串（例如：1天前、1小时前等）
  String toRelativeTimeString() {
    final difference = DateTime.now().difference(this);

    if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}月前';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}天前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}小时前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }

}

/// 时间戳（秒）
extension DateTimeTimestamp on DateTime {

  /// 时间戳（秒）
  int get secondsSinceEpoch => millisecondsSinceEpoch ~/ 1000;

  /// 分钟所对应的时间戳（秒）
  int getMinuteTimestamp() {
    DateTime date = DateTime(year, month, day, hour, minute);
    return date.secondsSinceEpoch;
  }

  /// 整点所对应的时间戳（秒）
  int getHourTimestamp() {
    DateTime date = DateTime(year, month, day, hour);
    return date.secondsSinceEpoch;
  }
}

/// 时间格式化 (因为使用 format 比较耗时)
extension DateTimeFormat on DateTime {

  /// 转成 yyyy-MM-dd HH:mm:ss 格式的字符串
  String toDateTimeString() {
    final String year = this.year.toString().padLeft(4, '0');
    final String month = this.month.toString().padLeft(2, '0');
    final String day = this.day.toString().padLeft(2, '0');
    final String hour = this.hour.toString().padLeft(2, '0');
    final String minute = this.minute.toString().padLeft(2, '0');
    final String second = this.second.toString().padLeft(2, '0');
    return '$year-$month-$day $hour:$minute:$second';
  }

  /// 转成 yyyy-MM-dd 格式的字符串
  String toDateString() {
    final String year = this.year.toString().padLeft(4, '0');
    final String month = this.month.toString().padLeft(2, '0');
    final String day = this.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  /// 转成 yyyy-MM 格式的字符串
  String toMonthString() {
    final String year = this.year.toString().padLeft(4, '0');
    final String month = this.month.toString().padLeft(2, '0');
    return '$year-$month';
  }

  /// 转成 HH:mm 格式的字符串
  String toTimeString() {
    final String hour = this.hour.toString().padLeft(2, '0');
    final String minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  /// 转成 yyyyMMdd 格式的字符串
  String toCompactDateString() {
    final String year = this.year.toString().padLeft(4, '0');
    final String month = this.month.toString().padLeft(2, '0');
    final String day = this.day.toString().padLeft(2, '0');
    return '$year$month$day';
  }
}

