import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:synword/exceptions/notEnoughCoinsException.dart';
import 'package:synword/widgets/drawerMenu/pages/coinPages/coinPage.dart';

class NotEnoughCoinsError extends StatelessWidget {
  final NotEnoughCoinsException ex;

  NotEnoughCoinsError(this.ex);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: HexColor('#262626'),
      content: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 1.8,
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 20.0.h,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  NotEnoughCoinsException.message.tr(),
                  style: TextStyle(
                      fontSize: 13.0.sp,
                      color: Colors.white,
                      fontFamily: 'Roboto'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 2.0.h,
                ),
                Card(
                    color: HexColor('#5C5C5C'),
                    child: ListTile(
                      dense: false,
                      title: Text(
                        'balance'.tr() + ' ${ex.balance}',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: 12.0.sp),
                      ),
                    )),
                Card(
                    color: HexColor('#5C5C5C'),
                    child: ListTile(
                      dense: true,
                      title: Text(
                        'price'.tr() + ' ${ex.price}',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: 12.0.sp),
                      ),
                    )),
                SizedBox(
                  height: 2.0.h,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => CoinPage())),
                  child: Text(
                    'balanceCheck'.tr(),
                    style: TextStyle(
                        fontSize: 10.0.sp,
                        color: Colors.white,
                        fontFamily: 'Roboto'),
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
