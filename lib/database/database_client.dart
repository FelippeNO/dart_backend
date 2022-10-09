import 'dart:io';

import 'package:postgres/postgres.dart';

class DataBaseClient {
  static final String _host = Platform.environment['HOST'] as String;
  static final String _database = Platform.environment['DATABASE'] as String;
  static final String _username = Platform.environment['USERNAME'] as String;
  static final String _password = Platform.environment['PASSWORD'] as String;
  static const int _port = 5432;

  static PostgreSQLConnection get connection => _connection;

  static final PostgreSQLConnection _connection =
      PostgreSQLConnection(_host, _port, _database, username: _username, password: _password);

  static Future initializeDatabase() async => await _connection.open();
}
