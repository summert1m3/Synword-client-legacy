import 'package:dio/dio.dart';
import 'package:synword/model/fileData.dart';
import 'package:synword/model/json/uniqueCheckData.dart';
import 'package:synword/model/json/uniqueUpData.dart';
import 'package:synword/userData/currentUser.dart';
import 'package:synword/network/ServerStatus.dart';

class ServerRequestsController {
  CurrentUser _currentUser = CurrentUser();

  Future<UniqueUpData> uniqueUpRequest(String text) async {
    await ServerStatus.check();
    return await _currentUser.serverRequest.uniqueUpRequest(text);
  }

  Future<UniqueCheckData> uniqueCheckRequest(String text) async {
    await ServerStatus.check();
    return await _currentUser.serverRequest.uniqueCheckRequest(text);
  }

  Future<Response> docxUniqueUpRequest(
      {FileData file}) async {
    await ServerStatus.check();
    return await _currentUser.serverRequest
        .docxUniqueUpRequest(file: file);
  }

  Future<UniqueCheckData> docxUniqueCheckRequest(
      {FileData file}) async {
    await ServerStatus.check();
    return await _currentUser.serverRequest
        .docxUniqueCheckRequest(file: file);
  }
}