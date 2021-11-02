import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import 'package:synword/Widgets/application.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:synword/admob/adState.dart';
import 'package:synword/userData/currentUser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  InAppPurchaseConnection.enablePendingPurchases();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: CurrentUser.userData,
        ),
        Provider.value(
          value: adState,
        ),
      ],
      child: EasyLocalization(
        useOnlyLangCode: true,
        supportedLocales: [
          Locale('en'),
          Locale('ru'),
        ],
        path: 'lang',
        fallbackLocale: Locale('en'),
        child: Application(),
      ),
    ),
  );
}
