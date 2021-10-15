class HttpServiceException implements Exception {
  final int httpCode;
  final String message;

  HttpServiceException({required this.httpCode, this.message = "An error occurring"});
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
