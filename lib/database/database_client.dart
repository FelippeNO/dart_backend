import 'package:postgres/postgres.dart';

import '../core/models/insertion_object.dart';
import '../core/models/table.dart';
import '../core/utils/extensions.dart';

class DataBaseClient {
  // static final String _host = Platform.environment['HOST'] as String;
  // static final String _database = Platform.environment['DATABASE'] as String;
  // static final String _username = Platform.environment['USERNAME'] as String;
  // static final String _password = Platform.environment['PASSWORD'] as String;

  // static final String _host = "dart.cvt4v5njnonp.us-east-1.rds.amazonaws.com";
  // static final String _database = "dart_backend";
  // static final String _username = "postgres";
  // static final String _password = "50milhoesdeleoes";

  static final String _host = "db.fywgooxpfczruhpnylst.supabase.co";
  static final String _database = "postgres";
  static final String _username = "postgres";
  static final String _password = "hAVdTGaQMHVNBPFS,.@";

  static const int _port = 5432;

  static PostgreSQLConnection get connection => _connection;

  static final PostgreSQLConnection _connection =
      PostgreSQLConnection(_host, _port, _database, username: _username, password: _password);

  static Future initializeDatabase() async => await _connection.open();

  static Future<String> insertInto<T>({required Table table, required InsertionObject insertionObject}) async {
    TableModelIntegrity.verify(table);

    String insertionAttributesString = ConvertTableString.getInsertionAttributesString(table);
    String valuesString = ConvertTableString.getInsertionValuesString(table);
    String primaryKey = table.primaryKey;
    String insertedRowPrimaryKey = await _connection.transaction((ctx) async {
      PostgreSQLResult result = await ctx.query(
          "INSERT INTO ${table.tableName} ($insertionAttributesString) VALUES ($valuesString) RETURNING $primaryKey",
          substitutionValues: insertionObject.insertionMap);
      return result[0][0].toString();
    });
    return insertedRowPrimaryKey;
  }

  static Future<Map<String, dynamic>> getEntityByField(
      {required Table table, required String field, required String fieldValue}) async {
    final Map<String, dynamic> mapCollumns = {};
    TableModelIntegrity.verify(table);
    await _connection.transaction((ctx) async {
      for (var collumn in table.entityAttributes) {
        PostgreSQLResult value = await ctx.query(
            "SELECT $collumn FROM ${table.tableName} WHERE ${table.tableName}.$field = @fieldValue",
            substitutionValues: {'fieldValue': fieldValue});
        mapCollumns[collumn] = value[0][0];
      }
    });
    return mapCollumns;
  }

  static Future<dynamic> getOneFieldResultByField(
      {required Table table,
      required String field,
      required String fieldValueToMatch,
      required String fieldToReturn}) async {
    TableModelIntegrity.verify(table);
    String result = await _connection.transaction((ctx) async {
      await ctx.query(
          "SELECT $fieldToReturn FROM ${table.tableName} WHERE ${table.tableName}.$field = @fieldValueToMatch",
          substitutionValues: {"fieldValueToMatch": fieldValueToMatch});
    });
    return result[0][0];
  }
}
