import 'dart:io';
import 'package:flutter/foundation.dart';

/// 平台工具类
class PlatformUtil {

  static bool get isAndroid => !kIsWeb && Platform.isAndroid;
  static bool get isIOS => !kIsWeb && Platform.isIOS;
  static bool get isFuchsia => !kIsWeb && Platform.isFuchsia;
  static bool get isLinux => !kIsWeb && Platform.isLinux;
  static bool get isMacOS => !kIsWeb && Platform.isMacOS;
  static bool get isWindows => !kIsWeb && Platform.isWindows;
  static bool get isWeb => kIsWeb;

  /// 获取当前平台名称
  static String get platformName {
    if (isAndroid) return 'Android';
    if (isIOS) return 'iOS';
    if (isFuchsia) return 'Fuchsia';
    if (isLinux) return 'Linux';
    if (isMacOS) return 'macOS';
    if (isWindows) return 'Windows';
    if (isWeb) return 'Web';
    return 'Unknown';
  }
}
