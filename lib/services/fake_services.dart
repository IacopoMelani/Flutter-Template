import 'dart:developer';

import 'package:flutter_btmnavbar/dto/comment_dto.dart';
import 'package:flutter_btmnavbar/dto/post_dto.dart';
import 'package:flutter_btmnavbar/dto/user_dto.dart';
import 'package:flutter_btmnavbar/exceptions/service_exception.dart';
import 'package:flutter_btmnavbar/services/_services.dart';

typedef PostDTOsResult = Result<PostDTOs>;
typedef CommentDTOsResult = Result<CommentDTOs>;
typedef UserDTOsResult = Result<UserDTOs>;

const FAKE_SERVICE_POSTS_PATH = 'posts';
const FAKE_SERVICE_COMMENTS_PATH = 'comments';
const FAKE_SERVICE_USERS_PATH = 'users';

class FakeService {
  static FakeService _service = FakeService._internal();

  final String baseUrl = "https://jsonplaceholder.typicode.com/";

  factory FakeService() {
    return _service;
  }

  FakeService._internal();

  // Future<PostDTOsResult> posts();
  // Future<CommentDTOsResult> comments();
  // Future<UserDTOsResult> users();
}
