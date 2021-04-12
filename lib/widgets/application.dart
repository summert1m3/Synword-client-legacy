import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer_util.dart';
import 'package:synword/layers/layersSetting.dart';
import 'package:synword/userData/currentUser.dart';
import 'splashScreen.dart';
import 'home.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:synword/widgets/drawerMenu/Feedback/feedback.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _initializeLayersSetting(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return LayoutBuilder(                           //return LayoutBuilder
      builder: (context, constraints) {
        return OrientationBuilder(                  //return OrientationBuilder
          builder: (context, orientation) {
            SizerUtil().init(constraints, orientation);  //initialize SizerUtil
            return ChangeNotifierProvider.value(
              value: CurrentUser.userData,
              child: WiredashApp(
                navigatorKey: _navigatorKey,
                child: MaterialApp(
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  navigatorKey: _navigatorKey,
                  title: 'SynWord',
                  home: _createHome(context),
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
              ),
            );
          },
        );
      },
    );
  }
}
