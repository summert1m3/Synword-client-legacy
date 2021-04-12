import 'package:flutter/material.dart';
import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/userData/controller/authorizationController.dart';

Future<void> signOut(BuildContext context, Function setState) async{
  try {
    await GoogleAuthService.signOut();
    await AuthorizationController.authorization();

    Navigator.of(context).pop();
    setState();
  }
  catch(error){
    print(error);
  }
}