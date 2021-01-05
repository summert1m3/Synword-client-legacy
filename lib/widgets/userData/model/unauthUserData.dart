import 'dart:convert';
import 'dart:io';

import 'package:synword/uniqueCheckData.dart';
import 'package:synword/responseException.dart';
import 'package:synword/serverException.dart';
import 'userDataInterface.dart';

class UnauthUserData implements UserDataInterface {

  UnauthUserData._internal(){
    isAuthorized = false;
    isPremium = false;

    uniqueCheckMinSymbolLimit = 100;
    uniqueUpMinSymbolLimit = 10;

    uniqueCheckMaxSymbolLimit = 20000;
    uniqueUpMaxSymbolLimit = 20000;

    uniqueCheckRequests = 10;
    uniqueUpRequests = 1000;
    documentUniqueUpRequests = 30;
  }

  static final UnauthUserData _userUnauthorized = UnauthUserData._internal();

  factory UnauthUserData(){
    return _userUnauthorized;
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

      HttpClientRequest request = await client.postUrl(Uri.http('194.87.146.123', '/api/uniquecheck'));
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json; charset=utf-8');
      request.write(jsonEncode(text));

      HttpClientResponse response = await request.close();

      if (response.statusCode != 200) {
        throw new ResponseException();
      }

      String responseString = await utf8.decoder.bind(response).join();
      Map<String, dynamic> responseJson = jsonDecode(responseString);

      UniqueCheckData uniqueCheckData = UniqueCheckData.fromJson(responseJson);

      return uniqueCheckData;
    } catch (ex) {
      throw new ServerException();
    }
  }

  @override
  Future<String> uniqueUpRequest(String text) async{
    try {
      HttpClient client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

      HttpClientRequest request = await client.postUrl(Uri.http('194.87.146.123', '/api/freesynonymize'));

      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json; charset=utf-8');
      request.write(jsonEncode(text));
      HttpClientResponse response = await request.close();
      print(response.statusCode);
      if (response.statusCode != 200) {
        throw ResponseException();
      }
      String responseString = await utf8.decoder.bind(response).join();

      return responseString;
    } catch (ex) {
      print(ex);
      throw ServerException();
    }
  }

  @override
  void fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
  }
}