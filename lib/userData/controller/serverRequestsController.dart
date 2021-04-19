import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:synword/model/fileData.dart';
import 'package:synword/model/json/uniqueCheckData.dart';
import 'package:synword/model/json/uniqueUpData.dart';
import 'package:synword/userData/currentUser.dart';
import 'package:synword/network/ServerStatus.dart';

class ServerRequestsController {
  static Future<UniqueUpData> uniqueUpRequest(BuildContext context, String text) async {
    await ServerStatus.check();
    return await CurrentUser.serverRequest.uniqueUpRequest(context, text);
  }

  static Future<UniqueCheckData> uniqueCheckRequest(String text) async {
    await ServerStatus.check();
    return await CurrentUser.serverRequest.uniqueCheckRequest(text);
  }

  static Future<Response> docxUniqueUpRequest(
      {required FileData file}) async {
    await ServerStatus.check();
    return await CurrentUser.serverRequest
        .docxUniqueUpRequest(file: file);
  }

  static Future<UniqueCheckData> docxUniqueCheckRequest(
      {required FileData file}) async {
    await ServerStatus.check();
    return await CurrentUser.serverRequest
        .docxUniqueCheckRequest(file: file);
  }
}