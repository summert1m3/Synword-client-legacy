import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:sizer/sizer.dart';
import 'package:synword/widgets/drawerMenu/pages/functions/signOut.dart';

class AuthProfileDialog extends StatelessWidget {
  final Function _setState;

  AuthProfileDialog(
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
            Card(
              color: Colors.indigoAccent,
              child: ListTile(
                leading: GoogleUserCircleAvatar(
                  identity: GoogleAuthService.googleUser,
                  placeholderPhotoUrl: GoogleAuthService.googleUser.photoUrl,
                ),
                title: Text(GoogleAuthService.googleUser.displayName ?? '', style: TextStyle(fontSize: 15.0.sp,color: Colors.white, fontFamily: 'Roboto')),
                subtitle: Text(GoogleAuthService.googleUser.email ?? '', style: TextStyle(fontSize: 12.0.sp, color: Colors.white, fontFamily: 'Roboto')),
              ),
            ),
            SizedBox(
              height: 1.0.h,
            ),
            RaisedButton(
              color: HexColor('#E1B34F'),
              onPressed: () => signOut(context, _setState),
              child: const Text('googleSignOut', style: TextStyle(fontFamily: 'Roboto')).tr(),
            )
          ],
        ),
      ),
    );
  }
}