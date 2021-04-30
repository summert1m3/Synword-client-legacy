import 'package:synword/exceptions/minSymbolLimitException.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class MinSymbolLimitError extends StatelessWidget {
  final MinSymbolLimitException ex;

  MinSymbolLimitError(this.ex);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          ex.toString().tr(),
          style: TextStyle(fontSize: 13.0.sp, color: Colors.white, fontFamily: 'Roboto'),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 2.0.h,
        ),
        Text(
          ex.symbolCountMessage + ex.symbolCount.toString(),
          style: TextStyle(fontSize: 13.0.sp, color: Colors.white, fontFamily: 'Roboto'),
        ),
        SizedBox(
          height: 1.0.h,
        ),
        Text(
          ex.symbolLimitMessage + ex.symbolLimit.toString(),
          style: TextStyle(fontSize: 13.0.sp, color: Colors.white, fontFamily: 'Roboto'),
        )
      ],
    );
  }
}