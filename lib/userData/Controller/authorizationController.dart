import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/userData/currentUser.dart';
import 'package:synword/userData/model/authUserData.dart';
import 'package:synword/userData/model/unauthUserData.dart';
import 'package:synword/constants/mainServerData.dart';
import '../../responseException.dart';
import '../../serverException.dart';
import 'package:synword/userData/Controller/authUserServerRequestsController.dart';
import 'package:synword/userData/Controller/unauthUserServerRequestsController.dart';

class AuthorizationController {
  CurrentUser _currentUser = CurrentUser();

  void setAuth() {
    try{
      print("1");
      _currentUser.userData = AuthUserData();
      print(_currentUser.serverRequest);
      _currentUser.serverRequest = AuthUserServerRequestsController();
      print(_currentUser.serverRequest);
      _getAllUserDataFromServer(googleAuthService.googleAuth.idToken);
      print('User authorized successfully');
      print('isAuthorized: ${_currentUser.userData.isAuthorized}');
    }
    catch(_){
      throw ServerException();
    }
  }

  void setUnauth(){
    _currentUser.userData = UnauthUserData();
    _currentUser.serverRequest = UnauthUserServerRequestsController();

    print('User deauthorized successfully');
    print('isAuthorized: ${_currentUser.userData.isAuthorized}');
  }

  Future<void> _getAllUserDataFromServer(String uId) async{
    try{
      var url = MainServerData.protocol + MainServerData.IP + MainServerData.authUserApi.getAllUserData;

      var response = await http.post(Uri.encodeFull(url), body: jsonEncode(uId), headers: {'Content-Type':'application/json'});
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
    catch(ex){
      throw ResponseException();
    }
  }
}