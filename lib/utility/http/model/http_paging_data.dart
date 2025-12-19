import 'package:app/main/config.dart';
import 'package:app/utility/json/safe_num_converter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'http_paging_data.g.dart';

/// HTTP 分页数据模型
@JsonSerializable(
  genericArgumentFactories: true,
  converters: [SafeIntConverter()],
)
class HttpPagingData<T> {
  @JsonKey(name: HttpResponseKey.pageIndex, defaultValue: HttpConfig.firstPageIndex)
  final int pageIndex; // 当前页码
  @JsonKey(name: HttpResponseKey.pageTotal, defaultValue: HttpConfig.firstPageIndex)
  final int pageTotal; // 总页码
  @JsonKey(name: HttpResponseKey.pageData, defaultValue: [])
  final List<T> pageData; // 分页数据

  HttpPagingData({
    this.pageIndex = HttpConfig.firstPageIndex,
    this.pageTotal = HttpConfig.firstPageIndex,
    this.pageData = const [],
  });

  factory HttpPagingData.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) =>
      _$HttpPagingDataFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T? value) toJsonT) =>
      _$HttpPagingDataToJson<T>(this, toJsonT);

  bool get hasMore => pageTotal > pageIndex;
  int get nextPage => pageIndex + 1;
  int get firstPage => HttpConfig.firstPageIndex;

  @override
  String toString() {
    return 'HttpPagingData(\n  pageIndex: $pageIndex, \n  pageTotal: $pageTotal, \n  pageData: ${pageData.map((e) => e.toString()).toList()}\n)';
  }
}
