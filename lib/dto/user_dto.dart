class UserDTO {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;

  UserDTO({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
  });

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
