import 'package:flutter/material.dart';
import 'package:wiredash/wiredash.dart';

import 'package:synword/widgets/drawerMenu/Feedback/constants.dart';
import 'package:easy_localization/easy_localization.dart';

class WiredashApp extends StatelessWidget{
  final navigatorKey;
  final Widget child;

  const WiredashApp({
    Key? key,
    required this.navigatorKey,
    required this.child,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wiredash(
        options: WiredashOptionsData(
          locale: Locale.fromSubtags(languageCode: context.locale.languageCode),
        ),
        theme: WiredashThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          secondaryColor: Colors.indigo
        ),
        projectId: projectId,
        secret: apiKey,
        navigatorKey: navigatorKey,
        child: child,
    );
  }
}