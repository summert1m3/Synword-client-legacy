import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/userData/model/userData.dart';
import 'package:synword/widgets/drawerMenu/pages/coinPages/coinPriceListPage.dart';
import 'package:synword/widgets/drawerMenu/pages/ad/rewardedAdPage.dart';
import '../functions/showUserProfileDialog.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class CoinPageQuestion extends StatefulWidget {
  final String _title;
  final String _svgPath;
  final List<CoinPageQuestionItem> _items;

  CoinPageQuestion(this._title, this._svgPath, this._items);

  @override
  State<StatefulWidget> createState() {
    return _CoinPageQuestionState(_title, _svgPath, _items);
  }
}

class _CoinPageQuestionState extends State<CoinPageQuestion> {
  final _title;
  final _svgPath;
  final List<CoinPageQuestionItem> _items;
  bool _isItemsShow = false;

  _CoinPageQuestionState(this._title, this._svgPath, this._items);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black.withOpacity(0.4), width: 1)),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          GestureDetector(
            onTapUp: (details) {
              setState(() {
                _isItemsShow = !_isItemsShow;
              });
            },
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 15),
                  child: SvgPicture.asset(_svgPath,
                      semanticsLabel: 'Question mark',
                      height: 5.0.h,
                      width: 5.0.w),
                ),
                Expanded(
                  child: Text(_title,
                      style:
                          TextStyle(fontFamily: 'Roboto', fontSize: 13.0.sp)),
                ),
                Icon(!_isItemsShow
                    ? Icons.keyboard_arrow_down_outlined
                    : Icons.keyboard_arrow_up)
              ],
            ),
          ),
          Padding(
            padding: _isItemsShow
                ? const EdgeInsets.only(top: 10)
                : const EdgeInsets.only(),
            child: AnimatedCrossFade(
              firstChild: Container(),
              secondChild: Column(
                children: _items,
              ),
              crossFadeState: _isItemsShow
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: Duration(milliseconds: 200),
            ),
          )
        ],
      ),
    );
  }
}

class CoinPageQuestionItem extends StatelessWidget {
  final String _title;

  CoinPageQuestionItem(this._title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 15),
            child: SvgPicture.asset('icons/question_mark.svg',
                semanticsLabel: 'Question mark', height: 4.0.h, width: 4.0.w),
          ),
          Flexible(
            child: Text(_title,
                style: TextStyle(fontFamily: 'Roboto', fontSize: 13.0.sp)),
          )
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black.withOpacity(0.4), width: 1)),
      width: MediaQuery.of(context).size.width,
    );
  }
}

class CoinPageButton extends StatelessWidget {
  final String _title;
  final Color _titleColor;
  final Color _color;
  final Function _onPress;

  CoinPageButton(this._title, this._titleColor, this._color, this._onPress);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        width: 23.0.w,
        height: 6.5.h,
        child: Center(
          child: Text(_title,
              style: TextStyle(
                  fontSize: 11.5.sp, fontFamily: 'Roboto', color: _titleColor)),
        ),
      ),
      onPressed: () {
        _onPress();
      },
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(_color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.black, width: 1)))),
    );
  }
}

class CoinPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CoinPageState();
  }
}

class _CoinPageState extends State<CoinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 16.0.h,
          title: SvgPicture.asset('icons/bag_of_coins.svg',
              semanticsLabel: 'Bag of coins',
              color: Colors.white,
              height: 15.5.h,
              width: 15.5.w),
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
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.4),
                                  width: 1)),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Consumer<UserData>(
                                    builder: (context, data, child) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Text(data.coins.toString(),
                                        style: TextStyle(
                                            fontSize: 25.0.sp,
                                            fontFamily: 'Roboto',
                                            color:
                                                Colors.black.withOpacity(0.8))),
                                  );
                                }),
                                SvgPicture.asset('icons/coins.svg',
                                    semanticsLabel: 'Premium',
                                    height: 8.0.h,
                                    width: 8.0.h)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CoinPageQuestion(
                                  'coinPageGeneralInfo'.tr(),
                                  'icons/coin.svg',
                                  {
                                    CoinPageQuestionItem(
                                        'coinPageGeneralInfoFirst'.tr()),
                                    CoinPageQuestionItem(
                                        'coinPageGeneralInfoSecond'.tr(
                                            namedArgs: {'coin_count': '30'})),
                                    CoinPageQuestionItem(
                                        'coinPageGeneralInfoThird'.tr(
                                            namedArgs: {'coin_count': '30'})),
                                    CoinPageQuestionItem(
                                        'coinPageGeneralInfoFourth'
                                            .tr(namedArgs: {'coin_count': '2'}))
                                  }.toList()),
                              CoinPageQuestion(
                                  'coinPageServiceCost'.tr(),
                                  'icons/request_coin_cost.svg',
                                  {
                                    CoinPageQuestionItem(
                                        'coinPageServiceCostFirst'.tr(
                                            namedArgs: {'coin_count': '1'})),
                                    CoinPageQuestionItem(
                                        'coinPageServiceCostSecond'.tr(
                                            namedArgs: {'coin_count': '3'})),
                                  }.toList())
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: CoinPageButton(
                                  'earn'.tr(),
                                  Colors.white,
                                  Colors.red,
                                  () {
                                    /*
                                    if (GoogleAuthService.googleUser != null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RewardedAdPage()));
                                    } else {
                                      showUserProfileDialog(context);
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
                                  },
                                ),
                              ),
                              CoinPageButton(
                                  'buy'.tr(),
                                  Colors.black.withOpacity(0.8),
                                  Colors.amberAccent, () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CoinPriceListPage()));
                              })
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
