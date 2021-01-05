import 'package:synword/uniqueCheckData.dart';

abstract class UserDataInterface {

  bool isAuthorized;

  bool isPremium;

  int uniqueCheckMinSymbolLimit;
  int uniqueUpMinSymbolLimit;

  int uniqueCheckMaxSymbolLimit;
  int uniqueUpMaxSymbolLimit;

  int uniqueCheckRequests;
  int uniqueUpRequests;
  int documentUniqueUpRequests;

  Future<String> uniqueUpRequest(String text);
  Future<UniqueCheckData> uniqueCheckRequest(String text);

  void fromJson(Map<String, dynamic> json);
}