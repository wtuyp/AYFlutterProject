import 'package:app/main/config.dart';
import 'package:app/utility/json/safe_num_converter.dart';

/// HTTP 分页数据模型
class HttpPagingData<T> {
  final int pageIndex; // 当前页码
  final int pageTotal; // 总页码
  final List<T> pageData; // 分页数据

  HttpPagingData({
    this.pageIndex = HttpConfig.firstPageIndex,
    this.pageTotal = HttpConfig.firstPageIndex,
    this.pageData = const [],
  });

  factory HttpPagingData.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return HttpPagingData<T>(
      pageIndex: json[HttpResponseKey.pageIndex] == null
        ? HttpConfig.firstPageIndex
        : const SafeIntConverter().fromJson(json[HttpResponseKey.pageIndex]),
      pageTotal: json[HttpResponseKey.pageTotal] == null
        ? HttpConfig.firstPageIndex
        : const SafeIntConverter().fromJson(json[HttpResponseKey.pageTotal]),
      pageData: (json[HttpResponseKey.pageData] as List<dynamic>?)
        ?.map(fromJsonT).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return <String, dynamic>{
      HttpResponseKey.pageIndex: const SafeIntConverter().toJson(pageIndex),
      HttpResponseKey.pageTotal: const SafeIntConverter().toJson(pageTotal),
      HttpResponseKey.pageData: pageData.map(toJsonT).toList(),
    };
  }

  /// 是否有更多数据
  bool get hasMore => pageTotal > pageIndex;

  /// 第一页页码
  int get firstPage => HttpConfig.firstPageIndex;

  /// 下一页页码
  int get nextPage => pageIndex + 1;

  @override
  String toString() {
    return 'HttpPagingData(\n  pageIndex: $pageIndex, \n  pageTotal: $pageTotal, \n  pageData: ${pageData.map((e) => e.toString()).toList()}\n)';
  }
}
