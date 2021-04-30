import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:synword/constants/googleProductId.dart';
import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/monetization/purchase.dart';
import 'package:synword/network/ServerStatus.dart';
import 'package:synword/widgets/drawerMenu/pages/functions/showUserProfileDialog.dart';

class CoinPriceListItem extends StatelessWidget {
  final String _title;
  final String _titleTr;
  final String _subtitle;
  final ProductDetails _product;

  CoinPriceListItem({
    required String title, String? subtitle, required String titleTr, required ProductDetails product
  }) : _title = title, _subtitle = subtitle ?? '', _titleTr = titleTr, _product = product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 1,
          color: Colors.black.withOpacity(0.6)
        )
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 25),
            child: Image.asset(
                'icons/coinPage/coin_cost_page.png',
                height: 6.0.h,
                width: 6.0.h,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(_title + ' ' + _titleTr.tr(), style: TextStyle(fontFamily: 'Roboto', fontSize: 15.0.sp, color: Colors.black.withOpacity(0.8))),
                ),
                _subtitle.isNotEmpty ? Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(_subtitle, style: TextStyle(fontFamily: 'Roboto', fontSize: 13.0.sp, color: Colors.black.withOpacity(0.8))),
                ) : Container()
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.red,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.amberAccent,
                highlightColor: Colors.amberAccent.withOpacity(0.5),
                onTap: () => _purchaseProduct(context, _product.id),
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
                  child: Column(
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        size: 3.5.h,
                        color: Colors.white,
                      ),
                      Container(
                        child: Text(_product.price, style: TextStyle(fontFamily: 'Roboto', fontSize: 12.0.sp, color: Colors.white)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CoinPriceListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 16.0.h,
        title: Image.asset(
          'icons/coinPage/treasure_chest.png',
          height: 20.0.h,
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(top: 10, left: 45, right: 45),
                  child: Column(
                    children: [
                      CoinPriceListItem(
                        title: '100',
                        titleTr: 'coins',
                        product: Purchase.instance.getProduct(GoogleProductId.coins_100),
                      ),
                      CoinPriceListItem(
                        title: '300',
                        titleTr: 'coins',
                        product: Purchase.instance.getProduct(GoogleProductId.coins_300),
                      ),
                      CoinPriceListItem(
                        title: '600',
                        titleTr: 'coins',
                        product: Purchase.instance.getProduct(GoogleProductId.coins_600),
                      ),
                      CoinPriceListItem(
                        title: '1000',
                        titleTr: 'coins',
                        product: Purchase.instance.getProduct(GoogleProductId.coins_1000),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> _purchaseProduct(BuildContext context, String productId) async {
  try {
    await ServerStatus.check();
    if(GoogleAuthService.googleUser == null) {
      showUserProfileDialog(context);
    }
    else{
      await Purchase.instance.buyConsumableProduct(productId);
    }
  } catch (ex) {
    print(ex);
    final snackBar = SnackBar(
      content: Text(ex.toString()),
      duration: Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
