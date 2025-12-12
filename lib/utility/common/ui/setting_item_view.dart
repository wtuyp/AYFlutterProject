

import 'package:flutter/material.dart';

/// 设置项视图
class SettingItemView extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showArrow;
  const SettingItemView({super.key, this.onTap, required this.title, this.trailing, this.showArrow = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48,
        child: Row(
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Color(0xFF1D2129),
            ),),
            const Spacer(),
            trailing ?? const SizedBox(),
            if (showArrow) ...[
              const SizedBox(width: 10,),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFFC9CDD4),),
            ]
          ],
        ),
      ),
    );
  }
}

/// 开关项视图
class SwitchItemView extends StatelessWidget {
  final String title;
  final bool isOn;
  final ValueChanged<bool> onChanged;

  const SwitchItemView({super.key, required this.title, required this.isOn, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SettingItemView(
      title: title,
      showArrow: false,
      trailing: Transform.scale(
        scale: 0.8,
        child: Switch(
          value: isOn,
          onChanged: (on) {
            onChanged(on);
          },
        ),
      ),
    );
  }
}

/// 文本输入项视图
class TextFieldItemView extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;

  const TextFieldItemView({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SettingItemView(
      title: title,
      trailing: Container(
        width: 200,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
