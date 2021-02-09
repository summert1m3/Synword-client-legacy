import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';

import 'package:synword/uniqueCheckData.dart';
import 'package:synword/responseException.dart';
import 'package:synword/serverException.dart';
import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/userData/interface/serverRequestsInterface.dart';
import 'package:synword/userData/interface/userDataInterface.dart';
import 'package:synword/userData/model/apiParams/authUniqueCheck.dart';
import 'package:synword/userData/model/apiParams/authUniqueUp.dart';
import 'package:synword/userData/model/authUserData.dart';
import 'package:synword/uniqueUpData.dart';
import 'package:synword/constants/mainServerData.dart';

class AuthUserServerRequestsController implements ServerRequestsInterface{

  UserDataInterface _userDataInterface = AuthUserData();

  @override
  Future<UniqueCheckData> uniqueCheckRequest(String text) async{
    try {
      HttpClient client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

      HttpClientRequest request = await client.postUrl(Uri.http(MainServerData.IP, MainServerData.authUserApi.uniqueCheckApiUrl));
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
  Future<UniqueUpData> uniqueUpRequest(String text) async{
    try {
      HttpClient client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

      HttpClientRequest request = await client.postUrl(Uri.http(MainServerData.IP, MainServerData.authUserApi.uniqueUpApiUrl));

      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json; charset=utf-8');

      AuthUniqueUpModel uniqueUpModel = AuthUniqueUpModel(googleAuthService.googleAuth.idToken, text);
      request.write(jsonEncode(uniqueUpModel.toJson()));

      HttpClientResponse response = await request.close();
      if (response.statusCode != 200) {
        throw ResponseException();
      }
      String responseString = await utf8.decoder.bind(response).join();
      Map<String, dynamic> responseJson = jsonDecode(responseString);

      UniqueUpData uniqueUpData = UniqueUpData.fromJson(responseJson);

      return uniqueUpData;
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<Response> docxUniqueUpRequest({FilePickerResult filePickerResult}) async{
    Dio dio = Dio();

    FormData formData = new FormData.fromMap({
      "uID" : googleAuthService.googleAuth.idToken,
      "files": new MultipartFile.fromBytes(
          filePickerResult.files.first.bytes.toList(),
          filename: filePickerResult.names.first),
    });

    Response response = await dio.post(Uri.http(MainServerData.IP, MainServerData.authUserApi.docxUniqueUpApiUrl).toString(),
        data: formData,
        options: Options(
          responseType: ResponseType.bytes,
        ));

    return response;
  }

  @override
  void fromJson(Map<String, dynamic> json) {
    _userDataInterface.isPremium = json['isPremium'] as bool;

    _userDataInterface.uniqueCheckMaxSymbolLimit = json['uniqueCheckMaxSymbolLimit'] as int;
    _userDataInterface.uniqueUpMaxSymbolLimit = json['uniqueUpMaxSymbolLimit'] as int;

    _userDataInterface.uniqueCheckRequests = json['uniqueCheckRequests'] as int;
    _userDataInterface.uniqueUpRequests = json['uniqueUpRequests'] as int;
    _userDataInterface.documentUniqueUpRequests = json['documentUniqueUpRequests'] as int;
  }
}