import '../interface/userDataInterface.dart';

class AuthUserData implements UserDataInterface{
  AuthUserData._internal(){
    isAuthorized = true;
  }

  static final AuthUserData _userAuthorized = AuthUserData._internal();

  factory AuthUserData(){
    return _userAuthorized;
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