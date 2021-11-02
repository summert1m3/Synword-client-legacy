import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LocaleController {
  static late BuildContext _context;

  static void initialize(BuildContext context){
    _context = context;
  }

  static String getLangCode(){
    return _context.locale.languageCode;
  }

  static void setLangCode(String langCode){
    _context.locale = Locale(langCode);
  }

  static String getFullLangName(){
    String langCode = getLangCode();
    switch(langCode){
      case 'en': return 'English';
      case 'ru': return 'Russian';
      default: throw Exception('Invalid lang code');
    }
  }
  static String getFont(){
    String langCode = getLangCode();
    switch(langCode){
      case 'en': return 'Audrey';
      case 'ru': return 'Gardens';
      default: throw Exception('Invalid lang code');
    }
  }
}