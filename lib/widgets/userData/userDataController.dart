import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:synword/widgets/userData/model/userDataInterface.dart';
import 'package:synword/widgets/userData/model/authUserData.dart';
import 'package:synword/widgets/userData/model/unauthUserData.dart';
import 'package:synword/widgets/googleAuth/googleAuthService.dart';
import 'package:synword/responseException.dart';

import 'package:synword/uniqueCheckData.dart';

import 'package:synword/serverException.dart';

class UserDataController {
  UserDataController._internal();
  static final UserDataController _userDataController = UserDataController._internal();

  factory UserDataController(){
    return _userDataController;
  }

  UserDataInterface _userData;

  Future<String> uniqueUpRequest(String text) async {
    try{
      return await _userData.uniqueUpRequest(text);
    }
    catch(_){
      throw ServerException();
    }
  }

  Future<UniqueCheckData> uniqueCheckRequest(String text) async{
    try{
      return await _userData.uniqueCheckRequest(text);
    }
    catch(_){
      throw ServerException();
    }
  }

  void setAuth() {
    try{
      _userData = AuthUserData();
      _getAllUserDataFromServer(googleAuthService.googleAuth.idToken);
      print('User authorized successfully');
      print('isAuthorized: ${_userData.isAuthorized}');
    }
    catch(_){
      throw ServerException();
    }
  }

  void setUnauth(){
    _userData = UnauthUserData();
    print('User deauthorized successfully');
    print('isAuthorized: ${_userData.isAuthorized}');
  }

  void decrementUniqueCheckRequests() {
    --_userData.uniqueCheckRequests;
  }

  void decrementUniqueUpRequests() {
    --_userData.uniqueUpRequests;
  }

  void decrementDocumentUniqueUpRequests() {
    --_userData.documentUniqueUpRequests;
  }

  Future<void> _getAllUserDataFromServer(String uId) async{
      try{
        var url = 'http://194.87.146.123/api/GetUserData';

        var response = await http.post(Uri.encodeFull(url), body: jsonEncode(uId), headers: {'Content-Type':'application/json'});

        print('Response status: ${response.statusCode}');

        if (response.statusCode != 200) {
          throw ResponseException();
        }

        _userData.fromJson(jsonDecode(response.body));
      }
      catch(ex){
        throw ResponseException();
      }
  }

}

final UserDataController userDataController = new UserDataController();