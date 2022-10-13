import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shelf/shelf.dart';

import '../../../core/error/core_exception.dart';
import '../../../core/utils/extensions.dart';
import '../services/verify_auth_service.dart';

class AuthController {
  static Future<Response> login(Request request) async {
    final String query = await request.readAsString();
    final decodedBody = jsonDecode(query);
    final String username = decodedBody['username'];
    final String password = decodedBody['password'];

    final verification = await _verifyUserAuthentication(username: username, password: password);
    final verificationResult = verification.fold((l) => l, (r) => r);

    if (verificationResult is RequisitionException) {
      return Response(verificationResult.statusCode, body: verificationResult.label);
    }

    if (verificationResult is String) {
      bool isUserLogged = await _verifyIfUserIsLogged(userId: verificationResult);
      if (isUserLogged == false) {
        await _doLogin(userId: verificationResult);
      } else {
        await _doLogout(userId: verificationResult);
        await _doLogin(userId: verificationResult);
      }
    }

    return Response(200, body: "User Logged!");
  }

  static Future<Response> logout(Request request) async {
    final String query = await request.readAsString();
    final decodedBody = jsonDecode(query);
    final String username = decodedBody['username'];
    final String password = decodedBody['password'];

    final verification = await _verifyUserAuthentication(username: username, password: password);
    final verificationResult = verification.fold((l) => l, (r) => r);

    if (verificationResult is RequisitionException) {
      return Response(verificationResult.statusCode, body: verificationResult.label);
    }

    if (verificationResult is String) {
      bool isUserLogged = await _verifyIfUserIsLogged(userId: verificationResult);
      if (isUserLogged == false) {
        return Response(200, body: "User Not Logged!");
      } else {
        await _doLogout(userId: verificationResult);
      }
    }
    return Response(200, body: "User Logged Out!");
  }

  static Future<Either<RequisitionException, String>> _verifyUserAuthentication(
          {required String username, required String password}) async =>
      await VerifyUserAuthentication.call(username: username, password: password);

  static Future<bool> _verifyIfUserIsLogged({required String userId}) async =>
      await VerifyIfUserIsLoggedService.call(userId: userId);

  static Future<void> _doLogin({required String userId}) async {
    final String loggedToken = CoreKeys.generateUUID();
    await LoginUserService.call(userId: userId, loggedToken: loggedToken);
  }

  static Future<void> _doLogout({required String userId}) async => await LogoutUserService.call(userId: userId);
}
