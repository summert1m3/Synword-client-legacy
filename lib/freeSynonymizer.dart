import 'package:synword/responseException.dart';
import 'package:synword/serverException.dart';
import 'synonymizer.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class FreeSynonymizer extends Synonymizer {
  Future<String> synonymize(String text) async {
    try {
      HttpClient client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

      HttpClientRequest request = await client.postUrl(Uri.https('194.87.146.123', '/api/freesynonymize'));

      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json; charset=utf-8');
      request.write(jsonEncode(text));
      HttpClientResponse response = await request.close();
      if (response.statusCode != 200) {
        throw ResponseException();
      }
      String responseString = await utf8.decoder.bind(response).join();

      return responseString;
    } catch (_) {
      throw ServerException();
    }
  }
}