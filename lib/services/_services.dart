import 'dart:convert';

import 'package:flutter_btmnavbar/exceptions/service_exception.dart';
import 'package:http/http.dart' as http;

class Result<T> {
  final Error? err;
  final T? data;

  Result({this.data, this.err});

  Result.error({required String message, int? code})
      : err = Error(message: message, code: code),
        data = null;

  Result.success(T data)
      : err = null,
        data = data;
}

class Error {
  Error({
    required String message,
    int? code,
  });
}

typedef JsonMap = Map<String, dynamic>;
typedef JsonArray = List<dynamic>;

abstract class HttpService {
  String get schema;
  String get host;
  String get port;

  String get baseUrl => '$schema://$host:$port';

  Uri buildEndPoint(String path) => Uri.parse('$baseUrl/$path');

  /// The method [makeJsonPostRequest] is used to make a post request to the server
  /// [path] is the path to the endpoint
  /// [body] is the body of the request
  /// [headers] is the headers of the request
  /// Returns a [Future] of [JsonMap] if the request was successful
  /// Throws [HttpServiceException] if the request was failed
  Future<T> makeJsonPostRequest<T>(String path, {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    final url = buildEndPoint(path);
    headers ??= {};
    headers['Content-Type'] = 'application/json';
    final response = await http.post(url, body: body, headers: headers);
    return _checkHttpCode<T>(response);
  }

  T _checkHttpCode<T>(http.Response res) {
    final httpCode = res.statusCode;
    if (successHttpCodes.contains(httpCode)) {
      return json.decode(res.body);
    } else if (redirectHttpCodes.contains(httpCode)) {
      throw HttpServiceRedirectException(httpCode: httpCode, message: res.body);
    } else if (clientErrorHttpCodes.contains(httpCode)) {
      throw HttpServiceClientErrorException(httpCode: httpCode, message: res.body);
    } else {
      throw HttpServiceServerErrorException(httpCode: httpCode, message: res.body);
    }
  }
}

const successHttpCodes = [200, 201, 202, 203, 204, 205, 206];

const redirectHttpCodes = [300, 301, 302, 303, 304, 305, 306, 307];

const clientErrorHttpCodes = [
  400,
  401,
  402,
  403,
  404,
  405,
  406,
  407,
  408,
  409,
  410,
  411,
  412,
  413,
  414,
  415,
  416,
  417,
  418,
  421,
  422,
  423,
  424,
  426,
  428,
  429,
  431,
  451
];

const serverErrorHttpCodes = [500, 501, 502, 503, 504, 505, 506, 507, 508, 510, 511];
