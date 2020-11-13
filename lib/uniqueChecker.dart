import 'package:synword/responseException.dart';
import 'package:synword/serverException.dart';
import 'package:synword/uniqueCheckData.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class UniqueChecker {
  Future<UniqueCheckData> check(String text) async {
    try {
      HttpClient client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

      HttpClientRequest request = await client.postUrl(Uri.https('10.0.2.2:5001', '/api/uniquecheck'));
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json; charset=utf-8');
      request.write(jsonEncode(text));

      HttpClientResponse response = await request.close();

      if (response.statusCode != 200) {
        throw new ResponseException();
      }

      String responseString = await utf8.decoder.bind(response).join();
      Map<String, dynamic> responseJson = jsonDecode(responseString);

      UniqueCheckData uniqueCheckData = UniqueCheckData.fromJson(responseJson);

      return uniqueCheckData;
    } catch (_) {
      throw new ServerException();
    }
  }
}