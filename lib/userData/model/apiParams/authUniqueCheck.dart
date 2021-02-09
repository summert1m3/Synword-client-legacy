class AuthUniqueCheckModel {
  AuthUniqueCheckModel(this._uId,this._text);

  String _uId;
  String _text;

  Map<String, dynamic> toJson() =>
      {
        'uId': _uId,
        'text': _text,
      };
}