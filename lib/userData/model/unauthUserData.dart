import '../interface/userDataInterface.dart';
import 'package:synword/constants/defaultUserRestrictions.dart';

class UnauthUserData implements UserDataInterface {

  UnauthUserData._internal(){
    isAuthorized = false;
    isPremium = false;

    uniqueCheckMaxSymbolLimit = DefaultUserRestrictions.uniqueCheckMaxSymbolLimit;
    uniqueUpMaxSymbolLimit = DefaultUserRestrictions.uniqueUpMaxSymbolLimit;

    uniqueCheckRequests = DefaultUserRestrictions.uniqueCheckRequests;
    uniqueUpRequests = DefaultUserRestrictions.uniqueUpRequests;

    documentUniqueUpRequests = DefaultUserRestrictions.documentUniqueUpRequests;
  }

  static final UnauthUserData _userUnauthorized = UnauthUserData._internal();

  factory UnauthUserData(){
    return _userUnauthorized;
  }

  bool isAuthorized;

  bool isPremium;

  int uniqueCheckMaxSymbolLimit;
  int uniqueUpMaxSymbolLimit;

  int uniqueCheckRequests;
  int uniqueUpRequests;

  int documentUniqueUpRequests;
}