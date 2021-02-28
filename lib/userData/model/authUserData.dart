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

  String uId;

  bool isPremium;

  int uniqueCheckMaxSymbolLimit;
  int uniqueUpMaxSymbolLimit;

  int uniqueCheckRequests;
  int uniqueUpRequests;

  int documentUniqueUpRequests;
}