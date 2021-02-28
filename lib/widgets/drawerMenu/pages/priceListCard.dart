import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:synword/constants/googleProductId.dart';

import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/monetization/purchases.dart';
import 'package:synword/network/ServerStatus.dart';
import 'package:synword/userData/controller/authorizationController.dart';

class PriceListCard extends StatelessWidget {
  final Icon leadingIcon;
  final String title;
  final String titleTr;
  final String subtitle;
  final String price;
  final String productId;
  final Function updateAccountIconCallback;

  PriceListCard(this.leadingIcon, this.title, this.titleTr, this.price, this.productId,
      this.updateAccountIconCallback,
      {this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
      child: ListTile(
        onTap: () => {},
        leading: leadingIcon,
        title: Text(
          title + titleTr.tr(),
          style: TextStyle(fontFamily: 'Roboto', fontSize: 17),
        ),
        subtitle: this.subtitle == null
            ? null
            : Text(subtitle,
                style: TextStyle(color: Colors.grey, fontFamily: 'Roboto')),
        dense: true,
        trailing: SizedBox(
          height: double.infinity,
          child: Builder(
            builder: (context) => RaisedButton(
              splashColor: Colors.white,
              color: Colors.red,
              onPressed: () =>
                  _subscribeCallback(updateAccountIconCallback, context, productId),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                  ),
                  Text(price,
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Roboto'))
                      .tr(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _subscribeCallback(
    Function updateAccountIconCallback, BuildContext context, String productId) async {
  try {
    await ServerStatus.check();
    if (googleAuthService.googleUser == null) {
      await googleAuthService.signIn();
      if (googleAuthService.googleUser != null) {
        await authController.authorization();
        //монетизация
        await iap.buyConsumableProduct(productId);
      }
    } else {
      //монетизация
      await iap.buyConsumableProduct(productId);
    }
    updateAccountIconCallback();
  } on PlatformException catch (ex) {
    print(ex);
    final snackBar = SnackBar(
      content: Text(ex.message),
      duration: Duration(seconds: 3),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  } catch (ex) {
    print(ex);
    final snackBar = SnackBar(
      content: Text('serverError'.tr()),
      duration: Duration(seconds: 3),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
