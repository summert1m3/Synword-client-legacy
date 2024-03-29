import 'package:flutter/material.dart';
import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/widgets/drawerMenu/dialogs/authProfileDialog.dart';
import 'package:synword/widgets/drawerMenu/dialogs/unauthProfileDialog.dart';

class UserProfileDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserProfileDialogState();
}

class _UserProfileDialogState extends State<UserProfileDialog> {
  late Function _setUserProfileState;

  @override
  Widget build(BuildContext context) {
    _setUserProfileState = () => setState(() {});
    return
      GoogleAuthService.googleUser != null ? AuthProfileDialog(_setUserProfileState) : UnauthProfileDialog(_setUserProfileState);
  }
}