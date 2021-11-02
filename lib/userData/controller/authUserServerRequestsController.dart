import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:synword/exceptions/serverUnavailableException.dart';
import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/language/localeController.dart';
import 'package:synword/model/fileData.dart';
import 'package:synword/model/json/uniqueCheckData.dart';
import 'package:synword/model/json/uniqueUpData.dart';
import 'package:synword/network/ServerStatus.dart';
import 'package:synword/userData/interface/serverRequestsInterface.dart';
import 'package:synword/constants/mainServerData.dart';
import '../currentUser.dart';
import 'determineExceptionType.dart';

class AuthUserServerRequestsController implements ServerRequestsInterface {
  Dio _dio = new Dio(
    BaseOptions(contentType: Headers.formUrlEncodedContentType),
  );

  @override
  Future<UniqueCheckData> uniqueCheckRequest(String text) async {
    try {
      var response = await _dio.post(
          MainServerData.authUserApi.uniqueCheckApiUrl,
          data: {"uid": GoogleAuthService.googleUser!.id, "text": text});

      print(response.data.toString());

      String responseString = response.data.toString();

      Map<String, dynamic> responseJson = jsonDecode(responseString);

      UniqueCheckData uniqueCheckData = UniqueCheckData.fromJson(responseJson);

      return uniqueCheckData;
    } on DioError catch(ex){
      throw DetermineExceptionType.determine(ex);
    }
  }

  @override
  Future<UniqueUpData> uniqueUpRequest(String text) async {
    try {
      var response = await _dio.post(MainServerData.authUserApi.uniqueUpApiUrl,
          data: {
              "uid": GoogleAuthService.googleUser!.id,
              "text": text,
              "language" : LocaleController.getFullLangName()
        });

      print(response.data.toString());

      String responseString = response.data.toString();

      Map<String, dynamic> responseJson = jsonDecode(responseString);

      UniqueUpData uniqueUpData = UniqueUpData.fromJson(responseJson);

      return uniqueUpData;
    } on DioError catch(ex){
      throw DetermineExceptionType.determine(ex);
    }
  }

  @override
  Future<Response> docxUniqueUpRequest({required FileData file}) async {
    try {
      Dio dio = Dio();

      FormData formData = new FormData.fromMap({
        "uId": GoogleAuthService.googleUser!.id,
        "Files": new MultipartFile.fromBytes(file.bytes, filename: file.name),
        "language" : LocaleController.getFullLangName()
      });

      Response response = await dio
          .post(MainServerData.authUserApi.docxUniqueUpApiUrl,
              data: formData,
              options: Options(
                responseType: ResponseType.bytes,
              ))
          .timeout(Duration(seconds: 80));

      return response;
    } on DioError catch(ex){
      throw DetermineExceptionType.determine(ex);
    }
  }

  @override
  Future<UniqueCheckData> docxUniqueCheckRequest({required FileData file}) async {
    try {
      Dio dio = Dio();

      FormData formData = new FormData.fromMap({
        "uId": GoogleAuthService.googleUser!.id,
        "Files": new MultipartFile.fromBytes(file.bytes, filename: file.name),
      });

      Response response = await dio
          .post(
            MainServerData.authUserApi.docxUniqueCheckApiUrl,
            data: formData,
          )
          .timeout(Duration(seconds: 80));

      String responseString = response.data;

      Map<String, dynamic> responseJson = jsonDecode(responseString);
      UniqueCheckData uniqueCheckData = UniqueCheckData.fromJson(responseJson);

      return uniqueCheckData;
    } on DioError catch(ex){
      throw DetermineExceptionType.determine(ex);
    }
  }

  Future<void> authorization() async {
    await ServerStatus.check();
    Response response;
    try {
      response = await _dio.post(MainServerData.authUserApi.getAllUserData,
          data: {
            "uid": GoogleAuthService.googleUser!.id
          }).timeout(Duration(seconds: 5));

      CurrentUser.userData.fromJson(jsonDecode(response.data));
      CurrentUser.userData.uId = GoogleAuthService.googleUser!.id;
    } on DioError catch (_) {
      throw ServerUnavailableException();
    }
  }

  Future<void> registration() async {
    await ServerStatus.check();
    print('registration');
    try {
      var response = await _dio.post(MainServerData.authUserApi.registration,
          data: {"accessToken": GoogleAuthService.googleAuth!.accessToken});
      print(response.data.toString());
      print('registration end');
    } on DioError catch (_) {
      throw ServerUnavailableException();
    }
  }
}
