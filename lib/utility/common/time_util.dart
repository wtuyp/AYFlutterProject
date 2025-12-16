
import 'package:app/utility/extention/date_time_extension.dart';
import 'package:intl/intl.dart';

class TimeUtil {

  // 分钟转时间显示，如 100 -> 01:40
  static String timeStringFromMinutes(int minutes) {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;
    return '${hours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')}';
  }

  // 时间显示转分钟，如 01:40 -> 100
  static int minutesFromTimeString(String timeString) {
    List<String> parts = timeString.split(':');
    if (parts.length != 2) {
      return 0;
    }

    int hours = int.tryParse(parts[0]) ?? 0;
    int minutes = int.tryParse(parts[1]) ?? 0;
    return hours * 60 + minutes;
  }

  /// 获取指定日期0点的DateTime对象
  static DateTime getMidnightOf(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// 获取当天0点的DateTime对象
  static DateTime getMidnight([DateTime? referenceDate]) {
    final now = referenceDate ?? DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// 获取当天0点的字符串表示（格式：yyyy-MM-dd HH:mm:ss）
  static String getMidnightString() {
    final midnight = getMidnight();
    return getDateTimeString(midnight);
  }

  /// 获取指定日期的字符串表示（格式：yyyy-MM-dd HH:mm:ss）
  static String getDateTimeString(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  /// 获取指定日期的字符串表示（格式：yyyy-MM-dd）
  static String getDateString(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }

  /// 获取指定日期的字符串表示（格式：yyyyMMdd）
  static String getDateString_yyyyMMdd(DateTime dateTime) {
    return '${dateTime.year}${dateTime.month.toString().padLeft(2, '0')}${dateTime.day.toString().padLeft(2, '0')}';
  }
  /// 获取指定日期的字符串表示（格式：yyyy-MM）
  static String getDateString_yyyyMM(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}';
  }
  /// 获取指定日期的字符串表示（格式：HH:mm）
  static String getDateString_HHmm(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// 获取指定日期的字符串表示（格式：MM月dd日 HH:mm）
  static String getDateString_MMddHHmm_cn(DateTime dateTime) {
    return '${dateTime.month.toString().padLeft(2, '0')}月${dateTime.day.toString().padLeft(2, '0')}日 ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// 获取指定日期的字符串表示（格式：MM月dd日）
  static String getDateString_MMdd_cn(DateTime dateTime) {
    return '${dateTime.month.toString().padLeft(2, '0')}月${dateTime.day.toString().padLeft(2, '0')}日';
  }

  /// 将毫秒数转换为DateTime对象
  static DateTime getDateTimeFromMilliseconds(int milliseconds) {
    return DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }

  /// 获取指定时间的整点时间戳（单位：秒）
  static int getHourPointTimestamp(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour).millisecondsSinceEpoch ~/ 1000;
  }

  /// 格式化时间为相对时间（例如：1天前、1小时前等）
  /// [time] 时间字符串（格式：yyyy-MM-dd HH:mm:ss 等，请参考 DateTime.parse 方法）
  static String? formatToRelativeTimeString(String? time) {
    if (time == null) return null;

    try {
      final dateTime = DateTime.parse(time);
      return dateTime.toRelativeTimeString();
    } catch (e) {
      return time;
    }
  }

}