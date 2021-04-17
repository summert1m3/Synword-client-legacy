import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/monetization/purchases.dart';
import 'package:synword/network/ServerStatus.dart';
import 'package:synword/userData/controller/authorizationController.dart';
import 'package:sizer/sizer.dart';

class PriceListCard extends StatelessWidget {
  final Icon leadingIcon;
  final String title;
  final String titleTr;
  final String? subtitle;
  final String price;
  final String productId;

  PriceListCard(this.leadingIcon, this.title, this.titleTr, this.price, this.productId,
      {this.subtitle = ''});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(top: 3.0.h, left: 30.0, right: 30.0),
      child: ListTile(
        onTap: () => {},
        leading: leadingIcon,
        title: Text(
          title + titleTr.tr(),
          style: TextStyle(fontFamily: 'Roboto', fontSize: 13.0.sp),
        ),
        subtitle: this.subtitle == null
            ? null
            : Text(subtitle!,
                style: TextStyle(color: Colors.grey, fontFamily: 'Roboto', fontSize: 10.0.sp)),
        dense: true,
        trailing: SizedBox(
          height: double.infinity,
          child: Builder(
            builder: (context) => ButtonTheme(
              minWidth: 20.0.w,
              height: 10.0.h,
              child: RaisedButton(
                splashColor: Colors.white,
                color: Colors.red,
                onPressed: () =>
                    _subscribeCallback(context, productId),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.account_balance_wallet,
                      color: Colors.white,
                      //size: 3.0.h,
                    ),
                    Text(price,
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Roboto', fontSize: 10.0.sp))
                        .tr(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _subscribeCallback(BuildContext context, String productId) async {
  try {
    await ServerStatus.check();
    if (GoogleAuthService.googleUser == null) {
      await GoogleAuthService.signIn();
      if (GoogleAuthService.googleUser != null) {
        await AuthorizationController.authorization();
        //монетизация
        await monetization.buyConsumableProduct(productId);
      }
    } else {
      //монетизация
      await monetization.buyConsumableProduct(productId);
    }
  } on PlatformException catch (ex) {
    print(ex);
    final snackBar = SnackBar(
      content: Text(ex.message.toString()),
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
