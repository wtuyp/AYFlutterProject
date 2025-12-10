

import 'package:app/widget/refresh_list_view.dart';
import 'package:flutter/material.dart';

class RefreshDemoPage extends StatelessWidget {

  // 模拟 API 请求
  Future<Map<String, dynamic>> fetchData(int pageNum, int pageSize) async {
    await Future.delayed(Duration(seconds: 2)); // 模拟网络延时
    return {
      'list': List.generate(pageSize, (index) => 'Item ${index + 1}'), // 返回模拟数据
      'pages': 5, // 模拟总页数
    };
  }

  const RefreshDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Refresh Demo')),
      body: RefreshListView(
        apiCallback: fetchData,
        itemBuilder: (context, item) {
          return ListTile(title: Text(item));
        },
        emptyWidget: Center(child: Text("No more data")),
      ),
    );
  }
}
