class CommentDTO {
  CommentDTO({
    required int id,
    required int postId,
    required String name,
    required String email,
    required String body,
  });

  @override
  factory CommentDTO.fromJson(Map<String, dynamic> map) => CommentDTO(
        id: map['id'] ?? 0,
        postId: map['postId'] ?? 0,
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        body: map['body'] ?? '',
      );
}

typedef CommentDTOs = List<CommentDTO>;
