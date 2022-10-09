import 'package:postgres/postgres.dart';

class DataBaseClient {
  static const String _host = "dart.cvt4v5njnonp.us-east-1.rds.amazonaws.com";
  static const String _database = "dart_backend";
  static const String _username = "postgres";
  static const String _password = "12345678";
  static const int _port = 5432;

  static PostgreSQLConnection get connection => _connection;

  static final PostgreSQLConnection _connection =
      PostgreSQLConnection(_host, _port, _database, username: _username, password: _password);

  static Future initializeDatabase() async => await _connection.open();
}
