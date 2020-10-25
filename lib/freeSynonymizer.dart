import 'synonymizer.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class FreeSynonymizer extends Synonymizer {
  Future<String> synonymize(String text) async {
    HttpClient client = HttpClient();
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

    Map<String, String> message = {
      'Message' : text
    };

    HttpClientRequest request = await client.postUrl(Uri.https('10.0.2.2:5001', '/synonymizetest/PostTest'));
    request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    request.write(jsonEncode(message));

    HttpClientResponse response = await request.close();

    Completer<String> completer = Completer<String>();
    StringBuffer buffer = StringBuffer();

    response.transform(utf8.decoder).listen((data) {
      buffer.write(data);
    }, onDone: () => completer.complete(buffer.toString()));

    return completer.future;
  }
}