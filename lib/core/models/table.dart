abstract class Table extends Object {
  String get tableName;
  String get primaryKey;
  List<String> get entityAttributes;
  List<String> get insertionAttributes;
}
