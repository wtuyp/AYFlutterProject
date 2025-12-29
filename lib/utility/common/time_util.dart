
import 'package:app/utility/extension/date_time_extension.dart';

/// 时间工具类
class TimeUtil {

  /// 分钟转时间显示，如 100 -> 01:40
  static String timeStringFromMinutes(int minutes) {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;
    return '${hours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')}';
  }

  /// 时间显示转分钟，如 01:40 -> 100
  static int minutesFromTimeString(String timeString) {
    List<String> parts = timeString.split(':');
    if (parts.length != 2) {
      return 0;
    }

    int hours = int.tryParse(parts[0]) ?? 0;
    int minutes = int.tryParse(parts[1]) ?? 0;
    return hours * 60 + minutes;
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