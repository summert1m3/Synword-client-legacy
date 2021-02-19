import 'package:flutter/material.dart';
import 'dart:async';

import 'package:hexcolor/hexcolor.dart';

typedef SplashScreenCallback = void Function();

class SplashScreen extends StatefulWidget {
  final SplashScreenCallback _splashScreenCallback;

  SplashScreen(
    this._splashScreenCallback
  );

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState(_splashScreenCallback);
  }
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenCallback _splashScreenCallback;

  _SplashScreenState(
    this._splashScreenCallback
  );

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => _splashScreenCallback());
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
