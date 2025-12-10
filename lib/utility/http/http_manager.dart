

import 'package:app/main/config.dart';
import 'package:app/utility/http/interceptor/error_interceptor.dart';
import 'package:app/utility/http/model/http_exception.dart';
import 'package:app/utility/http/model/http_response_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'interceptor/header_interceptor.dart';

/// HTTP 请求方法
enum HttpMethod {
  get,
  post,
  delete,
  put,
}

/// HTTP 状态码
enum HttpResponseCode {
  success(0),
  tokenExpired(4031), //  token 过期
  upgrade(100003), // 升级
  ;

  final int code;
  const HttpResponseCode(this.code);
}

/// 网络请求管理，目前使用的是 Dio 框架
class HttpManager {
  static final HttpManager _instance = HttpManager._internal();
  factory HttpManager() => _instance;

  HttpManager._internal() {
    dio = createDio(
      baseUrl: HttpConfig.baseUrl,
      connectTimeout: const Duration(seconds: HttpConfig.connectTimeout),
      sendTimeout: const Duration(seconds: HttpConfig.sendTimeout),
      receiveTimeout: const Duration(seconds: HttpConfig.receiveTimeout),
    );

    dio.interceptors.add(
      HeaderInterceptor(),
    );
    dio.interceptors.add(
      ErrorInterceptor(),
    );
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        enabled: kDebugMode,
      ),
    );
  }

  late final Dio dio;

  final Map<String, Dio> _dioMap = {};
  Dio? getDio({required String baseUrl}) => _dioMap[baseUrl];

  /// 创建 Dio 实例
  Dio createDio({
    required String baseUrl,
    Duration? connectTimeout,
    Duration? sendTimeout,
    Duration? receiveTimeout,
  }) {
    final BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      contentType: Headers.jsonContentType,
    );

    Dio dio = Dio(options);
    _dioMap[baseUrl] = dio;

    return dio;
  }

  // 通用请求
  Future<HttpResponseData<T>> request<T>({
    required String url,
    String method = 'GET',
    dynamic data,
    Map<String, dynamic>? query,
    Options? options,
    required T Function(dynamic) fromJsonT,
  }) async {
    try {
      final response = await dio.request(
        url,
        data: data,
        queryParameters: query,
        options: options?.copyWith(method: method) ?? Options(method: method),
      );

      final json = response.data is Map<String, dynamic>
          ? response.data
          : Map<String, dynamic>.from(response.data);

      final httpResponse = HttpResponseData<T>.fromJson(json, fromJsonT);

      if (httpResponse.isSuccess) {
        return httpResponse;
      } else {
        throw HttpResponseException(httpResponse.code, httpResponse.message);
      }
    } on DioException catch (e) {
      final String message = handle(e);
      throw HttpRequestException(e.response?.statusCode ?? -1, message);
    } catch (e) {
      throw HttpException(-2, e.toString());
    }
  }

  Future<HttpResponseData<T>> requestPost<T>({
    required String url,
    dynamic data,
    Options? options,
    required T Function(dynamic) fromJsonT,
  }) async {
    final response = await request(
      url: url,
      data: data,
      options: options?.copyWith(method: "POST") ?? Options(method: "POST"),
      fromJsonT: fromJsonT,
    );

    return response;
  }

  Future<HttpResponseData<T>> requestGet<T>({
    required String url,
    Map<String, dynamic>? query,
    Options? options,
    required T Function(dynamic) fromJsonT,
  }) async {
    final response = await request(
      url: url,
      query: query,
      options: options?.copyWith(method: "GET") ?? Options(method: "GET"),
      fromJsonT: fromJsonT,
    );

    return response;
  }


  Future<HttpResponseData<T>> uploadFile<T>(
      String path,
      String filePath, {
        Map<String, dynamic>? extraData,
        Function(int, int)? onSendProgress,
        required T Function(dynamic) fromJsonT,
      }) async {
    try {
      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath),
        ...?extraData,
      });

      final response = await dio.post(
        path,
        data: formData,
        onSendProgress: onSendProgress,
      );

      return HttpResponseData<T>.fromJson(response.data, fromJsonT);
    } on DioException catch (e) {
      throw HttpException(-1, e.toString());
    }
  }

  Future<void> downloadFile(
      String urlPath,
      String savePath, {
        Function(int, int)? onReceiveProgress,
      }) async {
    try {
      await dio.download(
        urlPath,
        savePath,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw HttpException(-1, e.toString());
    }
  }

  Future<List<HttpResponseData>> concurrentRequests(
      List<Future<HttpResponseData>> futures,
      ) async {
    try {
      final results = await Future.wait(futures);
      return results;
    } catch (e) {
      rethrow;
    }
  }

  String handle(DioException e) {
    String message = '未知错误';

    // 第一层：Dio 的类型错误
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        message = '连接服务器超时';
        break;
      case DioExceptionType.sendTimeout:
        message = '请求发送超时';
        break;
      case DioExceptionType.receiveTimeout:
        message = '服务器响应超时';
        break;
      case DioExceptionType.cancel:
        message = '请求已取消';
        break;
      case DioExceptionType.badResponse:
        // 继续判断 HTTP 状态码
        message = _mapStatusCode(e.response?.statusCode, e.response?.data);
        break;
      default:
        message = '请求异常';
    }

    return message;
  }

  String _mapStatusCode(int? statusCode, dynamic data) {
    switch (statusCode) {
      case 400:
        return '请求参数错误';
      case 401:
        // TODO: TO LOGIN
        return '登录过期，请重新登录';
      case 403:
        return '没有权限访问';
      case 404:
        return '资源不存在';
      case 408:
        return '请求超时';
      case 500:
        return '服务器内部错误';
      case 502:
        return '网关错误';
      case 503:
        return '服务器维护中';
      default:
        return data?['message'] ?? '网络异常';
    }
  }

}
