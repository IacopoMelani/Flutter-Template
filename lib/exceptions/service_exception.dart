class HttpServiceException implements Exception {
  final int httpCode;
  final String message;

  HttpServiceException({this.httpCode = 999, this.message = "An error occurring"});

  @override
  String toString() {
    return "HttpServiceException: $message";
  }
}

class HttpServiceRedirectException extends HttpServiceException {
  HttpServiceRedirectException({required int httpCode, required String message}) : super(httpCode: httpCode, message: message);
}

class HttpServiceClientErrorException extends HttpServiceException {
  HttpServiceClientErrorException({required int httpCode, required String message}) : super(httpCode: httpCode, message: message);
}

class HttpServiceServerErrorException extends HttpServiceException {
  HttpServiceServerErrorException({required int httpCode, required String message}) : super(httpCode: httpCode, message: message);
}
