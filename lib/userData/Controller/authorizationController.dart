import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:synword/exceptions/responseException.dart';
import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/userData/currentUser.dart';
import 'package:synword/userData/model/authUserData.dart';
import 'package:synword/userData/model/unauthUserData.dart';
import 'package:synword/constants/mainServerData.dart';
import 'package:synword/userData/Controller/authUserServerRequestsController.dart';
import 'package:synword/userData/Controller/unauthUserServerRequestsController.dart';

class AuthorizationController {
  CurrentUser _currentUser = CurrentUser();

  Future<void> authorization() async {
    if(googleAuthService.googleUser == null){
      await googleAuthService.signInSilently();
    }
    if (googleAuthService.googleUser != null){
      await _setAuth();
    }
    else{
      _setUnauth();
    }
  }

  Future<void> _setAuth() async {
    try {
      _currentUser.userData = AuthUserData();
      _currentUser.serverRequest = AuthUserServerRequestsController();
      await _getAllUserDataFromServer(googleAuthService.googleAuth.idToken
          .split('.')
          .first);
    }
    catch(ex){
      print(ex);
      _setUnauth();
      rethrow;
    }
      print('User authorized successfully');
      print('isAuthorized: ${_currentUser.userData.isAuthorized}');
  }

  void _setUnauth() {
    _currentUser.userData = UnauthUserData();
    _currentUser.serverRequest = UnauthUserServerRequestsController();

    print('User deauthorized successfully');
    print('isAuthorized: ${_currentUser.userData.isAuthorized}');
  }

  Future<void> _getAllUserDataFromServer(String uId) async {
      var url = MainServerData.protocol + MainServerData.IP + MainServerData.authUserApi.getAllUserData;

      var response = await http.post(Uri.encodeFull(url), body: jsonEncode(uId), headers: {'Content-Type':'application/json'}).timeout(Duration(seconds: 5));
      print(response.body);
      print('Response status: ${response.statusCode}');

      if (response.statusCode != 200) {
        throw ResponseException();
      }

      _currentUser.serverRequest.fromJson(jsonDecode(response.body));

      print("isAuthorized: " + _currentUser.userData.isAuthorized.toString());
      print("isPremium: " + _currentUser.userData.isPremium.toString());

      print("uniqueCheckRequests: " + _currentUser.userData.uniqueCheckRequests.toString());
      print("uniqueUpRequests: " + _currentUser.userData.uniqueUpRequests.toString());

      print("uniqueUpMaxSymbolLimit: " + _currentUser.userData.uniqueUpMaxSymbolLimit.toString());
      print("uniqueCheckMaxSymbolLimit: " + _currentUser.userData.uniqueCheckMaxSymbolLimit.toString());

      print("documentUniqueUpRequests: " + _currentUser.userData.documentUniqueUpRequests.toString());
  }
}