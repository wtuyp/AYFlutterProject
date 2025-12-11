

import 'package:flutter/material.dart';

/// 自定义主题数据
class AppThemeData extends ThemeExtension<AppThemeData> {
  final Color titleColor;

  AppThemeData({required this.titleColor});

  @override
  ThemeExtension<AppThemeData> copyWith({
    Color? titleColor,
  }) {
    return AppThemeData(
      titleColor: titleColor ?? this.titleColor,
    );
  }

  @override
  ThemeExtension<AppThemeData> lerp(ThemeExtension<AppThemeData>? other, double t,) {
    if (other is! AppThemeData) {
      return this;
    }
    return AppThemeData(
      titleColor: Color.lerp(titleColor, other.titleColor, t)!,
    );
  }
}
