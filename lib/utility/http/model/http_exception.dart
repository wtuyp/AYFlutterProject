

class HttpException implements Exception {
  final int code;
  final String message;

  HttpException(this.code, this.message);

  @override
  String toString() => 'HttpResponseException(code: $code, message: $message)';
}

class HttpRequestException extends HttpException {
  HttpRequestException(super.code, super.message);

  @override
  String toString() => 'HttpRequestException(code: $code, message: $message)';
}

class HttpResponseException extends HttpException {
  HttpResponseException(super.code, super.message);

  @override
  String toString() => 'HttpResponseException(code: $code, message: $message)';
}
