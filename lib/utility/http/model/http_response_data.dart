import 'package:app/main/config.dart';
import 'package:app/utility/json/safe_num_converter.dart';

import 'http_enum.dart';

/// 响应模型
class HttpResponseData<T> {
  final int code;
  final String message;
  final T? data;

  HttpResponseData({required this.code, required this.message, this.data});

  factory HttpResponseData.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    final data = json[HttpResponseKey.data];
    return HttpResponseData<T>(
      code: const SafeIntConverter().fromJson(json[HttpResponseKey.code]),
      message: json[HttpResponseKey.message] as String,
      data: data == null ? null : fromJsonT(data),
    );
  }

  Map<String, dynamic> toJson(Object? Function(T? value) toJsonT) {
    return <String, dynamic>{
      HttpResponseKey.code: const SafeIntConverter().toJson(code),
      HttpResponseKey.message: message,
      HttpResponseKey.data: data == null ? null : toJsonT(data),
    };
  }

  @override
  String toString() {
    return 'HttpResponseModel{code: $code, message: $message, data: ${data.toString()}}';
  }

  bool get isSuccess => code == HttpResponseCode.success.code;
}
