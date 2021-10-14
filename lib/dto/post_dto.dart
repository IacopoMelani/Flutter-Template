class PostDTO {
  PostDTO({
    required int id,
    required int userId,
    required String title,
    required String body,
  });

  @override
  factory PostDTO.fromJson(Map<String, dynamic> map) => PostDTO(
        id: map['id'] ?? 0,
        userId: map['userId'] ?? 0,
        title: map['title'] ?? '',
        body: map['body'] ?? '',
      );
}

typedef PostDTOs = List<PostDTO>;
