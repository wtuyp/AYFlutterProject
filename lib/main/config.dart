

/// 应用配置
class AppConfig {

  static const String iOSAppID = "123456"; // iOS应用ID，用于跳转 App Store
}

/// HTTP 配置
class HttpConfig {
  static const String baseUrl = "https://www.ay.com";

  static const int connectTimeout = 5; // 连接超时时间, 单位秒
  static const int sendTimeout = 8; // 发送超时时间, 单位秒
  static const int receiveTimeout = 8; // 接收超时时间, 单位秒

  static const int pageSize = 20; // 分页大小
  static const int firstPageIndex = 1; // 第一页索引, 0 或 1
}

/// HTTP 响应键值
class HttpResponseKey {
  static const String code = 'code'; // 响应状态码
  static const String message = 'message'; // 响应消息
  static const String data = 'data'; // 响应数据

  static const String pageIndex = 'current'; // 当前页
  static const String pageTotal = 'pages'; // 总页数
  static const String pageData = 'records'; // 数据
}

/// URL 配置
class UrlConfig {
  static const String userAgreementUrl = "https://www.ay.com/user/agreement"; // 用户协议URL
  static const String privacyPolicyUrl = "https://www.ay.com/user/privacy"; // 隐私政策URL
}

/// 第三方开放平台
class ThirdOpenConfig {

  static const String wxAppId = "123456"; // 微信应用ID
}

/// 主题配置
class ThemeConfig {
  static const String defaultFontFamily = '';
  static const String numberFontFamily = '';
}

