import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class DefaultError extends StatelessWidget {
  final Object ex;
  DefaultError(this.ex);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'alertDialogError'.tr(),
          style: TextStyle(fontSize: 15.0.sp, color: Colors.white),
        ),
        Text(
          ex.toString(),
          style: TextStyle(fontSize: 10.0.sp, color: Colors.white),
        )
      ],
    );
  }
}
