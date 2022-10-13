import 'dart:io';

import 'package:dart_backend/user_module/domain/controllers/users_controller.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

import 'core/routes/core_routes.dart';
import 'database/database_client.dart';
import 'numbers_module/domain/controllers/numbers_controller.dart';

void main() async {
  await DataBaseClient.initializeDatabase();
  await CoreRoutes.initializeRoutes();

  final Router app = CoreRoutes.routes;
//  app.get('/get_user_name_by_id/<user_id>', AccountServices.handleGetUserNameById);
  // app.get('/get_user_age_by_id/<user_id>', AccountServices.handleGetUserAgeById);
  //app.post('/multiply_numbers', NumbersController.createNumberEntity);
  // app.get('/get_numbers_by_id', NumbersController.getNumbersById);
  //app.post('/create_user', UsersController.createUser);

  // app.post('/a', AccountServices.aaaa);

  var env = Platform.environment;
  var port = env.entries.firstWhere((element) => element.key == 'PORT', orElse: () => MapEntry('PORT', '8080'));

  final server = await shelf_io.serve(
    app,
    // '0.0.0.0',
    "localhost",
    int.parse(port.value),
  );

  print('Serving at http://${server.address.host}:${server.port}');
}








// class AccountServices {
//   static Future<Response> aaaa(Request request) async {
//     final query = await DataBaseClient.connection.query(
//         "INSERT INTO users (username, email, password) VALUES (@username, @email, @password)",
//         substitutionValues: {
//           "username": "123",
//           "email": "54342",
//           "password": "password2222",
//         });
//     return Response(200, body: "true");
//   }

//   static Future<Response> handleGetUserNameById(Request request) async {
//     final userId = request.params['user_id'];
//     String userName = await AccountRepository.getUserNameById(userId!);
//     Map<String, String> json = {"name": userName};
//     final encodedBody = jsonEncode(json);
//     return Response(200, body: encodedBody);
//   }

//   static Future<Response> handleGetUserAgeById(Request request) async {
//     final userId = request.params['user_id'];
//     int idade = await AccountRepository.getUserAgeById(userId!);
//     Map<String, int> json = {"idade": idade};
//     final encodedBody = jsonEncode(json);
//     return Response(200, body: encodedBody);
//   }

//   static Future<Response> handleCreateNewUser(Request request) async {
//     final String query = await request.readAsString();
//     final decodedBody = jsonDecode(query);

//     String nome = decodedBody["nome"];
//     int idade = int.parse(decodedBody["idade"]);
//     String email = decodedBody["email"];

//     bool wasUserCreated = await AccountRepository.createUser(
//       name: nome,
//       age: idade,
//       email: email,
//     );
//     return Response(200, body: wasUserCreated.toString());
//   }
// }

// class AccountRepository {
//   static Future<String> getUserNameById(String userId) async {
//     final int userIdInt = int.parse(userId);
//     List<List<dynamic>> results = await DataBaseClient.connection
//         .query("SELECT nome FROM pessoas WHERE user_id = @user_id", substitutionValues: {"user_id": userIdInt});
//     return results[0][0];
//   }

//   static Future<int> getUserAgeById(String userId) async {
//     final int userIdInt = int.parse(userId);
//     List<List<dynamic>> results = await DataBaseClient.connection
//         .query("SELECT idade FROM pessoas WHERE user_id = @user_id", substitutionValues: {"user_id": userIdInt});
//     return results[0][0];
//   }

//   static Future<bool> createUser({required String name, required int age, required String email}) async {
//     final query = await DataBaseClient.connection
//         .query("INSERT INTO pessoas (nome, idade, email) VALUES (@name, @idade, @email)", substitutionValues: {
//       "name": name,
//       "idade": age,
//       "email": email,
//     });
//     return true;
//   }
// }
