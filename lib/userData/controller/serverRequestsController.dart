import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import 'package:synword/constants/mainServerData.dart';
import 'package:synword/exceptions/serverException.dart';
import 'package:synword/model/json/uniqueCheckData.dart';
import 'package:synword/model/json/uniqueUpData.dart';
import 'package:synword/userData/currentUser.dart';

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

class ServerStatus{
  static Future<void> check() async{
    try {
      var response = await http.get(MainServerData.protocol + MainServerData.IP)
          .timeout(Duration(seconds: 3));
      print(response.body);
    }
    catch(_){
      throw ServerException();
    }
  }
}