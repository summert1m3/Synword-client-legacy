import 'package:flutter/material.dart';
import 'dart:async';
import 'package:hexcolor/hexcolor.dart';
import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/userData/controller/authorizationController.dart';
import 'package:synword/monetization/purchase.dart';
import 'package:easy_localization/easy_localization.dart';

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
    await authorization();
    await Purchase.instance.initialize();
    Timer(Duration(seconds: 2), () => _splashScreenCallback());
  }

  Future<void> authorization() async {
    await GoogleAuthService.signInSilently();
    while(true) {
      try {
        await AuthorizationController.authorization();
        break;
      }
      catch(ex){
        print('Startup exception: $ex');
        final snackBar = SnackBar(content: Text('startupError').tr());
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        await Future.delayed(Duration(seconds: 5));
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
