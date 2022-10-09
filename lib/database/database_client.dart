import 'package:postgres/postgres.dart';

class DataBaseClient {
  static const String _host = String.fromEnvironment('HOST');
  static const String _database = String.fromEnvironment('DATABASE');
  static const String _username = String.fromEnvironment('USERNAME');
  static const String _password = String.fromEnvironment('PASSWORD');
  static const int _port = 5432;

  static PostgreSQLConnection get connection => _connection;

  static final PostgreSQLConnection _connection =
      PostgreSQLConnection(_host, _port, _database, username: _username, password: _password);

  static Future initializeDatabase() async => await _connection.open();
}
