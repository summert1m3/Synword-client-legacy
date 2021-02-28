import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/userData/controller/authorizationController.dart';
import 'package:synword/widgets/drawerMenu/dialogs/userProfileDialog.dart';

class SubscribedPage extends StatelessWidget {
  static Function setState;
  static BuildContext context;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      SubscribedPage.setState = () => setState(() {});
      SubscribedPage.context = context;
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: (screenSize.height / 10 + screenSize.width / 10),
          title: SvgPicture.asset(
            'icons/premiumPage/crown.svg',
            height: (screenSize.height / 11 + screenSize.width / 11),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          actions: [_accountButtonVisibility()],
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
          ),
          child: Center(
            child: Text('Thanks for subscribtion'),
          ),
        ),
      );
    });
  }
}

IconButton _accountButtonVisibility() {
  if (googleAuthService.googleUser != null) {
    return IconButton(
        icon: Icon(Icons.account_circle),
        iconSize: 40,
        onPressed: () => _showUserProfileDialog());
  } else {
    return IconButton(
      icon: Icon(Icons.account_circle),
      onPressed: null,
    );
  }
}

void _showUserProfileDialog() {
  showDialog(
    context: SubscribedPage.context,
    builder: (BuildContext context) {
      return UserProfileDialog(SubscribedPage.setState);
    },
  );
}
