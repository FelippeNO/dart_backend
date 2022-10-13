import '../../../../core/utils/extensions.dart';
import '../../infraestructure/tables/users_table.dart';
import '../creating_user_io.dart';

class CreatingUserMapper {
  static CreatingUser<UsersTable> fromJson(Map<String, dynamic> json) {
    return CreatingUser<UsersTable>(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      password: CoreKeys.hashPassword(json['password']),
      gender: json['gender'],
      username: json['username'],
      id: CoreKeys.generateUUID(),
    );
  }
}
