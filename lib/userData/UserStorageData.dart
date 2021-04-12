import 'dart:io';
import 'package:path_provider/path_provider.dart';

class UserStorageData {
  static String _tokenFileName = 'token.txt';
  static String _authUserRegistrationDataFileName = 'authUserRegistered.txt';
  static String _unauthUserRegistrationDataFileName = 'unauthUserRegistered.txt';

  static Future<String> getToken() async {
    Directory docDir = await getExternalStorageDirectory();
    String filePath = docDir.path + '/' + _tokenFileName;

    var file = File(filePath);

    String contents = await file.readAsString();
    print('TOKEN:' + contents);
    return contents;
  }

  static Future<bool> isAuthUserRegistered() async {
    Directory docDir = await getExternalStorageDirectory();
    String filePath = docDir.path + '/' + _authUserRegistrationDataFileName;
    return File(filePath).existsSync();
  }
  static Future<bool> isUnauthUserRegistered() async {
    Directory docDir = await getExternalStorageDirectory();
    String filePath = docDir.path + '/' + _unauthUserRegistrationDataFileName;
    return File(filePath).existsSync();
  }

  static Future<bool> isTokenExist() async {
    Directory docDir = await getExternalStorageDirectory();
    String docPath = docDir.path;
    String filePath = docPath + '/' + _tokenFileName;
    return File(filePath).existsSync();
  }

  static Future<void> setToken(String token) async {
    Directory docDir = await getExternalStorageDirectory();
    String filePath = docDir.path + '/' + _tokenFileName;

    var file = File(filePath);
    file.writeAsString(token);
  }

  static Future<void> setAuthUserRegistered() async {
    Directory docDir = await getExternalStorageDirectory();
    String filePath = docDir.path + '/' + _authUserRegistrationDataFileName;

    var file = File(filePath);
    file.create();
  }

  static Future<void> setUnauthUserRegistered() async {
    Directory docDir = await getExternalStorageDirectory();
    String filePath = docDir.path + '/' + _unauthUserRegistrationDataFileName;

    var file = File(filePath);
    file.create();
  }
}