import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  GoogleAuthService._internal();
  static final GoogleAuthService _googleAuthService = GoogleAuthService._internal();

  factory GoogleAuthService() {
    return _googleAuthService;
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
  GoogleSignInAccount googleUser;
  GoogleSignInAuthentication googleAuth;

  Future<void> signIn() async {
    try {
      googleUser = await _googleSignIn.signIn();
      googleAuth = await googleUser.authentication;
    }
    catch(error){
      print(error);
    }
  }

  Future<void> signInSilently() async {
   googleUser = await _googleSignIn.signInSilently();
   if (googleUser != null){
     googleAuth = await googleUser.authentication;
   }
  }

  Future<void> signOut() async {
    _googleSignIn.disconnect();
    googleUser = null;
    googleAuth = null;
  }
}

final GoogleAuthService googleAuthService = GoogleAuthService();