abstract class UserDataInterface {

  bool isAuthorized;

  bool isPremium;

  int uniqueCheckMaxSymbolLimit;
  int uniqueUpMaxSymbolLimit;

  int uniqueCheckRequests;
  int uniqueUpRequests;

  int documentUniqueUpRequests;
  int documentUniqueCheckRequests;
}