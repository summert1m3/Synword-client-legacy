import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:synword/layersSetting.dart';
import 'splashScreen.dart';
import 'home.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:synword/widgets/drawerMenu/Feedback/feedback.dart';
import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/userData/Controller/authorizationController.dart';

import 'package:synword/userData/currentUser.dart';

class Application extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ApplicationState();
  }
}

class _ApplicationState extends State<Application> {
  bool isSplashScreenVisible = true;

  final _navigatorKey = GlobalKey<NavigatorState>();

  Widget _createHome() {
    _googleSignInSilently();
    _initializeUserData();
    if (isSplashScreenVisible) {
      return SplashScreen(
        () {
         setState(() {
           isSplashScreenVisible = false;
         });
        }
      );
    } else {
      return Home();
    }
  }

  void _initializeLayersSetting(BuildContext context) {
    layersSetting = LayersSetting.initialize(70, 13, Colors.red, HexColor('#FCFD64'), HexColor('#FCFD64'), 130, 130);
  }
  void _googleSignInSilently(){
    googleAuthService.signInSilently();
  }
  void _initializeUserData() async{
    AuthorizationController authController = AuthorizationController();

    if(googleAuthService.googleUser != null){
      try{
        authController.setAuth();
      }catch(ex){
        authController.setUnauth();
      }
    }
    else{
      authController.setUnauth();
    }
    CurrentUser user = CurrentUser();
    print(user.serverRequest);
    print(user.userData);
  }

  @override
  Widget build(BuildContext context) {
    _initializeLayersSetting(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return WiredashApp(
      navigatorKey: _navigatorKey,
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        navigatorKey: _navigatorKey,
        title: 'SynWord',
        home: _createHome(),
        builder: (context,navigator){
          var lang = EasyLocalization.of(context).locale.languageCode;
          return Theme(
            data: ThemeData(
                fontFamily: lang == 'ru' ? 'Gardens' : 'Audrey'
            ),
            child: navigator,
          );
        },
      ),
    );
  }
}
