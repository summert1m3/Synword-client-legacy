import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/userData/UserStorageData.dart';
import 'package:synword/userData/controller/registrationController.dart';
import 'package:synword/userData/currentUser.dart';
import 'package:synword/userData/controller/authUserServerRequestsController.dart';
import 'package:synword/userData/controller/unauthUserServerRequestsController.dart';
import 'package:synword/network/ServerStatus.dart';

class AuthorizationController {
  static Future<void> authorization() async {
    await ServerStatus.check();

    if (GoogleAuthService.googleUser != null) {
      if(! await UserStorageData.isAuthUserRegistered()){
        await RegistrationController.registration();
      }
      await _setAuth();
    } else {
      if(! await UserStorageData.isUnauthUserRegistered()){
        await RegistrationController.registration();
      }
      await _setUnauth();
    }
  }

  static Future<void> _setAuth() async {
    CurrentUser.serverRequest = AuthUserServerRequestsController();

    await _serverRequest();

    print('User authorized successfully');
  }

  static Future<void> _setUnauth() async {
    CurrentUser.serverRequest = UnauthUserServerRequestsController();

    await _serverRequest();

    print('User deauthorized successfully');
  }

  static Future<void> _serverRequest() async {
    try {
      await CurrentUser.serverRequest.authorization();
    }
    catch(ex) {
      print(ex);
      await CurrentUser.serverRequest.registration();
      await CurrentUser.serverRequest.authorization();
    }
  }
}
