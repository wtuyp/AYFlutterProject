

/// HTTP 状态码
enum HttpResponseCode {
  success(0),
  tokenExpired(4031), //  token 过期
  upgrade(100003), // 升级
  ;

  final int code;
  const HttpResponseCode(this.code);
}