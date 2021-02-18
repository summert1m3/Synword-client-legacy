import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import 'package:synword/model/json/uniqueCheckData.dart';
import 'package:synword/model/json/uniqueUpData.dart';

abstract class ServerRequestsInterface {
  Future<UniqueUpData> uniqueUpRequest(String text);
  Future<UniqueCheckData> uniqueCheckRequest(String text);
  Future<Response> docxUniqueUpRequest({FilePickerResult filePickerResult});
  Future<UniqueCheckData> docxUniqueCheckRequest({FilePickerResult filePickerResult});
  void fromJson(Map<String, dynamic> json);
}