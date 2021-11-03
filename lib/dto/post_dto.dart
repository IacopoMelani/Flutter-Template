class PostDTO {
  final int id;
  final int userId;
  final String title;
  final String body;

  PostDTO({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
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
