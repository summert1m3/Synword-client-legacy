import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:synword/uniqueCheckData.dart';
import 'package:synword/uniqueUpData.dart';

abstract class ServerRequestsInterface {
  Future<UniqueUpData> uniqueUpRequest(String text);
  Future<UniqueCheckData> uniqueCheckRequest(String text);
  Future<Response> docxUniqueUpRequest({FilePickerResult filePickerResult});
  Future<UniqueCheckData> docxUniqueCheckRequest({FilePickerResult filePickerResult});
  void fromJson(Map<String, dynamic> json);
}