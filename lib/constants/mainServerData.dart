class MainServerData {
  static const String _protocol = "http://";
  static const String _IP = "";
  static const String url = _protocol + _IP;
  static UnauthUserApi unauthUserApi = UnauthUserApi();
  static AuthUserApi authUserApi = AuthUserApi();
}

class UnauthUserApi {
  String _uniqueCheckApiUrl = MainServerData.url + "/api/UniqueCheck";
  String _uniqueUpApiUrl = MainServerData.url + "/api/FreeSynonymize";

  String _docxUniqueUpApiUrl = MainServerData.url + "/api/DocxUniqueUp";

  String _getAllUserData = MainServerData.url + "/api/Authorization";
  String _registration = MainServerData.url + "/api/Registration";

  String get uniqueCheckApiUrl => _uniqueCheckApiUrl;
  String get uniqueUpApiUrl => _uniqueUpApiUrl;
  String get docxUniqueUpApiUrl => _docxUniqueUpApiUrl;
  String get getAllUserData => _getAllUserData;
  String get registration => _registration;
}

class AuthUserApi {
  String _uniqueCheckApiUrl = MainServerData.url + "/api/UniqueCheck/auth";
  String _uniqueUpApiUrl = MainServerData.url + "/api/FreeSynonymize/auth";

  String _docxUniqueCheckApiUrl = MainServerData.url + "/api/DocxUniqueCheck/auth";
  String _docxUniqueUpApiUrl = MainServerData.url + "/api/DocxUniqueUp/auth";

  String _getAllUserData = MainServerData.url + "/api/Authorization/auth";
  String _purchaseVerification = MainServerData.url + "/api/PurchaseVerification";
  String _registration = MainServerData.url + "/api/Registration/auth";

  String get uniqueCheckApiUrl => _uniqueCheckApiUrl;
  String get uniqueUpApiUrl => _uniqueUpApiUrl;
  String get docxUniqueCheckApiUrl => _docxUniqueCheckApiUrl;
  String get docxUniqueUpApiUrl => _docxUniqueUpApiUrl;
  String get getAllUserData => _getAllUserData;
  String get purchaseVerification => _purchaseVerification;
  String get registration => _registration;
}
