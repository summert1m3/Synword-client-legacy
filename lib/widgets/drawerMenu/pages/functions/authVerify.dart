import 'package:synword/exceptions/authException.dart';
import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/userData/controller/authorizationController.dart';

Future<void> authVerify() async {
    if (GoogleAuthService.googleUser == null) {
      await GoogleAuthService.signIn();
      if (GoogleAuthService.googleUser != null) {
        await AuthorizationController.authorization();
      }
      else{
        throw AuthException();
      }
    }
}