import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:synword/constants/googleProductId.dart';
import 'package:synword/widgets/drawerMenu/pages/functions/showUserProfileDialog.dart';
import 'priceListCard.dart';

class BuyPage extends MaterialPageRoute<void> {
  BuyPage()
      : super(builder: (BuildContext context) {
          final screenSize = MediaQuery.of(context).size;

          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                toolbarHeight: (screenSize.height / 10 + screenSize.width / 10),
                title: Icon(
                  Icons.shopping_cart,
                  size: (screenSize.height / 11 + screenSize.width / 11),
                ),
                backgroundColor: Colors.black,
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: Icon(Icons.account_circle),
                    iconSize: 40,
                    onPressed: () => showUserProfileDialog(context),
                  )
                ],
              ),
              body: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Text('priceListPageTitle',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto'))
                        .tr(),
                    SizedBox(
                      height: 10,
                    ),
                    PriceListCard(
                        Icon(Icons.account_balance),
                        '100 ',
                        'priceListPageUniqueCheckCardContent',
                        'priceListPageFirstCardPrice',
                        GoogleProductId.coins_100,
                    ),
                    PriceListCard(
                      Icon(Icons.account_balance),
                      '300 ',
                      'priceListPageUniqueCheckCardContent',
                      'priceListPageSecondCardPrice',
                      GoogleProductId.coins_300,
                      subtitle: '10% save',
                    ),
                    PriceListCard(
                      Icon(Icons.account_balance),
                      '600 ',
                      'priceListPageUniqueCheckCardContent',
                      'priceListPageThirdCardPrice',
                      GoogleProductId.coins_600,
                      subtitle: '15% save',
                    ),
                    PriceListCard(
                      Icon(Icons.account_balance),
                      '1000 ',
                      'priceListPageUniqueCheckCardContent',
                      'priceListPageFourthCardPrice',
                      GoogleProductId.coins_1000,
                      subtitle: '20% save',
                    ),
                  ],
                ),
              ),
            );
          });
        });
}
