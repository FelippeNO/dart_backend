import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:postgres/postgres.dart';

import '../../../core/error/core_exception.dart';
import '../../../core/utils/extensions.dart';
import '../../../database/database_client.dart';
import '../../../user_module/data/infraestructure/entities/mappers/user_entity_mapper.dart';
import '../../../user_module/data/infraestructure/entities/user_entity.dart';
import '../../../user_module/data/infraestructure/tables/users_table.dart';

class VerifyUserAuthentication {
  static Future<Either<RequisitionException, String>> call(
          {required String username, required String password}) async =>
      await AuthRepository.verifyUserAuthentication(username: username, password: password);
}

class LoginUserService {
  static Future<String> call({required String userId, required String loggedToken}) async =>
      await AccountRepository.doLogin(userId: userId, loggedToken: loggedToken);
}

class LogoutUserService {
  static Future<String> call({required String userId}) async => await AccountRepository.doLogout(userId: userId);
}

class VerifyIfUserIsLoggedService {
  static Future<bool> call({required String userId}) async =>
      await AccountRepository.verifyIfUserIsLogged(userId: userId);
}

class AuthRepository {
  static Future<Either<RequisitionException, String>> verifyUserAuthentication(
      {required String username, required String password}) async {
    String hashedPassword = CoreKeys.hashPassword(password);
    PostgreSQLResult userPassword = await DataBaseClient.connection
        .query("SELECT password FROM users WHERE username = @username", substitutionValues: {'username': username});
    if (hashedPassword == userPassword[0][0]) {
      Map<String, dynamic> result =
          await DataBaseClient.getEntityByField(table: UsersTable(), field: "username", fieldValue: username);
      UserEntity user = UserEntityMapper.fromJson(result);
      return Right(user.id);
    }
    return Left(RequisitionsHandlers.unauthorizedException);
  }
}

class AccountRepository {
  static Future<String> doLogin({required String userId, required String loggedToken}) async {
    await DataBaseClient.connection.query(
        "INSERT INTO logged_users (user_id, login_token) VALUES (@userId, @loggedToken)",
        substitutionValues: {"userId": userId, "loggedToken": loggedToken});
    return "USER $userId LOGGED";
  }

  static Future<String> doLogout({required String userId}) async {
    await DataBaseClient.connection
        .query("DELETE FROM logged_users WHERE user_id = @userId", substitutionValues: {"userId": userId});
    return "USER $userId LOGGED OUT";
  }

  static Future<bool> verifyIfUserIsLogged({required String userId}) async {
    var result = await DataBaseClient.connection.query(
        "SELECT * FROM logged_users WHERE logged_users.user_id = @userId",
        substitutionValues: {"userId": userId});
    return result.isEmpty ? false : true;
  }
}
