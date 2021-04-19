import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:synword/exceptions/badRequestException.dart';
import 'dart:async';
import 'package:synword/exceptions/serverUnavailableException.dart';
import 'package:synword/model/fileData.dart';
import 'package:synword/model/json/uniqueCheckData.dart';
import 'package:synword/model/json/uniqueUpData.dart';
import 'package:synword/network/ServerStatus.dart';
import 'package:synword/userData/controller/determineExceptionType.dart';
import 'package:synword/userData/interface/serverRequestsInterface.dart';
import 'package:synword/constants/mainServerData.dart';
import 'package:synword/userData/userStorageData.dart';
import '../currentUser.dart';
import 'package:easy_localization/easy_localization.dart';

class UnauthUserServerRequestsController implements ServerRequestsInterface {
  Dio _dio = new Dio(
    BaseOptions(
      contentType: Headers.formUrlEncodedContentType,
    ),
  );

  @override
  Future<UniqueCheckData> uniqueCheckRequest(String text) async {
    try {
      var response = await _dio.post(
          MainServerData.unauthUserApi.uniqueCheckApiUrl,
          data: {
            "uid": CurrentUser.userData.uId,
            "text": text
          });

      print(response.data.toString());

      String responseString = response.data.toString();

      Map<String, dynamic> responseJson = jsonDecode(responseString);

      UniqueCheckData uniqueCheckData = UniqueCheckData.fromJson(responseJson);

      return uniqueCheckData;
    } on DioError catch (ex) {
      throw DetermineExceptionType.determine(ex);
    }
  }

  @override
  Future<UniqueUpData> uniqueUpRequest(BuildContext context, String text) async {
    try {
      var response = await _dio.post(
          MainServerData.unauthUserApi.uniqueUpApiUrl,
          data: {
            "uid": CurrentUser.userData.uId,
            "text": text,
            "language" : context.locale.toString() == "en_US" ? "English" : "Russian"
          });

      print(response.data.toString());

      String responseString = response.data.toString();

      Map<String, dynamic> responseJson = jsonDecode(responseString);

      UniqueUpData uniqueUpData = UniqueUpData.fromJson(responseJson);

      return uniqueUpData;
    } on DioError catch (ex) {
      throw DetermineExceptionType.determine(ex);
    }
  }

  @override
  Future<Response> docxUniqueUpRequest({required FileData file}) async {
    try {
      FormData formData = new FormData.fromMap({
        "uId": CurrentUser.userData.uId,
        "Files": new MultipartFile.fromBytes(file.bytes, filename: file.name),
      });

      Response response = await _dio
          .post(MainServerData.unauthUserApi.docxUniqueUpApiUrl.toString(),
          data: formData,
          options: Options(
            responseType: ResponseType.bytes,
          ));

      if (response.statusCode != 200) {
        throw new BadRequestException(response.data.toString());
      }

      return response;
    } on DioError catch (ex) {
      throw DetermineExceptionType.determine(ex);
    }
  }

  @override
  Future<UniqueCheckData> docxUniqueCheckRequest({required FileData file}) {
    throw UnimplementedError();
  }

  Future<void> authorization() async {
    await ServerStatus.check();

    String token = await UserStorageData.getToken();

    try {
      var response = await _dio.post(
          MainServerData.unauthUserApi.getAllUserData,
          data: {"uid": token});

      print(response.data);
      print('Response status: ${response.statusCode}');

      CurrentUser.userData.fromJson(jsonDecode(response.data));
      CurrentUser.userData.uId = token;
    } on DioError catch (_) {
      throw ServerUnavailableException();
    }
  }

  Future<void> registration() async {
    await ServerStatus.check();

    try {
      var response = await _dio.get(MainServerData.unauthUserApi.registration);

      print(response.data.toString());
      await UserStorageData.setToken(response.data.toString());
    } on DioError catch (_) {
      throw ServerUnavailableException();
    }
  }
}