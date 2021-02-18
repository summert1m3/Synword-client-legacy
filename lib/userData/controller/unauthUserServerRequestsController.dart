import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';

import 'package:synword/exceptions/responseException.dart';
import 'package:synword/exceptions/serverException.dart';
import 'package:synword/model/json/uniqueCheckData.dart';
import 'package:synword/model/json/uniqueUpData.dart';
import 'package:synword/userData/interface/serverRequestsInterface.dart';
import 'package:synword/constants/mainServerData.dart';

class UnauthUserServerRequestsController implements ServerRequestsInterface {
  @override
  Future<UniqueCheckData> uniqueCheckRequest(String text) async {
    try {
      print(
          (MainServerData.IP + MainServerData.unauthUserApi.uniqueCheckApiUrl));
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      HttpClientRequest request = await client
          .postUrl(Uri.http(MainServerData.IP,
              MainServerData.unauthUserApi.uniqueCheckApiUrl))
          .timeout(Duration(seconds: 10));
      request.headers.set(
          HttpHeaders.contentTypeHeader, 'application/json; charset=utf-8');
      request.write(jsonEncode(text));

      HttpClientResponse response = await request.close();

      if (response.statusCode != 200) {
        throw new ResponseException();
      }

      String responseString = await utf8.decoder.bind(response).join();
      Map<String, dynamic> responseJson = jsonDecode(responseString);

      UniqueCheckData uniqueCheckData = UniqueCheckData.fromJson(responseJson);

      return uniqueCheckData;
    } catch (ex) {
      throw ServerException();
    }
  }

  @override
  Future<UniqueUpData> uniqueUpRequest(String text) async {
    try {
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      HttpClientRequest request = await client
          .postUrl(Uri.http(
              MainServerData.IP, MainServerData.unauthUserApi.uniqueUpApiUrl))
          .timeout(Duration(seconds: 10));

      request.headers.set(
          HttpHeaders.contentTypeHeader, 'application/json; charset=utf-8');
      request.write(jsonEncode(text));
      HttpClientResponse response = await request.close();
      if (response.statusCode != 200) {
        throw ResponseException();
      }
      String responseString = await utf8.decoder.bind(response).join();
      Map<String, dynamic> responseJson = jsonDecode(responseString);

      UniqueUpData uniqueUpData = UniqueUpData.fromJson(responseJson);

      return uniqueUpData;
    } catch (ex) {
      throw ServerException();
    }
  }

  @override
  Future<Response> docxUniqueUpRequest(
      {FilePickerResult filePickerResult}) async {
    try {
      Dio dio = Dio();

      FormData formData = new FormData.fromMap({
        "Files": new MultipartFile.fromBytes(
            filePickerResult.files.first.bytes.toList(),
            filename: filePickerResult.names.first),
      });

      Response response = await dio
          .post(
              Uri.http(MainServerData.IP,
                      MainServerData.unauthUserApi.docxUniqueUpApiUrl)
                  .toString(),
              data: formData,
              options: Options(
                responseType: ResponseType.bytes,
              ))
          .timeout(Duration(seconds: 60));

      return response;
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<UniqueCheckData> docxUniqueCheckRequest(
      {FilePickerResult filePickerResult}) async {
    try {
      Dio dio = Dio();

      FormData formData = new FormData.fromMap({
        "Files": new MultipartFile.fromBytes(
            filePickerResult.files.first.bytes.toList(),
            filename: filePickerResult.names.first),
      });

      Response response = await dio
          .post(
              Uri.http(MainServerData.IP,
                      MainServerData.unauthUserApi.docxUniqueUpApiUrl)
                  .toString(),
              data: formData,
              options: Options(
                responseType: ResponseType.bytes,
              ))
          .timeout(Duration(seconds: 60));

      if (response.statusCode != 200) {
        throw new ResponseException();
      }

      String responseString = await utf8.decoder.bind(response.data).join();
      Map<String, dynamic> responseJson = jsonDecode(responseString);

      UniqueCheckData uniqueCheckData = UniqueCheckData.fromJson(responseJson);
      return uniqueCheckData;
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  void fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
  }
}
