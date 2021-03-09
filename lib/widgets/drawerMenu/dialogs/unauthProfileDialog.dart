import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/userData/controller/authorizationController.dart';
import 'package:sizer/sizer.dart';

class UnauthProfileDialog extends StatelessWidget {
  final Function _setState;

  UnauthProfileDialog(
    this._setState,
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: HexColor('#2B2B2B'),
      content: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 3.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('unauthProfileDialogTitle'.tr(), style: TextStyle(color: Colors.white, fontSize: 15.0.sp),),
            SizedBox(
              height: 1.0.h,
            ),
            IconButton(
              iconSize: 10.0.h,
                icon: Image(
                  image: AssetImage(
                      'icons/google_sign_in.png'
                  ),
                ),
                onPressed: () => _googleSignIn(_setState),
            )
          ],
        ),
      ),
    );
  }
}

void _googleSignIn(Function setState) async {
  //await ServerStatus.check();
  if (googleAuthService.googleUser == null) {
    await googleAuthService.signIn();
    if (googleAuthService.googleUser != null) {
      await authController.authorization();
      setState();
    }
  }
}
