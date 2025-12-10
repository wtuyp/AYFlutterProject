

import 'package:app/main/config.dart';

/// 数据状态模型
class DataState<T> {
  final T? data;

  final List<T>? dataList;
  final int current; // 当前页数
  final int pages; // 总页数
  final int total; // 总个数

  final bool isLoading; // 是否正在加载，网络请求中 或 本地缓存加载
  // final String? error;

  DataState({this.data, this.dataList, this.current = HttpConfig.firstPageIndex, this.pages = HttpConfig.firstPageIndex, this.total = 0, this.isLoading = false});



  DataState<T> copyWith({
    T? data,
    List<T>? dataList,
    int? current,
    int? pages,
    int? total,
    bool? isLoading,
  }) => DataState(
    data: data ?? this.data,
    dataList: dataList ?? this.dataList,
    current: current ?? this.current,
    pages: pages ?? this.pages,
    total: total ?? this.total,
    isLoading: isLoading ?? this.isLoading,
  );
}
