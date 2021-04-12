import 'package:flutter/material.dart';
import 'dart:async';
import 'package:hexcolor/hexcolor.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/userData/controller/authorizationController.dart';
import 'package:synword/monetization/purchases.dart';

class SplashScreen extends StatefulWidget {
  final Function _splashScreenCallback;

  SplashScreen(
    this._splashScreenCallback
  );

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState(_splashScreenCallback);
  }
}

class _SplashScreenState extends State<SplashScreen> {
  Function _splashScreenCallback;

  _SplashScreenState(
    this._splashScreenCallback
  );

  void _initialize() async {
    await _checkForUpdate();
    await authorization();
    monetization.initialize();
    Timer(Duration(seconds: 3), () => _splashScreenCallback());
  }

  Future<void> _checkForUpdate() async {
    AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate().catchError((error) {});

    bool updateAvailable = updateInfo != null ? updateInfo.updateAvailable : false;

    if (updateAvailable) {
      await InAppUpdate.performImmediateUpdate().catchError((error) {});
    }
  }

  Future<void> authorization() async {
    await GoogleAuthService.signInSilently();
    while(true) {
      try {
        await AuthorizationController.authorization();
        break;
      }
      catch(ex){
        print(ex);
        await Future.delayed(Duration(seconds: 5));
        print('Server unavailable');
        continue;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Image.asset(
            'icons/logo.png', scale: 7,
          ),
        ),
        backgroundColor: HexColor('#140A21'),
    );
  }
}
