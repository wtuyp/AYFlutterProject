
import 'package:app/manager/account_manager/account_manager.dart';
import 'package:dio/dio.dart';

class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _getToken();
    if (token != null) {
      options.headers['Access-Token'] = token;
    }

    // FIXME: fix
    options.headers['Device-Platform'] = 'IOS OR ANDROID';
    options.headers['App-Version'] = '1.0.0';
    handler.next(options);
  }

  /// 获取 token
  Future<String?> _getToken() async => AccountManager().accessToken;
}
