import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:synword/language/localeController.dart';
import 'package:synword/layers/layersSetting.dart';
import 'splashScreen.dart';
import 'home.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:synword/widgets/drawerMenu/feedback/wiredash_feedback.dart';

class Application extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ApplicationState();
  }
}

class _ApplicationState extends State<Application> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  bool isSplashScreenVisible = true;

  Widget _createHome(BuildContext context) {
    if (isSplashScreenVisible) {
      return SplashScreen(() {
        setState(() {
          isSplashScreenVisible = false;
        });
      });
    } else {
      return Home();
    }
  }

  void _initializeLayersSetting(BuildContext context) {
    layersSetting = LayersSetting.initialize(
        70, 13, Colors.red, HexColor('#FCFD64'), HexColor('#FCFD64'), 130, 130);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _initializeLayersSetting(context);
    LocaleController.initialize(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Sizer(
      builder: (context, orientation, screenType) {
        return WiredashApp(
          navigatorKey: _navigatorKey,
          child: MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            navigatorKey: _navigatorKey,
            title: 'Synword',
            home: _createHome(context),
            builder: (context, navigator) {
              return Theme(
                data: ThemeData(fontFamily: LocaleController.getFont()),
                child: navigator!,
              );
            },
          ),
        );
      },
    );
  }
}
