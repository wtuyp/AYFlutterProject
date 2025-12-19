import 'package:app/main/config.dart';
import 'package:app/utility/http/http_manager.dart';
import 'package:app/utility/json/safe_num_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'http_response_data.g.dart';

/// 响应模型
@JsonSerializable(
  genericArgumentFactories: true,
  converters: [SafeIntConverter()],
)
class HttpResponseData<T> {
  @JsonKey(name: HttpResponseKey.code)
  final int code;
  @JsonKey(name: HttpResponseKey.message)
  final String message;
  @JsonKey(name: HttpResponseKey.data)
  final T? data;

  HttpResponseData({required this.code, required this.message, this.data});

  factory HttpResponseData.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$HttpResponseDataFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T? value) toJsonT) =>
      _$HttpResponseDataToJson<T>(this, toJsonT);

  @override
  String toString() {
    return 'HttpResponseModel{code: $code, message: $message, data: ${data.toString()}}';
  }

  bool get isSuccess => code == HttpResponseCode.success.code;
}
