import '../../data/infraestructure/insertion_objects/creating_number_io.dart';
import '../../data/infraestructure/tables/numbers_table.dart';
import '../../data/repositories/numbers_repository.dart';

class CreateNumberEntityService {
  static Future<int> call({required CreatingNumber<NumbersTable> creatingNumberEntity}) async =>
      await NumbersRepository.createNumberEntity(creatingNumberEntity: creatingNumberEntity);
}
