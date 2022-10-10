import '../core/error/table_integrity_exceptions.dart';
import '../core/models/table.dart';
import '../numbers_module/data/infraestructure/tables/numbers_table.dart';

void main() {
  bool tableVerification(Table table) {
    if (table.primaryKey.isEmpty) throw EmptyPrimaryKeyException;
    if (table.tableName.isEmpty) throw EmptyTableNameException;
    if (table.entityAttributes.contains(table.primaryKey)) {
      if (table.insertionAttributes.length <= table.entityAttributes.length) {
        for (var item in table.insertionAttributes) {
          if (table.entityAttributes.contains(item)) {
            return true;
          }
          throw EntityDoNotContainInsertionAttributeException;
        }
      }
      throw InsertionHasMoreAttributesThanEntityException;
    }
    throw EntityDoNotContainPrimaryKeyNameException;
  }

  var result = tableVerification(NumbersTable());
  print(result);
}
