import '../../../database/database_client.dart';
import '../infraestructure/insertion_objects/creating_number_io.dart';
import '../infraestructure/tables/numbers_table.dart';

class NumbersRepository {
  static Future<int> createNumberEntity({required CreatingNumber<NumbersTable> creatingNumberEntity}) async {
    String idAdded =
        await DataBaseClient.insertInto<NumbersTable>(insertionObject: creatingNumberEntity, table: NumbersTable());
    int id = int.parse(idAdded);
    return id;
  }

  static Future<String> getNumbersById({required String numbersId}) async {
    String result = await DataBaseClient.getById(table: NumbersTable(), objectId: numbersId);
    return result;
  }
}
