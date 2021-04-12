import 'package:http/http.dart' as http;

import 'package:synword/constants/mainServerData.dart';
import 'package:synword/exceptions/serverException.dart';

class ServerStatus {
  static Future<void> check() async {
    try {
      await http
          .get(MainServerData.url)
          .timeout(Duration(seconds: 3));
    } catch (_) {
      print('SeverStatus: offline');
      throw ServerException();
    }
  }
}
