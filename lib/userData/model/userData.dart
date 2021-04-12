import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  UserData._internal();

  static final UserData _userAuthorized = UserData._internal();

  factory UserData(){
    return _userAuthorized;
  }

  String uId;

  bool isPremium;

  int uniqueCheckMaxSymbolLimit;
  int uniqueUpMaxSymbolLimit;

  int coins;

  @override
  void fromJson(Map<String, dynamic> json) {
    if(json['isPremium'] != null) {
      isPremium = json['isPremium'] as bool;
    }
    else{
      isPremium = false;
    }
    uniqueCheckMaxSymbolLimit = json['uniqueCheckMaxSymbolLimit'] as int;
    uniqueUpMaxSymbolLimit = json['uniqueUpMaxSymbolLimit'] as int;

    coins = json['coins'] as int;

    notifyListeners();
  }
}