import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
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
      {FilePickerResult filePickerResult}) async {
    await ServerStatus.check();
    return await _currentUser.serverRequest
        .docxUniqueUpRequest(filePickerResult: filePickerResult);
  }

  Future<UniqueCheckData> docxUniqueCheckRequest(
      {FilePickerResult filePickerResult}) async {
    await ServerStatus.check();
    return await _currentUser.serverRequest
        .docxUniqueCheckRequest(filePickerResult: filePickerResult);
  }
}