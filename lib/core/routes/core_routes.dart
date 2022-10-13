import 'package:shelf_router/shelf_router.dart';

import '../../auth_module/domain/controllers/auth_controller.dart';
import '../../user_module/domain/controllers/users_controller.dart';

class CoreRoutes {
  static final Router _routes = Router();
  static get routes => _routes;

  static initializeRoutes() async {
    await UserRoutes.initializeRoute(_routes);
    await AccountRoutes.initializeRoute(_routes);
    await AuthRoutes.initializeRoute(_routes);
  }
}

class UserRoutes {
  static initializeRoute(Router coreRoute) async {
    coreRoute.post('/create_user', UsersController.createUser);
  }
}

class AccountRoutes {
  static initializeRoute(Router coreRoute) async {
    coreRoute.post('/delete_account', UsersController.createUser);
  }
}

class AuthRoutes {
  static initializeRoute(Router coreRoute) async {
    coreRoute.post('/login', AuthController.login);
    coreRoute.post('/logout', AuthController.logout);
  }
}
