import 'package:flutter_btmnavbar/dto/comment_dto.dart';
import 'package:flutter_btmnavbar/dto/post_dto.dart';
import 'package:flutter_btmnavbar/dto/user_dto.dart';
import 'package:flutter_btmnavbar/services/_services.dart';

typedef PostDTOsResult = Result<PostDTOs>;
typedef CommentDTOsResult = Result<CommentDTOs>;
typedef UserDTOsResult = Result<UserDTOs>;

abstract class FakeService {
  final String baseUrl = "https://jsonplaceholder.typicode.com/";

  Future<PostDTOsResult> posts();
  Future<CommentDTOsResult> comments();
  Future<UserDTOsResult> users();
}
