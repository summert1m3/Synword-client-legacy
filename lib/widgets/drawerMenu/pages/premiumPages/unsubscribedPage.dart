import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:synword/constants/googleProductId.dart';
import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/network/ServerStatus.dart';
import 'package:synword/userData/controller/authorizationController.dart';
import 'package:synword/widgets/drawerMenu/dialogs/userProfileDialog.dart';
import 'package:synword/monetization/purchases.dart';
import 'package:synword/widgets/drawerMenu/pages/premiumPages/unsubscribedListPageCard.dart';

class UnsubscribedPage extends StatelessWidget {
  static Function setState;
  static BuildContext context;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      UnsubscribedPage.setState = () => setState(() {});
      UnsubscribedPage.context = context;
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
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  UnsubscribedListPageCard(
                    imagePath: 'icons/premiumPage/first.png',
                    title: 'premiumPageFirstCardTitle',
                    subtitle: 'premiumPageFirstCardContent',
                  ),
                  UnsubscribedListPageCard(
                    imagePath: 'icons/premiumPage/limit.png',
                    title: 'premiumPageSecondCardTitle',
                    subtitle: 'premiumPageSecondCardContent',
                  ),
                  UnsubscribedListPageCard(
                    imagePath: 'icons/premiumPage/file.png',
                    title: 'premiumPageThirdCardTitle',
                    subtitle: 'premiumPageThirdCardContent',
                  ),
                  UnsubscribedListPageCard(
                    imagePath: 'icons/premiumPage/free.png',
                    title: 'premiumPageFourthCardTitle',
                    subtitle: 'premiumPageFourthCardContent',
                  ),
                  SizedBox(
                    height: (screenSize.height + screenSize.width ) / 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Builder(
                      builder: (context) => RaisedButton(
                        color: HexColor('#E1B34F'),
                        onPressed: () {
                          _subscribeCallback();
                        },
                        child: const Text('premiumPageSubscribeButton',
                                style: TextStyle(fontFamily: 'Roboto'))
                            .tr(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
    context: UnsubscribedPage.context,
    builder: (BuildContext context) {
      return UserProfileDialog(UnsubscribedPage.setState);
    },
  );
}

Future<void> _subscribeCallback() async {
  try {
    await ServerStatus.check();
    if (googleAuthService.googleUser == null) {
      await googleAuthService.signIn();
      if (googleAuthService.googleUser != null) {
        await authController.authorization();
        //монетизация
        await iap.buyNonConsumableProduct(GoogleProductId.premium);
      }
    } else {
      //монетизация
      await iap.buyNonConsumableProduct(GoogleProductId.premium);
    }
    UnsubscribedPage.setState();
  } on PlatformException catch (ex) {
    print(ex);
    final snackBar = SnackBar(
      content: Text(ex.message),
      duration: Duration(seconds: 3),
    );

    Scaffold.of(UnsubscribedPage.context).showSnackBar(snackBar);
  } catch (ex) {
    print(ex);
    final snackBar = SnackBar(
      content: Text('serverError'.tr()),
      duration: Duration(seconds: 3),
    );

    Scaffold.of(UnsubscribedPage.context).showSnackBar(snackBar);
  }
}
