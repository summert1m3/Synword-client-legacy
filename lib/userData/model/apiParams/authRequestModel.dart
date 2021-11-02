class AuthRequestModel {
  AuthRequestModel(this._uId,this._text);

  String _uId;
  String _text;

  Map<String, dynamic> toJson() =>
      {
        'accessToken': _uId,
        'text': _text,
      };
}