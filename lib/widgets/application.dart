import 'package:flutter/material.dart';
import 'package:synword/layersSetting.dart';
import 'splashScreen.dart';
import 'home.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';

class Application extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ApplicationState();
  }
}

class _ApplicationState extends State<Application> {
  bool isSplashScreenVisible = true;

  Widget _createHome() {
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

  @override
  Widget build(BuildContext context) {
    _initializeLayersSetting(context);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'SynWord',
      home: _createHome(),
    );
  }
}
