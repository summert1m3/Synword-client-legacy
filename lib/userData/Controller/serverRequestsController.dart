import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:synword/constants/mainServerData.dart';
import 'package:synword/exceptions/serverException.dart';
import 'package:synword/model/json/uniqueCheckData.dart';
import 'package:synword/model/json/uniqueUpData.dart';
import 'package:synword/userData/currentUser.dart';
import 'package:http/http.dart' as http;

class ServerRequestsController {
  CurrentUser _currentUser = CurrentUser();

  Future<UniqueUpData> uniqueUpRequest(String text) async {
    return await _currentUser.serverRequest.uniqueUpRequest(text);
  }

  Future<UniqueCheckData> uniqueCheckRequest(String text) async {
    return await _currentUser.serverRequest.uniqueCheckRequest(text);
  }

  Future<Response> docxUniqueUpRequest(
      {FilePickerResult filePickerResult}) async {
    return await _currentUser.serverRequest
        .docxUniqueUpRequest(filePickerResult: filePickerResult);
  }

  Future<UniqueCheckData> docxUniqueCheckRequest(
      {FilePickerResult filePickerResult}) async {
    return await _currentUser.serverRequest
        .docxUniqueCheckRequest(filePickerResult: filePickerResult);
  }
}

class ServerIsDown{
  static Future<void> check() async{
    try{
      var response = await http.get(MainServerData.protocol + MainServerData.IP).timeout(Duration(seconds: 1));
      print(response.body);
    }
    catch(ex){
      throw ServerException();
    }
  }
}