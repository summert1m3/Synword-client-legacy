import 'package:dio/dio.dart';
import 'package:synword/model/fileData.dart';
import 'package:synword/model/json/uniqueCheckData.dart';
import 'package:synword/model/json/uniqueUpData.dart';

abstract class ServerRequestsInterface {
  Future<UniqueUpData> uniqueUpRequest(String text);
  Future<UniqueCheckData> uniqueCheckRequest(String text);
  Future<Response> docxUniqueUpRequest({required FileData file});
  Future<UniqueCheckData> docxUniqueCheckRequest({required FileData file});
  Future<void> authorization();
  Future<void> registration();
}