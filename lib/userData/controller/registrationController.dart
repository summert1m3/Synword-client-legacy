import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/network/ServerStatus.dart';
import 'package:synword/userData/UserStorageData.dart';
import 'package:synword/userData/controller/unauthUserServerRequestsController.dart';
import '../currentUser.dart';
import 'authUserServerRequestsController.dart';

class RegistrationController {
  static Future<void> registration() async {
    await ServerStatus.check();

    await _registerUnauth();

    if (GoogleAuthService.googleUser != null) {
      await _registerAuth();
    }
  }

  static Future<void> _registerAuth() async {
    CurrentUser.serverRequest = AuthUserServerRequestsController();

    await CurrentUser.serverRequest.registration();

    await UserStorageData.setAuthUserRegistered();
    print('Google user registered successfully');
  }

  static Future<void> _registerUnauth() async {
    CurrentUser.serverRequest = UnauthUserServerRequestsController();

    await CurrentUser.serverRequest.registration();

    await UserStorageData.setUnauthUserRegistered();
    print('User registered successfully');
  }
}