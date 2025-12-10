
import 'package:flutter/material.dart';

class AppOverlay {
  OverlayEntry? overlayEntry;

  // 显示浮层的方法
  void show(BuildContext context, {required Widget child}) {
    overlayEntry = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          onTap: () => overlayEntry?.remove(), // 点击移除蒙层
          child: Container(
            color: Colors.black26,
            child: child,
          ),
        );
      },
    );

    if (overlayEntry != null) {
      Overlay.of(context).insert(overlayEntry!);
    }
  }

  // 关闭浮层的方法
  void close() {
    overlayEntry?.remove();
  }
}
