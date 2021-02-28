import 'package:http/http.dart' as http;

import 'package:synword/constants/mainServerData.dart';
import 'package:synword/exceptions/serverException.dart';

class ServerStatus{
  static Future<void> check() async{
    try {
      var response = await http.get(MainServerData.protocol + MainServerData.IP)
          .timeout(Duration(seconds: 2));
    }
    catch(_){
      print('SeverStatus: offline');
      throw ServerException();
    }
  }
}