class UserDTO {
  UserDTO({
    required int id,
    required String name,
    required String username,
    required String email,
    required String phone,
    required String website,
  });

  @override
  factory UserDTO.fromJson(Map<String, dynamic> map) => UserDTO(
        id: map['id'] ?? 0,
        name: map['name'] ?? '',
        username: map['username'] ?? '',
        email: map['email'] ?? '',
        phone: map['phone'] ?? '',
        website: map['website'] ?? '',
      );
}

typedef UserDTOs = List<UserDTO>;
