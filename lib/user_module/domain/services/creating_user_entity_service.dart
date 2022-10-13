import '../../data/infraestructure/tables/users_table.dart';
import '../../data/insertion_objects/creating_user_io.dart';
import '../../data/repositories/users_repository.dart';

class CreatingUserEntityService {
  static Future<String> call({required CreatingUser<UsersTable> creatingUser}) async =>
      await UsersRepository.createUserEntity(creatingUser: creatingUser);
}
