import 'package:app/utility/common/hud_util.dart';
import 'package:flutter/material.dart';

class ToastDemoPage extends StatefulWidget {
  const ToastDemoPage({super.key});

  @override
  State<ToastDemoPage> createState() => _ToastDemoPageState();
}

class _ToastDemoPageState extends State<ToastDemoPage> {
  @override
  void initState() {
    super.initState();

    HudUtil.showLoading();

    Future.delayed(const Duration(seconds: 2), () {
      HudUtil.dismiss();

      HudUtil.showToast('加载完成');

      HudUtil.showIconToast(
        icon: Icon(
          Icons.info_outline,
          color: Colors.white,
        ),
        message: '加载完成',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toast Demo'),
      ),
      body: const Center(
        child: Text('Toast Demo Page'),
      ),
    );
  }
}
