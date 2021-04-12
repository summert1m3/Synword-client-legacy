import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synword/userData/model/userData.dart';
import 'package:synword/widgets/drawerMenu/pages/premiumPages/subscribedPage.dart';
import 'package:synword/widgets/drawerMenu/pages/premiumPages/unsubscribedPage.dart';

class PremiumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Consumer<UserData>(
        builder: (context, data, child) {
          return Scaffold(
            body: data.isPremium
                ? SubscribedPage()
                : UnsubscribedPage(),
          );
        }
      );
  }
}
