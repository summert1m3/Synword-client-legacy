import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:synword/constants/googleProductId.dart';
import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/network/ServerStatus.dart';
import 'package:synword/monetization/purchase.dart';
import 'package:synword/widgets/drawerMenu/pages/functions/showUserProfileDialog.dart';
import 'package:synword/widgets/drawerMenu/pages/premiumPages/unsubscribedListPageCard.dart';

class UnsubscribedPage extends StatelessWidget {
  static late Function setState;
  static late BuildContext context;

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
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle),
              iconSize: 40,
              onPressed: () => showUserProfileDialog(context),
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
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
                      height: (screenSize.height + screenSize.width) / 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Builder(
                        builder: (context) => RaisedButton(
                          color: HexColor('#E1B34F'),
                          onPressed: () {
                            _subscribeCallback(context);
                          },
                          child: const Text('premiumPageSubscribeButton',
                                  style: TextStyle(fontFamily: 'Roboto'))
                              .tr(namedArgs: {
                            'price': Purchase.instance
                                .getProduct(GoogleProductId.premium)
                                .price
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

Future<void> _subscribeCallback(BuildContext context) async {
  /*
  try {
    await ServerStatus.check();
    if(GoogleAuthService.googleUser == null) {
      showUserProfileDialog(context);
    }
    else{
      await Purchase.instance.buyNonConsumableProduct(GoogleProductId.premium);
      UnsubscribedPage.setState();
    }
  } catch (ex) {
    print(ex);
    final snackBar = SnackBar(
      content: Text(ex.toString()),
      duration: Duration(seconds: 5),
    );
    ScaffoldMessenger.of(UnsubscribedPage.context).showSnackBar(snackBar);
  }
  */

  AwesomeDialog(
          context: context,
          dialogType: DialogType.INFO,
          animType: AnimType.LEFTSLIDE,
          title: 'alertDialogError'.tr(),
          desc: 'functionNotAvailable'.tr(),
          btnCancelOnPress: () {},
          btnCancelText: 'Ок')
      .show();
}
