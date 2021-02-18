import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/userData/controller/authorizationController.dart';

typedef UpdateAccountIconCallback = void Function();

class UserProfileDialog extends StatelessWidget {
  final UpdateAccountIconCallback _updateAccountIconCallback;

  UserProfileDialog(
      this._updateAccountIconCallback
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: HexColor('#262626'),
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
                  identity: googleAuthService.googleUser,
                  placeholderPhotoUrl: googleAuthService.googleUser.photoUrl,
                ),
                title: Text(googleAuthService.googleUser.displayName ?? '', style: TextStyle(color: Colors.white, fontFamily: 'Roboto')),
                subtitle: Text(googleAuthService.googleUser.email ?? '', style: TextStyle(color: Colors.white, fontFamily: 'Roboto')),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              color: HexColor('#E1B34F'),
              onPressed: () => _signOutCallback(context, updateAccountIconCallback: _updateAccountIconCallback),
              child: const Text('googleSignOut', style: TextStyle(fontFamily: 'Roboto')).tr(),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> _signOutCallback(BuildContext context, {Function updateAccountIconCallback}) async{
  try {
    AuthorizationController user = AuthorizationController();

    await googleAuthService.signOut();
    await user.authorization();

    Navigator.of(context).pop();
    updateAccountIconCallback();
  }
  catch(error){
    print(error);
  }
}

void showUserProfileDialog(BuildContext context, Function updateAccountIconCallback) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return UserProfileDialog(updateAccountIconCallback);
    },
  );
}