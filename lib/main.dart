import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'dart:convert';

import 'database/database_client.dart';

void main() async {
  await DataBaseClient.initializeDatabase();

  final Router app = Router();
  app.get('/get_user_name_by_id/<user_id>', AccountServices.handleGetUserNameById);
  app.get('/get_user_age_by_id/<user_id>', AccountServices.handleGetUserAgeById);
  app.post('/create_new_user', AccountServices.handleCreateNewUser);
  app.post('/a', AccountServices.aaaa);

  final server = await shelf_io.serve(app, 'https://backend-dart-test.herokuapp.com/', 8080);

  print('Serving at http://${server.address.host}:${server.port}');
}

class AccountServices {
  static Future<Response> aaaa(Request request) async {
    final query = await DataBaseClient.connection.query(
        "INSERT INTO users (username, email, password) VALUES (@username, @email, @password)",
        substitutionValues: {
          "username": "name",
          "email": "mail",
          "password": "password",
        });
    return Response(200, body: "true");
  }

  static Future<Response> handleGetUserNameById(Request request) async {
    final userId = request.params['user_id'];
    String userName = await AccountRepository.getUserNameById(userId!);
    Map<String, String> json = {"name": userName};
    final encodedBody = jsonEncode(json);
    return Response(200, body: encodedBody);
  }

  static Future<Response> handleGetUserAgeById(Request request) async {
    final userId = request.params['user_id'];
    int idade = await AccountRepository.getUserAgeById(userId!);
    Map<String, int> json = {"idade": idade};
    final encodedBody = jsonEncode(json);
    return Response(200, body: encodedBody);
  }

  static Future<Response> handleCreateNewUser(Request request) async {
    final String query = await request.readAsString();
    final decodedBody = jsonDecode(query);

    String nome = decodedBody["nome"];
    int idade = int.parse(decodedBody["idade"]);
    String email = decodedBody["email"];

    bool wasUserCreated = await AccountRepository.createUser(
      name: nome,
      age: idade,
      email: email,
    );
    return Response(200, body: wasUserCreated.toString());
  }
}

class AccountRepository {
  static Future<String> getUserNameById(String userId) async {
    final int userIdInt = int.parse(userId);
    List<List<dynamic>> results = await DataBaseClient.connection
        .query("SELECT nome FROM pessoas WHERE user_id = @user_id", substitutionValues: {"user_id": userIdInt});
    return results[0][0];
  }

  static Future<int> getUserAgeById(String userId) async {
    final int userIdInt = int.parse(userId);
    List<List<dynamic>> results = await DataBaseClient.connection
        .query("SELECT idade FROM pessoas WHERE user_id = @user_id", substitutionValues: {"user_id": userIdInt});
    return results[0][0];
  }

  static Future<bool> createUser({required String name, required int age, required String email}) async {
    final query = await DataBaseClient.connection
        .query("INSERT INTO pessoas (nome, idade, email) VALUES (@name, @idade, @email)", substitutionValues: {
      "name": name,
      "idade": age,
      "email": email,
    });
    return true;
  }
}
