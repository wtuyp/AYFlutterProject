import 'package:app/main/config.dart';

/// HTTP 分页数据模型
class HttpPagingData<T> {
  final int pageIndex;
  final int pageTotal;
  final List<T> pageData;

  HttpPagingData({
    this.pageIndex = HttpConfig.firstPageIndex,
    this.pageTotal = HttpConfig.firstPageIndex,
    this.pageData = const [],
  });

  factory HttpPagingData.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) => HttpPagingData(
    pageData: List<T>.from(json[HttpResponseKey.pageData].map((x) => fromJsonT(x))),
    pageIndex: json[HttpResponseKey.pageIndex],
    pageTotal: json[HttpResponseKey.pageTotal],
  );

  bool get hasMore => pageTotal > pageIndex;
  int get nextPage => pageIndex + 1;
  int get firstPage => HttpConfig.firstPageIndex;

  @override
  String toString() {
    return 'HttpPagingData(pageIndex: $pageIndex, pageTotal: $pageTotal, pageData: ${pageData.map((e) => e.toString()).toList()})';
  }
}
