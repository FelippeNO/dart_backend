import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

import 'database/database_client.dart';

void main() async {
  await DataBaseClient.initializeDatabase();

  final Router app = Router();
//  app.get('/get_user_name_by_id/<user_id>', AccountServices.handleGetUserNameById);
  // app.get('/get_user_age_by_id/<user_id>', AccountServices.handleGetUserAgeById);
  app.post('/multiply_numbers', NumbersController.createNumberEntity);
  // app.post('/a', AccountServices.aaaa);

  var env = Platform.environment;
  var port = env.entries.firstWhere((element) => element.key == 'PORT', orElse: () => MapEntry('PORT', '8080'));

  final server = await shelf_io.serve(
      app,
      // '0.0.0.0',
      "localhost",
      int.parse(port.value));

  print('Serving at http://${server.address.host}:${server.port}');
}

class NumbersController {
  static Future<Response> createNumberEntity(Request request) async {
    final String query = await request.readAsString();
    final decodedBody = jsonDecode(query);

    int number1 = int.parse(decodedBody["number1"]);
    int number2 = int.parse(decodedBody["number2"]);

    CreatingNumber<NumbersTable> creatingNumber =
        CreatingNumber(multiply: number1 * number2, number1: number1, number2: number2);
    int multiplyRequest = await CreateNumberEntityService.call(creatingNumberEntity: creatingNumber);

    return Response(200, body: "Multiplicação: " + multiplyRequest.toString());
  }
}

class CreateNumberEntityService {
  static Future<int> call({required CreatingNumber<NumbersTable> creatingNumberEntity}) async =>
      await NumbersRepository.createNumberEntity(creatingNumberEntity: creatingNumberEntity);
}

class NumbersRepository {
  static Future<int> createNumberEntity({required CreatingNumber<NumbersTable> creatingNumberEntity}) async {
    await DataBaseClient.insertInto<NumbersTable>(insertionObject: creatingNumberEntity, table: NumbersTable());
    return 0;
  }
}

class NumbersTable extends Table {
  static const String _tablename = "numbers";
  static const List<String> _entityAttributes = ["id", "number1", "number2", "multiply"];
  static const List<String> _insertionAttributes = ["number1", "number2", "multiply"];

  @override
  String get tableName => _tablename;

  @override
  List<String> get entityAttributes => _entityAttributes;

  @override
  List<String> get insertionAttributes => _insertionAttributes;
}

class NumbersEntity {
  final int id;
  final int number1;
  final int number2;
  final int multiply;

  NumbersEntity({
    required this.id,
    required this.number1,
    required this.number2,
    required this.multiply,
  });
}

class CreatingNumber<NumbersTable> extends InsertionObject {
  final int number1;
  final int number2;
  final int multiply;

  static Type get type => CreatingNumber;

  CreatingNumber({
    required this.number1,
    required this.number2,
    required this.multiply,
  });

  @override
  Map<String, dynamic> get insertionMap => {
        "number1": number1,
        "number2": number2,
        "multiply": multiply,
      };
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
