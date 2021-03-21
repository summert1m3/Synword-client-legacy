import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';

class CoinPriceListItem extends StatelessWidget {
  final String _title;
  final String _titleTr;
  final String _cost;
  final String _costTr;
  final String _subtitle;
  final Function _onTapCallback;

  CoinPriceListItem({
     String title, String cost, String subtitle, String titleTr, String costTr, Function onTap
  }) : _title = title ?? '', _cost = cost ?? '', _subtitle = subtitle ?? '', _titleTr = titleTr ?? '', _onTapCallback = onTap ?? (() {}), _costTr = costTr ?? '';

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
            child: SvgPicture.asset(
                'icons/coin_cost_page.svg',
                semanticsLabel: 'Premium',
                height: 6.0.h,
                width: 6.0.h,
                color: Colors.black.withOpacity(0.6),
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
                onTap: () {
                  _onTapCallback();
                },
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
                        child: Text(_cost.tr(), style: TextStyle(fontFamily: 'Roboto', fontSize: 13.0.sp, color: Colors.white)),
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
        title: SvgPicture.asset(
            'icons/hand_and_coins.svg',
            semanticsLabel: 'Bag of coins',
            color: Colors.white,
            height: 15.5.h,
            width: 15.5.w
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
                        title: '20',
                        titleTr: 'coins',
                        cost: 'priceListPageFirstCardPrice'
                      ),
                      CoinPriceListItem(
                        title: '50',
                        titleTr: 'coins',
                        cost: 'priceListPageSecondCardPrice',
                        subtitle: '10%' + ' ' + 'priceListSave'.tr(),
                      ),
                      CoinPriceListItem(
                        title: '150',
                        titleTr: 'coins',
                        cost: 'priceListPageThirdCardPrice',
                        subtitle: '15%' + ' ' + 'priceListSave'.tr(),
                      ),
                      CoinPriceListItem(
                        title: '250',
                        titleTr: 'coins',
                        cost: 'priceListPageFourthCardPrice',
                        subtitle: '25%' + ' ' + 'priceListSave'.tr(),
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
