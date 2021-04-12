import 'package:flutter/material.dart';
import 'package:synword/widgets/drawerMenu/dialogs/userProfileDialog.dart';

void showUserProfileDialog(
    BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return UserProfileDialog();
    },
  );
}