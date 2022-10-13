import '../../../../core/models/table.dart';

class UsersTable extends Table {
  static final List<String> _entityAttributes = [
    "id",
    "created_at",
    "username",
    "email",
    "gender",
    "first_name",
    "last_name"
  ];
  static final List<String> _insertionAttributes = [
    "id",
    "username",
    "email",
    "password",
    "gender",
    "first_name",
    "last_name"
  ];
  static final String _primaryKey = "id";
  static final String _tableName = "users";

  @override
  List<String> get entityAttributes => _entityAttributes;

  @override
  List<String> get insertionAttributes => _insertionAttributes;

  @override
  String get primaryKey => _primaryKey;

  @override
  String get tableName => _tableName;
}
