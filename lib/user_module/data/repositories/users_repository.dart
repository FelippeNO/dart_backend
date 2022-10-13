import '../../../database/database_client.dart';
import '../infraestructure/tables/users_table.dart';
import '../insertion_objects/creating_user_io.dart';

class UsersRepository {
  static Future<String> createUserEntity({required CreatingUser<UsersTable> creatingUser}) async {
    String userId = await DataBaseClient.insertInto<UsersTable>(insertionObject: creatingUser, table: UsersTable());
    return userId;
  }
}
