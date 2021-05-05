import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  UserData._internal();

  static final UserData _userAuthorized = UserData._internal();

  factory UserData(){
    return _userAuthorized;
  }

  late String uId;

  bool isPremium = false;

  late int uniqueCheckMaxSymbolLimit;
  late int uniqueUpMaxSymbolLimit;

  late int documentUniqueCheckMaxSymbolLimit;
  late int documentUniqueUpMaxSymbolLimit;

  late int coins;

  void fromJson(Map<String, dynamic> json) {
    if(json['isPremium'] != null) {
      isPremium = json['isPremium'] as bool;
    } else {
      isPremium = false;
    }
    if(json['documentUniqueCheckMaxSymbolLimit'] != null){
      documentUniqueCheckMaxSymbolLimit = json['documentUniqueCheckMaxSymbolLimit'] as int;
    } else {
      documentUniqueCheckMaxSymbolLimit = 0;
    }
    documentUniqueUpMaxSymbolLimit = json['documentUniqueUpMaxSymbolLimit'] as int;

    uniqueCheckMaxSymbolLimit = json['uniqueCheckMaxSymbolLimit'] as int;
    uniqueUpMaxSymbolLimit = json['uniqueUpMaxSymbolLimit'] as int;


    coins = json['coins'] as int;

    notifyListeners();
  }
}