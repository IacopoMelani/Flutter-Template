class HttpServiceException implements Exception {
  HttpServiceException({required int httpCode, String? message = "An error occurring"});
}

class HttpServiceRedirectException extends HttpServiceException {
  HttpServiceRedirectException({required int httpCode, String? message}) : super(httpCode: httpCode, message: message);
}

class HttpServiceClientErrorException extends HttpServiceException {
  HttpServiceClientErrorException({required int httpCode, String? message}) : super(httpCode: httpCode, message: message);
}

class HttpServiceServerErrorException extends HttpServiceException {
  HttpServiceServerErrorException({required int httpCode, String? message}) : super(httpCode: httpCode, message: message);
}
