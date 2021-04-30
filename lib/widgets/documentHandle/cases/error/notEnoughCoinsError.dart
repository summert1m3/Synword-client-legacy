import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:synword/exceptions/notEnoughCoinsException.dart';
import 'package:synword/widgets/drawerMenu/pages/coinPages/coinPage.dart';

class NotEnoughCoinsError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          NotEnoughCoinsException.message.tr(),
          style: TextStyle(fontSize: 13.0.sp, color: Colors.white, fontFamily: 'Roboto'),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 2.0.h,
        ),
        ElevatedButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CoinPage())),
            child: Text(
              'balanceCheck'.tr(),
              style: TextStyle(fontSize: 10.0.sp, color: Colors.white, fontFamily: 'Roboto'),
            ),
        ),
      ],
    );
  }
}