import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
  static GoogleSignInAccount? googleUser;
  static GoogleSignInAuthentication? googleAuth;

  static Future<void> signIn() async {
      googleUser = await _googleSignIn.signIn();
      if(googleUser != null) {
        googleAuth = await googleUser?.authentication;
      }
  }

  static Future<void> signInSilently() async {
   googleUser = await _googleSignIn.signInSilently();
   if (googleUser != null){
     googleAuth = await googleUser?.authentication;
     print('Google signed in silently');
   }
  }

  static Future<void> signOut() async {
    _googleSignIn.disconnect();
    googleUser = null;
    googleAuth = null;
  }
}