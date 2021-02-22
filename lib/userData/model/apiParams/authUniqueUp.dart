class AuthUniqueUpModel {
  AuthUniqueUpModel(this._accessToken,this._text);

  String _accessToken;
  String _text;

  Map<String, dynamic> toJson() =>
      {
        'accessToken': _accessToken,
        'text': _text,
      };
}