import 'dart:io';

import 'package:postgres/postgres.dart';

import '../core/utils/extensions.dart';

class DataBaseClient {
  // static final String _host = Platform.environment['HOST'] as String;
  // static final String _database = Platform.environment['DATABASE'] as String;
  // static final String _username = Platform.environment['USERNAME'] as String;
  // static final String _password = Platform.environment['PASSWORD'] as String;

  static final String _host = "dart.cvt4v5njnonp.us-east-1.rds.amazonaws.com";
  static final String _database = "dart_backend";
  static final String _username = "postgres";
  static final String _password = "50milhoesdeleoes";

  static const int _port = 5432;

  static PostgreSQLConnection get connection => _connection;

  static final PostgreSQLConnection _connection =
      PostgreSQLConnection(_host, _port, _database, username: _username, password: _password);

  static Future initializeDatabase() async => await _connection.open();

  static insertInto<T>({required Table table, required InsertionObject insertionObject}) async {
    String insertionAttributesString = ConvertTableString.getInsertionAttributesString(table);
    String valuesString = ConvertTableString.getInsertionValuesString(table);
    await _connection.query("INSERT INTO ${table.tableName} ($insertionAttributesString) VALUES ($valuesString)",
        substitutionValues: insertionObject.insertionMap);
  }
}

abstract class InsertionObject extends Object {
  Map<String, dynamic> get insertionMap;
}

abstract class Table extends Object {
  String get tableName;
  List<String> get entityAttributes;
  List<String> get insertionAttributes;
}
