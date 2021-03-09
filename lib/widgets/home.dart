import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/monetization/purchases.dart';
import 'package:synword/userData/controller/authorizationController.dart';
import 'package:synword/widgets/drawerMenu/drawerMenu.dart';
import 'package:synword/widgets/body.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:synword/widgets/documentHandle/uploadButtonWidget.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  StreamSubscription<List<PurchaseDetails>> _subscription;

  Home(){

    final Stream purchaseUpdates =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdates.listen((purchases) async {
        for (PurchaseDetails purchase in purchases) {
          if(purchase.productID != null) {
            print('NEW PURCHASE');
            await monetization.verifyAndDeliverPurchase(purchase);
            await authController.getAllUserDataFromServer(
                googleAuthService.googleAuth.accessToken);
            print('PURCHASE COMPLETED');
          }
        }
    }, onDone: () {
      _subscription.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leadingWidth: (screenSize.height / 14) + (screenSize.width / 14),
        title: Text(
          'synword',
          style: TextStyle(fontFamily: 'Waxe', fontSize: (screenSize.height / 33 + screenSize.width / 33), letterSpacing: 1.5),
        ),
        centerTitle: true,
        leading: IconButton(
          tooltip: 'Menu',
          icon: SvgPicture.asset(
            'icons/menu.svg',
            height: (screenSize.height / 61 + screenSize.width / 61),
            color: HexColor('#C70000'),
          ),
            onPressed: () => {
            _scaffoldKey.currentState.openDrawer()
            },
        ),
        actions: [
          IconButton(
            tooltip: 'Insert file',
            icon: SvgPicture.asset(
              'icons/upload_button.svg',
              height: (screenSize.height / 27 + screenSize.width / 27),
              semanticsLabel: 'Upload button',
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context){
                  return UploadFileUI();
                }
              );
            },
          ),
          SizedBox(
            width: 10,
            height: 10,
          ),
        ],
        backgroundColor: Colors.black,
      ),
      drawer: DrawerMenu(),
      body: Body(_scaffoldKey),
      backgroundColor: Colors.black,
    );
  }
}