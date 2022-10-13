import '../../../../core/models/insertion_object.dart';

class CreatingUser<UsersTable> extends InsertionObject {
  final String id;
  final String email;
  final String lastName;
  final String firstName;
  final String username;
  final String gender;
  final String password;

  CreatingUser({
    required this.id,
    required this.email,
    required this.lastName,
    required this.firstName,
    required this.username,
    required this.gender,
    required this.password,
  });

  static Type get type => CreatingUser;

  @override
  Map<String, dynamic> get insertionMap => {
        "id": id,
        "email": email,
        "username": username,
        "password": password,
        "gender": gender,
        "first_name": firstName,
        "last_name": lastName,
      };
}
