import 'package:flutter/material.dart';
import 'splashScreen.dart';
import 'home.dart';

class Application extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ApplicationState();
  }
}

class _ApplicationState extends State<Application> {
  bool isSplashScreenVisible = true;

  Widget createHome() {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SynWord',
      home: createHome(),
    );
  }
}
