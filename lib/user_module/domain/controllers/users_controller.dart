import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../../data/insertion_objects/mappers/creating_user_mapper.dart';
import '../services/creating_user_entity_service.dart';

class UsersController {
  static Future<Response> createUser(Request request) async {
    final String query = await request.readAsString();
    final decodedBody = jsonDecode(query);
    final creatingUser = CreatingUserMapper.fromJson(decodedBody);
    String userAdded = await CreatingUserEntityService.call(creatingUser: creatingUser);
    return Response(200, body: "User ${creatingUser.username} added with Id = $userAdded");
  }
}
