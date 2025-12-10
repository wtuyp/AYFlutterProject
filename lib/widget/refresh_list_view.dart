

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

typedef ApiCallback = Future<Map<String, dynamic>> Function(int pageNum, int pageSize);
typedef CustomChildBuilder = Widget Function(BuildContext context, List<dynamic> dataList);

class RefreshListView extends StatefulWidget {
  final ApiCallback apiCallback; // API请求方法
  final Widget Function(BuildContext context, dynamic item)? itemBuilder; // 每一项的构建
  final Widget emptyWidget; // 空数据时的展示组件
  final CustomChildBuilder? childBuilder; // 自定义 child 构建方法

  const RefreshListView({
    super.key,
    required this.apiCallback,
    this.itemBuilder,
    this.emptyWidget = const Center(child: Text("暂无数据")),
    this.childBuilder,
  });

  @override
  State<RefreshListView> createState() => _RefreshListViewState();
}

class _RefreshListViewState extends State<RefreshListView> {
  int pageNum = 1; // 当前页数
  final int pageSize = 10; // 每页大小
  int totalPages = 1; // 总页数
  bool isLoading = false; // 是否正在加载
  List<dynamic> dataList = []; // 数据列表

  Future<void> fetchData({bool isRefresh = false}) async {
    if (isLoading) return; // 防止重复加载
    setState(() {
      isLoading = true;
    });

    try {
      final response = await widget.apiCallback(pageNum, pageSize);

      final dynamic rawData = response['list'] ?? [];
      final List<dynamic> newData =
      rawData is List ? rawData : [rawData]; // 转为列表

      setState(() {
        if (isRefresh) {
          dataList = newData;
        } else {
          dataList.addAll(newData);
        }
        totalPages = response['pages'] ?? 1; // 设置总页数
      });
    } catch (e) {
      debugPrint("加载数据失败: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> onRefresh() async {
    dataList.clear();
    setState(() {
      pageNum = 1;
    });
    await fetchData(isRefresh: true);
  }

  Future<void> onLoad() async {
    if (pageNum >= totalPages) return;
    setState(() {
      pageNum++;
    });
    await fetchData();
  }

  @override
  void initState() {
    super.initState();
    fetchData(isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: ClassicHeader(
        // backgroundColor: Colors.white,
      ),
      footer: ClassicFooter(
        // backgroundColor: Colors.white,
      ),
      onRefresh: onRefresh,
      onLoad: onLoad,
      child: widget.childBuilder != null
          ? widget.childBuilder!(context, dataList)
          : (dataList.isEmpty
          ? widget.emptyWidget
          : ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return widget.itemBuilder!(context, dataList[index]);
        },
      )),
    );
  }
}
