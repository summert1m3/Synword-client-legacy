import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LangCode{
  String ru = 'ru';
  String en = 'en';
}

class CountryCode{
  String us = 'US';
  String ru = 'RU';
}

class LangDialog extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _LangDialogState();
}

class _LangDialogState extends State<LangDialog> {
  String langCode;
  
  void setSelectedRadio(String val){
    setState(() {
      langCode = val;
    });
  }

  void changeLang(String langCode, String countryCode){
    setState(() {
      EasyLocalization.of(context).locale = Locale(langCode,countryCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    langCode = EasyLocalization.of(context).locale.languageCode;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: HexColor('#262626'),
      content: Container(
        width: MediaQuery.of(context).size.width / 3.2,
        height: MediaQuery.of(context).size.height / 3.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: (screenSize.width + screenSize.height) / 300),
                color: HexColor('#4D4D4D'),
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: (screenSize.width + screenSize.height) / 90),
                  title: Text('English', style: TextStyle(color: Colors.white, fontFamily: 'Gardens', fontSize: (screenSize.width + screenSize.height) / 53)),
                  leading: SvgPicture.asset(
                    'icons/united-states.svg',
                    width: (screenSize.height / 30 + screenSize.width / 30),
                  ),
                  trailing: Radio<String>(
                    value: 'en',
                    groupValue: langCode,
                    onChanged: (val){
                      changeLang('en', 'US');
                    },
                  ),
                  onTap: () => changeLang('en', 'US'),
                ),
              ),
              SizedBox(
                height: 10
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: (screenSize.width + screenSize.height) / 300),
                color: HexColor('#4D4D4D'),
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: (screenSize.width + screenSize.height) / 90),
                  title: Text('Русский', style: TextStyle(color: Colors.white, fontFamily: 'Gardens', fontSize: (screenSize.width + screenSize.height) / 53)),
                  leading: SvgPicture.asset(
                    'icons/russia.svg',
                    width: (screenSize.height / 30 + screenSize.width / 30),
                  ),
                  trailing: Radio<String>(
                    value: 'ru',
                    groupValue: langCode,
                    onChanged: (val){
                      changeLang('ru', 'RU');
                    },
                  ),
                  onTap: () => changeLang('ru', 'RU'),
                ),
              )
            ],
          ),
      ),
    );
  }
}