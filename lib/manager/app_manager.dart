import 'package:app/module/root/root_page.dart';
import 'package:app/service/theme/theme_provider.dart';
import 'package:app/utility/common/screem_util.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:intl/date_symbol_data_local.dart';

final AppManager appManager = AppManager();
final WidgetRef appRef = appManager.ref;
final BuildContext appTopContext = appManager.topContext;

/// 应用管理类
class AppManager {
  static final AppManager _instance = AppManager._internal();
  factory AppManager() => _instance;

  AppManager._internal();

  late WidgetRef ref;
  late BuildContext topContext; // 注意：这是顶部的上下文，一般用于弹窗等操作，不要用于节点查找。

  // 应用运行
  Future<void> run() async {
    await setupBeforeRun();
    runApp(ProviderScope(
      child: MyApp(home: createHomePage()),
    ));
    setupAfterRun();
  }

  // 创建应用首页
  Widget createHomePage() {
    Widget homePage = const RootPage();
    return homePage;
  }
}

extension AppManagerSetup on AppManager {

  /// 应用运行前的初始化
  Future<void> setupBeforeRun() async {
    // 初始化日期格式
    await initializeDateFormatting();
  }

  /// 应用运行后的初始化
  void setupAfterRun() {
    // 初始化弹窗配置
    SmartDialog.config.toast = SmartConfigToast(
      alignment: Alignment.center,
    );
  }
}


class MyApp extends ConsumerStatefulWidget {
  final Widget home;
  const MyApp({super.key, required this.home});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

  @override
  void initState() {
    super.initState();

    appManager.ref = ref;
    appManager.topContext = context;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.update(context, uiDesignWidth: 375.0);
    final media = MediaQuery.of(context);

    return MediaQuery(
      data: media.copyWith(
        textScaler: TextScaler.linear(ScreenUtil.widthFactor),
      ),
      child: MaterialApp(
        title: 'App',
        home: widget.home,
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
        theme: FlexThemeData.light(scheme: FlexScheme.blueWhale),
        darkTheme: FlexThemeData.dark(scheme: FlexScheme.blueWhale),
        themeMode: ref.watch(themeProvider),
      ),
    );
  }
}
