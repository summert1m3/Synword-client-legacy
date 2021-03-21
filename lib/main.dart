import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:synword/Widgets/application.dart';
import 'package:easy_localization/easy_localization.dart';

void main() {
  InAppPurchaseConnection.enablePendingPurchases();

  runApp(EasyLocalization(
      child: Application(),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ],
      path: 'lang'
  )
  );
}
