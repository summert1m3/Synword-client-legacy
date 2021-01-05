import 'dart:convert';
import 'dart:io';

import 'package:synword/uniqueCheckData.dart';
import 'package:synword/responseException.dart';
import 'package:synword/serverException.dart';
import 'package:synword/widgets/googleAuth/googleAuthService.dart';
import 'userDataInterface.dart';

import 'package:synword/widgets/userData/model/serverRequsts/authUniqueCheck.dart';
import 'package:synword/widgets/userData/model/serverRequsts/authUniqueUp.dart';

class AuthUserData implements UserDataInterface{
  AuthUserData._internal(){
    isAuthorized = true;
  }

  static final AuthUserData _userAuthorized = AuthUserData._internal();

  factory AuthUserData(){
    return _userAuthorized;
  }

  bool isAuthorized;

  bool isPremium;

  int uniqueCheckMinSymbolLimit;
  int uniqueUpMinSymbolLimit;

  int uniqueCheckMaxSymbolLimit;
  int uniqueUpMaxSymbolLimit;

  int uniqueCheckRequests;
  int uniqueUpRequests;
  int documentUniqueUpRequests;

  @override
  Future<UniqueCheckData> uniqueCheckRequest(String text) async{
    try {
      HttpClient client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

      HttpClientRequest request = await client.postUrl(Uri.http('194.87.146.123', '/api/uniquecheck/auth'));
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json; charset=utf-8');

      AuthUniqueCheckModel uniqueCheckModel = AuthUniqueCheckModel(googleAuthService.googleAuth.idToken, text);

      request.write(jsonEncode(uniqueCheckModel.toJson()));

      HttpClientResponse response = await request.close();

      if (response.statusCode != 200) {
        throw new ResponseException();
      }

      String responseString = await utf8.decoder.bind(response).join();
      Map<String, dynamic> responseJson = jsonDecode(responseString);

      UniqueCheckData uniqueCheckData = UniqueCheckData.fromJson(responseJson);

      return uniqueCheckData;
    } catch (_) {
      throw new ServerException();
    }
  }

  @override
  Future<String> uniqueUpRequest(String text) async{
    try {
      HttpClient client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

      HttpClientRequest request = await client.postUrl(Uri.http('194.87.146.123', '/api/freesynonymize/auth'));

      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json; charset=utf-8');

      AuthUniqueUpModel uniqueUpModel = AuthUniqueUpModel(googleAuthService.googleAuth.idToken, text);

      request.write(jsonEncode(uniqueUpModel.toJson()));

      HttpClientResponse response = await request.close();
      if (response.statusCode != 200) {
        throw ResponseException();
      }
      String responseString = await utf8.decoder.bind(response).join();

      return responseString;
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  void fromJson(Map<String, dynamic> json) {
    isPremium = json['isPremium'] as bool;

    uniqueCheckMaxSymbolLimit = json['uniqueCheckMaxSymbolLimit'] as int;
    uniqueUpMaxSymbolLimit = json['uniqueUpMaxSymbolLimit'] as int;

    uniqueCheckRequests = json['uniqueCheckRequests'] as int;
    uniqueUpRequests = json['uniqueUpRequests'] as int;
    documentUniqueUpRequests = json['documentUniqueUpRequests'] as int;
  }
}