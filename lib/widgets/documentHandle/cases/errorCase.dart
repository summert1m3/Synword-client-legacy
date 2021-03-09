import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class ErrorCase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: HexColor('#262626'),
      content: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 2.5,
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
              Text(
                'Ошибка',
                style: TextStyle(fontSize: 15.0.sp, color: Colors.white),
              ),
              Text(
                'Повторите попытку позже',
                style: TextStyle(fontSize: 10.0.sp, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
