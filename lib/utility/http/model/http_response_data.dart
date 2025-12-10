

import 'package:app/main/config.dart';
import 'package:app/utility/http/http_manager.dart';

/// 响应模型
class HttpResponseData<T> {
  final int code;
  final String message;
  final T? data;

  HttpResponseData({required this.code, required this.message, this.data});

  factory HttpResponseData.fromJson(
    Map<String, dynamic> json,
    T Function(Object json)? fromJsonT,
  ) {
    final responseData = json[HttpResponseKey.data];
    final data = (fromJsonT != null && responseData != null) ? fromJsonT(responseData) : responseData;

    final responseCode = json[HttpResponseKey.code];
    int code = 0;
    if (responseCode is int) {
      code = responseCode;
    } else if (responseCode is String) {
      code = int.parse(responseCode);
    }

    return HttpResponseData<T>(
      code: code,
      message: json[HttpResponseKey.message] as String,
      data: data,
    );
  }

  @override
  String toString() {
    return 'HttpResponseModel{code: $code, message: $message, data: ${data.toString()}}';
  }

  bool get isSuccess => code == HttpResponseCode.success.code;
}
