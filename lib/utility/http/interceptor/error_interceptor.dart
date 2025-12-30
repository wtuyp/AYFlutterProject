

import 'package:app/utility/common/hud_util.dart';
import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  void _showErrorHud(String message) {
    HudUtil.showToast(message);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);

    final bool enableErrorHud = err.requestOptions.extra['enableErrorHud'] ?? false;
    if (enableErrorHud) {
      final String message = handle(err);
      _showErrorHud(message);
    }
  }

  String handle(DioException e) {
    String message = '未知错误';
    int? statusCode = e.response?.statusCode;

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
        message = _mapStatusCode(statusCode, e.response?.data);
        break;
      default:
        message = e.message ?? '请求异常';
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
