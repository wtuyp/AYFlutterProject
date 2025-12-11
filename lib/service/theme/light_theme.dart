import 'package:app/service/theme/app_theme_data.dart';
import 'package:flutter/material.dart';


final _primaryColor = Color(0xff3ba1f5);

/// 浅色主题
final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: _primaryColor,
  colorScheme: ColorScheme.fromSeed(seedColor: _primaryColor),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Color(0xff1b1b1b),
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    titleMedium: TextStyle(
      color: Color(0xff1b1b1b),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    titleSmall: TextStyle(
      color: Color(0xff1b1b1b),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    bodyLarge: TextStyle(
      color: Color(0xff2b2b2b),
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      color: Color(0xff2b2b2b),
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      color: Color(0xff2b2b2b),
      fontSize: 12,
    ),
    labelLarge: TextStyle(
      color: Color(0xff9b9b9b),
      fontSize: 13,
    ),
    labelMedium: TextStyle(
      color: Color(0xff9b9b9b),
      fontSize: 12,
    ),
    labelSmall: TextStyle(
      color: Color(0xff9b9b9b),
      fontSize: 11,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.white,
      shadowColor: Colors.transparent
    )
  ),
  scaffoldBackgroundColor: Color(0xffF5F6F7),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.blue,
    behavior: SnackBarBehavior.floating
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    showUnselectedLabels: true,
    unselectedItemColor: Color(0xff919599),
    selectedItemColor: _primaryColor,
    selectedLabelStyle: TextStyle(fontSize: 12),
    type: BottomNavigationBarType.fixed,
  ),
  cardColor: Colors.white,
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: Color(0xfff1f1f1),
      borderRadius: BorderRadius.circular(10),
    )
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Color(0xff2c2c2c)),
    titleTextStyle: TextStyle(color: Color(0xff1f2021), fontSize: 18, fontWeight: FontWeight.bold,),
    actionsIconTheme: IconThemeData(color: Color(0xff2c2c2c)),
  ),
  tabBarTheme: TabBarTheme(
    labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,),
    labelColor: Color(0xff1f2021),
    unselectedLabelStyle: TextStyle(fontSize: 14, ),
    indicatorColor: Color(0xff1f2021),
  ),
  dividerColor: Color(0xffe0e0e0),
  shadowColor: Color(0xffe0e0e0),
  switchTheme:  SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
      return Colors.white;
      // if (states.contains(WidgetState.selected)) {
      //   return Colors.white;
      //   // return _primaryColor; // 开启状态下拇指的颜色
      // }
      // return Color(0xffedeeef); // 关闭状态下拇指的颜色
    }),
    trackColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
      // return Colors.transparent;
      if (states.contains(WidgetState.selected)) {
        return _primaryColor; // 开启状态下轨道的颜色
      }
      return Color(0xffedeeef); // 关闭状态下轨道的颜色
    }),
    trackOutlineColor:WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return _primaryColor; // 开启状态下轨道的颜色
      }
      return Color(0xffedeeef); // 关闭状态下轨道的颜色
    }) ,
    // thumbIcon: WidgetStateProperty. resolveWith<Icon?>((Set<WidgetState> states) {
    //   if (states. contains(WidgetState. disabled)) {
    //     return const Icon(Icons. close, color: Colors.deepPurpleAccent,);
    //   }
    //   return null; // All other states will use the default thumbIcon.
    // }),
    overlayColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        // return Colors.orange.withOpacity(0.2); // 开启状态下的覆盖颜色
        return _primaryColor; // 开启状态下轨道的颜色
      }
      return Color(0xffedeeef); // 关闭状态下的覆盖颜色
    }),
  ),

  checkboxTheme: CheckboxThemeData(
    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), // 圆角
    shape: CircleBorder(),
    visualDensity: VisualDensity(horizontal: 0.5, vertical: 0.5 ),
    side: BorderSide(width: 2, color: Color(0xffd5d5d8)), // 边框样式
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return _primaryColor; // 选中时的填充色
      }
      return null; // 使用默认颜色
    }),
  ),
  extensions: [
    AppThemeData(
      titleColor: Color(0xff1f2021),
    ),
  ],
);
