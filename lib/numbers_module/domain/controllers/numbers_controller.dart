import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../../data/infraestructure/insertion_objects/creating_number_io.dart';
import '../../data/infraestructure/tables/numbers_table.dart';
import '../services/create_number_entity_service.dart';
import '../services/get_numbers_by_id_service.dart';

class NumbersController {
  static Future<Response> createNumberEntity(Request request) async {
    final String query = await request.readAsString();
    final decodedBody = jsonDecode(query);

    int number1 = int.parse(decodedBody["number1"]);
    int number2 = int.parse(decodedBody["number2"]);

    CreatingNumber<NumbersTable> creatingNumber =
        CreatingNumber(multiply: number1 * number2, number1: number1, number2: number2);
    int value = await CreateNumberEntityService.call(creatingNumberEntity: creatingNumber);
    print(value);

    return Response(200, body: "Multiplicação: ${number1 * number2}");
  }

  static Future<Response> getNumbersById(Request request) async {
    final String query = await request.readAsString();
    final decodedBody = jsonDecode(query);
    String numberId = decodedBody["numberId"];
    String numbers = await GetNumbersByIdService.call(numbersId: numberId);

    return Response(200, body: numbers);
  }
}
