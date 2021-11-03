import 'package:flutter_btmnavbar/dto/comment_dto.dart';
import 'package:flutter_btmnavbar/dto/post_dto.dart';
import 'package:flutter_btmnavbar/dto/user_dto.dart';
import 'package:flutter_btmnavbar/exceptions/service_exception.dart';
import 'package:flutter_btmnavbar/managers/config_manager.dart';
import 'package:flutter_btmnavbar/services/_services.dart';

typedef PostDTOsResult = Result<PostDTOs>;
typedef CommentDTOsResult = Result<CommentDTOs>;
typedef UserDTOsResult = Result<UserDTOs>;

const FAKE_SERVICE_POSTS_PATH = 'posts';
const FAKE_SERVICE_COMMENTS_PATH = 'comments';
const FAKE_SERVICE_USERS_PATH = 'users';

class FakeService extends HttpService {
  static FakeService _service = FakeService._internal();

  factory FakeService() {
    return _service;
  }

  FakeService._internal();

  @override
  String get host => ConfigManager().apiHost;

  @override
  int get port => ConfigManager().apiPort;

  @override
  String get schema => ConfigManager().apiSchema;

  Future<PostDTOsResult> posts() async {
    PostDTOsResult result;

    try {
      final response = await makeJsonGetRequest<Iterable>(FAKE_SERVICE_POSTS_PATH);
      List<PostDTO> listPosts = List.from(response.map((json) => PostDTO.fromJson(json)));

      result = Result.success(listPosts);
    } on HttpServiceException catch (e) {
      result = Result.error(
        message: e.message,
        code: e.httpCode,
      );
    }

    return result;
  }

  Future<CommentDTOsResult> comments() async {
    CommentDTOsResult result;

    try {
      final response = await makeJsonGetRequest<Iterable>(FAKE_SERVICE_COMMENTS_PATH);
      List<CommentDTO> listComments = List.from(response.map((m) => CommentDTO.fromJson(m)));

      result = Result.success(listComments);
    } on HttpServiceException catch (e) {
      result = Result.error(
        message: e.message,
        code: e.httpCode,
      );
    }

    return result;
  }

  Future<UserDTOsResult> users() async {
    UserDTOsResult result;

    try {
      final response = await makeJsonGetRequest<List<dynamic>>(FAKE_SERVICE_USERS_PATH);
      List<UserDTO> listUsers = List<UserDTO>.from(response.map((m) => UserDTO.fromJson(m)));

      result = Result.success(listUsers);
    } on HttpServiceException catch (e) {
      result = Result.error(
        message: e.message,
        code: e.httpCode,
      );
    }

    return result;
  }
}
