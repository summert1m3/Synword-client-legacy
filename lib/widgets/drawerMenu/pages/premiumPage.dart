import 'package:flutter/material.dart';
import 'package:synword/userData/currentUser.dart';
import 'package:synword/widgets/drawerMenu/pages/premiumPages/subscribedPage.dart';
import 'package:synword/widgets/drawerMenu/pages/premiumPages/unsubscribedPage.dart';

class PremiumPage extends MaterialPageRoute<void> {
  static Function premuimPageSetState;

  PremiumPage()
      : super(builder: (BuildContext context) {
          final screenSize = MediaQuery.of(context).size;
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                premuimPageSetState = () => setState(() {});
            return Scaffold(
              body: currentUser.userData.isPremium
                  ? SubscribedPage()
                  : UnsubscribedPage(),
            );
          });
        });
}
