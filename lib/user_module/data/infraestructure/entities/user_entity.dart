class UserEntity {
  final String id;
  final String email;
  final String lastName;
  final String firstName;
  final String username;
  final String gender;
  final String createdAt;

  UserEntity({
    required this.id,
    required this.email,
    required this.lastName,
    required this.firstName,
    required this.username,
    required this.gender,
    required this.createdAt,
  });
}
