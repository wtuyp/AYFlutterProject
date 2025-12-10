
import 'package:flutter/material.dart';

class MenuPopupView extends StatelessWidget {
  final List<MenuPopupButton> buttons;
  final double width;
  const MenuPopupView({
    super.key,
    required this.buttons,
    this.width = 128,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0x1F303E4A),
            offset: Offset(0, 4),
            blurRadius: 24.0,
            spreadRadius: -6.0,
          ),
        ],
      ),
      child: Column(
        spacing: 0,
        children: buttons,
      ),
    );
  }
}

// 菜单按钮
class MenuPopupButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  const MenuPopupButton({super.key, this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(12),
        overlayColor: Color(0x14121C27),
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Color(0xFF1F2021),
          ),
        ),
      ),
    );
  }
}
