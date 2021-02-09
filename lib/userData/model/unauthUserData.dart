import '../interface/userDataInterface.dart';

class UnauthUserData implements UserDataInterface {

  UnauthUserData._internal(){
    isAuthorized = false;
    isPremium = false;

    uniqueCheckMinSymbolLimit = 100;
    uniqueUpMinSymbolLimit = 10;

    uniqueCheckMaxSymbolLimit = 20000;
    uniqueUpMaxSymbolLimit = 20000;

    uniqueCheckRequests = 10;
    uniqueUpRequests = 1000;
    documentUniqueUpRequests = 30;
  }

  static final UnauthUserData _userUnauthorized = UnauthUserData._internal();

  factory UnauthUserData(){
    return _userUnauthorized;
  }

  bool isAuthorized;

  bool isPremium;

  int uniqueCheckMinSymbolLimit;
  int uniqueUpMinSymbolLimit;

  int uniqueCheckMaxSymbolLimit;
  int uniqueUpMaxSymbolLimit;

  int uniqueCheckRequests;
  int uniqueUpRequests;
  int documentUniqueUpRequests;

}