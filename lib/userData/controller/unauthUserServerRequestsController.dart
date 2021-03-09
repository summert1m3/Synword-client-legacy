import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:synword/exceptions/dailyLimitReachedException.dart';
import 'dart:async';

import 'package:synword/exceptions/serverException.dart';
import 'package:synword/model/fileData.dart';
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
          MainServerData.unauthUserApi.uniqueCheckApiUrl));
      request.headers.set(
          HttpHeaders.contentTypeHeader, 'application/json; charset=utf-8');
      request.write(jsonEncode(text));

      HttpClientResponse response = await request.close();

      String responseString = await utf8.decoder.bind(response).join();

      if (response.statusCode == 400 && responseString == "dailyLimitReached") {
        throw new DailyLimitReachedException();
      }

      if (response.statusCode != 200) {
        throw new ServerException(responseString);
      }

      Map<String, dynamic> responseJson = jsonDecode(responseString);

      UniqueCheckData uniqueCheckData = UniqueCheckData.fromJson(responseJson);

      return uniqueCheckData;
    } on TimeoutException {
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
              MainServerData.IP, MainServerData.unauthUserApi.uniqueUpApiUrl));

      request.headers.set(
          HttpHeaders.contentTypeHeader, 'application/json; charset=utf-8');
      request.write(jsonEncode(text));
      HttpClientResponse response = await request.close();

      String responseString = await utf8.decoder.bind(response).join();

      if (response.statusCode == 400 && responseString == "dailyLimitReached") {
        throw new DailyLimitReachedException();
      }

      if (response.statusCode != 200) {
        throw new ServerException(responseString);
      }

      Map<String, dynamic> responseJson = jsonDecode(responseString);

      UniqueUpData uniqueUpData = UniqueUpData.fromJson(responseJson);

      return uniqueUpData;
    } on TimeoutException {
      throw ServerException();
    }
  }

  @override
  Future<Response> docxUniqueUpRequest(
      {FileData file}) async {
    try {
      Dio dio = Dio();

      FormData formData = new FormData.fromMap({
        "Files": new MultipartFile.fromBytes(
            file.bytes,
            filename: file.name),
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
          .timeout(Duration(seconds: 80));

      if (response.statusCode == 400 && response.data == "dailyLimitReached") {
        throw new DailyLimitReachedException();
      }

      if (response.statusCode != 200) {
        throw new ServerException(response.data.toString());
      }

      return response;
    } on TimeoutException {
      throw ServerException();
    }
  }

  @override
  Future<UniqueCheckData> docxUniqueCheckRequest({FileData file}) {
    // TODO: implement docxUniqueCheckRequest
    throw UnimplementedError();
  }

  @override
  void fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
  }
}
