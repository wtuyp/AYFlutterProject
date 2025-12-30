
import 'package:app/manager/account_manager/account_manager.dart';
import 'package:app/utility/common/platform_util.dart';
import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = _getToken();
    if (token != null) {
      options.headers['Access-Token'] = token;
    }

    options.headers['Device-Platform'] = PlatformUtil.platformName;
    options.headers['App-Version'] = (await PackageInfo.fromPlatform()).version;
    handler.next(options);
  }

  /// 获取 token
  String? _getToken() => AccountManager().accessToken;
}
