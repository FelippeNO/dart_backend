import '../user_entity.dart';

class UserEntityMapper {
  static UserEntity fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      createdAt: json['last_name'],
      gender: json['gender'],
      username: json['username'],
    );
  }
}
