import 'package:dio/dio.dart';
import 'package:synword/model/fileData.dart';
import 'package:synword/model/json/uniqueCheckData.dart';
import 'package:synword/model/json/uniqueUpData.dart';
import 'package:synword/userData/currentUser.dart';
import 'package:synword/network/ServerStatus.dart';

class ServerRequestsController {
  static Future<UniqueUpData> uniqueUpRequest(String text) async {
    await ServerStatus.check();

    UniqueUpData uniqueUpData =
        await CurrentUser.serverRequest.uniqueUpRequest(text);

    CurrentUser.serverRequest.authorization();
    return uniqueUpData;
  }

  static Future<UniqueCheckData> uniqueCheckRequest(String text) async {
    await ServerStatus.check();

    UniqueCheckData uniqueCheckData =
        await CurrentUser.serverRequest.uniqueCheckRequest(text);

    CurrentUser.serverRequest.authorization();
    return uniqueCheckData;
  }

  static Future<Response> docxUniqueUpRequest({required FileData file}) async {
    await ServerStatus.check();

    Response response =
        await CurrentUser.serverRequest.docxUniqueUpRequest(file: file);

    CurrentUser.serverRequest.authorization();
    return response;
  }

  static Future<UniqueCheckData> docxUniqueCheckRequest(
      {required FileData file}) async {
    await ServerStatus.check();

    UniqueCheckData uniqueCheckData =
        await CurrentUser.serverRequest.docxUniqueCheckRequest(file: file);

    CurrentUser.serverRequest.authorization();
    return uniqueCheckData;
  }
}
