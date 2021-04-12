import 'package:dio/dio.dart';
import 'package:synword/model/fileData.dart';
import 'package:synword/model/json/uniqueCheckData.dart';
import 'package:synword/model/json/uniqueUpData.dart';
import 'package:synword/userData/currentUser.dart';
import 'package:synword/network/ServerStatus.dart';

class ServerRequestsController {
  static Future<UniqueUpData> uniqueUpRequest(String text) async {
    await ServerStatus.check();
    return await CurrentUser.serverRequest.uniqueUpRequest(text);
  }

  static Future<UniqueCheckData> uniqueCheckRequest(String text) async {
    await ServerStatus.check();
    return await CurrentUser.serverRequest.uniqueCheckRequest(text);
  }

  static Future<Response> docxUniqueUpRequest(
      {FileData file}) async {
    await ServerStatus.check();
    return await CurrentUser.serverRequest
        .docxUniqueUpRequest(file: file);
  }

  static Future<UniqueCheckData> docxUniqueCheckRequest(
      {FileData file}) async {
    await ServerStatus.check();
    return await CurrentUser.serverRequest
        .docxUniqueCheckRequest(file: file);
  }
}