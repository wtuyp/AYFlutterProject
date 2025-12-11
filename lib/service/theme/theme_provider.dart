import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 主题模式通知者
class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.system;

  // 更新主题模式
  void updateThemeMode(ThemeMode mode) {
    state = mode;
  }
}

/// 主题模式提供者
final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(ThemeNotifier.new);
