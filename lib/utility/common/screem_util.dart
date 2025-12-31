

import 'package:flutter/material.dart';

/// 屏幕工具类
class ScreenUtil {
  /// 以下参数仅适用于竖屏
  static double widthFactor = 1.0; // 宽度缩放因子
  static double screenWidth = 375.0;
  static double screenHeight = 812.0;
  static EdgeInsets safePadding = EdgeInsets.zero; // 安全区域
  static double safeTop = 0.0; // 安全区域顶部
  static double safeBottom = 0.0; // 安全区域底部

  /// 更新屏幕信息
  /// [uiDesignWidth] 设计稿宽度，默认375.0
  static void update(BuildContext context, {double uiDesignWidth = 375.0}) {
    final mediaQuery = MediaQuery.of(context);
    widthFactor = (screenWidth * 100 / uiDesignWidth).toInt() / 100.0;
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
    safePadding = mediaQuery.viewPadding;
    safeTop = safePadding.top;
    safeBottom = safePadding.bottom;
  }

  /// 获取安全区域
  static EdgeInsets getSafeArea(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.viewPadding;
  }
}

extension ScaleWidth on num {
  /// 宽度缩放
  double get sW => this * ScreenUtil.widthFactor;
}
