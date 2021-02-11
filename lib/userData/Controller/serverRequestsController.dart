import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:synword/serverException.dart';
import 'package:synword/uniqueCheckData.dart';
import 'package:synword/uniqueUpData.dart';
import 'package:synword/userData/currentUser.dart';


class ServerRequestsController {
  CurrentUser _currentUser = CurrentUser();

  Future<UniqueUpData> uniqueUpRequest(String text) async {
    try{

      return await _currentUser.serverRequest.uniqueUpRequest(text);
    }
    catch(_){
      throw ServerException();
    }
  }

  Future<UniqueCheckData> uniqueCheckRequest(String text) async{
    try{
      return await _currentUser.serverRequest.uniqueCheckRequest(text);
    }
    catch(_){
      throw ServerException();
    }
  }

  Future<Response> docxUniqueUpRequest({FilePickerResult filePickerResult}) async{
    try {
      return await _currentUser.serverRequest.docxUniqueUpRequest(
          filePickerResult: filePickerResult);
    }
    catch(_){
      throw ServerException();
    }
  }

  Future<UniqueCheckData> docxUniqueCheckRequest({FilePickerResult filePickerResult}) async{
    try {
      return await _currentUser.serverRequest.docxUniqueCheckRequest(
          filePickerResult: filePickerResult);
    }
    catch(_){
      throw ServerException();
    }
  }

}