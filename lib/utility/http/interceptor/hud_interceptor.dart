

import 'package:app/utility/common/hud_util.dart';
import 'package:dio/dio.dart';

/// HUD 拦截器
class HudInterceptor extends Interceptor {

  void _showLoadingHud() {
    HudUtil.showLoading(message: '加载中...');
  }

  void _hideLoadingHud() {
    HudUtil.dismiss();
  }

  void _showErrorHud(String message) {
    HudUtil.showToast(message);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    super.onRequest(options, handler);

    final bool enableLoadingHud = options.extra['enableLoadingHud'] ?? false;
    if (enableLoadingHud) {
      _showLoadingHud();
    }
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    super.onResponse(response, handler);
    final bool enableLoadingHud = response.extra['enableLoadingHud'] ?? false;
    if (enableLoadingHud) {
      _hideLoadingHud();
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    final bool enableLoadingHud = err.requestOptions.extra['enableLoadingHud'] ?? false;
    if (enableLoadingHud) {
      _hideLoadingHud();
    }

    final bool enableErrorHud = err.requestOptions.extra['enableErrorHud'] ?? false;
    if (enableErrorHud) {
      _showErrorHud(err.message ?? '请求失败');
    }
  }
}
