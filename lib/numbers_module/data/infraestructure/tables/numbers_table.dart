import '../../../../core/models/table.dart';

class NumbersTable extends Table {
  static const String _primaryKey = "id";
  static const String _tablename = "numbers";
  static const List<String> _entityAttributes = ["id", "number1", "number2", "multiply"];
  static const List<String> _insertionAttributes = ["number1", "number2", "multiply"];

  @override
  String get tableName => _tablename;

  @override
  List<String> get entityAttributes => _entityAttributes;

  @override
  List<String> get insertionAttributes => _insertionAttributes;

  @override
  String get primaryKey => _primaryKey;
}
