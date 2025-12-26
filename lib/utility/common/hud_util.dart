import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// HUD 工具类
/// 基于 SmartDialog 封装，参数自定义调整
class HudUtil {
  /// 显示loading, 点击事件默认不穿透
  static void showLoading({String message = '加载中...'}) {
    SmartDialog.showLoading(
      msg: message,
      maskColor: Colors.transparent,
    );
  }

  /// 显示toast, 点击事件默认穿透
  /// [alignment] 对齐方式，默认居中
  /// [displayTime] 显示时长，默认根据文本长度计算
  static void showToast(
    String message, {
    Alignment alignment = Alignment.center,
    Duration? displayTime,
  }) {
    SmartDialog.showToast(
      message,
      alignment: alignment,
      displayTime: displayTime ?? displayDurationWithText(message),
    );
  }

  /// 显示自定义 toast, 点击事件默认穿透
  /// [toastWidget] 自定义toast widget
  /// [alignment] 对齐方式，默认底部居中
  /// [displayTime] 显示时长，默认2秒
  static void showCustomToast({
    required Widget toastWidget,
    Alignment alignment = const Alignment(0, 0.8),
    Duration displayTime = const Duration(seconds: 2),
  }) {
    SmartDialog.showToast(
      '',
      builder: (context) => toastWidget,
      alignment: alignment,
      displayTime: displayTime,
    );
  }

  /// 显示图标toast, 点击事件默认穿透
  /// [icon] 图标
  /// [message] 消息
  /// [alignment] 对齐方式，默认底部居中
  /// [displayTime] 显示时长，默认根据文本长度计算
  /// [direction] 方向，默认水平方向
  static void showIconToast({
    required Widget icon,
    required String message,
    Alignment alignment = const Alignment(0, 0.8),
    Duration? displayTime,
    Axis direction = Axis.horizontal,
  }) {
    SmartDialog.showToast(
      '',
      alignment: alignment,
      displayTime: displayTime ?? displayDurationWithText(message),
      builder: (context) {
        final viewPadding = MediaQuery.of(context).viewPadding;
        return Container(
          margin: EdgeInsets.only(
            bottom: viewPadding.bottom,
          ),
          padding: direction == Axis.horizontal
              ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
              : const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF575757),
            borderRadius: BorderRadius.circular(8),
          ),
          child: direction == Axis.horizontal
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    icon,
                    const SizedBox(width: 8),
                    Text(
                      message,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    icon,
                    const SizedBox(height: 8),
                    Text(
                      message,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
        );
      },
    );
  }

  /// 隐藏hud
  static void dismiss<T>({
    SmartStatus status = SmartStatus.smart,
    String? tag,
    T? result,
    bool force = false,
  }) {
    SmartDialog.dismiss<T>(
      status: status,
      tag: tag,
      result: result,
      force: force,
    );
  }

  /// 根据文本长度返回显示时长，20字内 2.0s，40字内 2.5s，50字内 3.0s，50字以上 3.5s
  static Duration displayDurationWithText(String string) {
    if (string.length <= 20) {
      return Duration(milliseconds: 2000);
    } else if (string.length <= 40) {
      return Duration(milliseconds: 2500);
    } else if (string.length <= 50) {
      return Duration(milliseconds: 3000);
    } else {
      return Duration(milliseconds: 3500);
    }
  }
}
