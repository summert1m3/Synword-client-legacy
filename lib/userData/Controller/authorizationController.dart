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
      _currentUser.userData = AuthUserData();
      _currentUser.serverRequest = AuthUserServerRequestsController();

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
      var url = MainServerData.IP + MainServerData.authUserApi.getAllUserData;

      var response = await http.post(Uri.encodeFull(url), body: jsonEncode(uId), headers: {'Content-Type':'application/json'});

      print('Response status: ${response.statusCode}');

      if (response.statusCode != 200) {
        throw ResponseException();
      }

      _currentUser.serverRequest.fromJson(jsonDecode(response.body));
    }
    catch(ex){
      throw ResponseException();
    }
  }
}