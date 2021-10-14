class HttpServiceRedirectException implements Exception {
  final String message;

  HttpServiceRedirectException({this.message = "An error occurring"});
}

class HttpServiceClientErrorException implements Exception {
  final String message;

  HttpServiceClientErrorException({this.message = "An error occurring"});
}

class HttpServiceServerErrorException implements Exception {
  final String message;

  HttpServiceServerErrorException({this.message = "An error occurring"});
}
