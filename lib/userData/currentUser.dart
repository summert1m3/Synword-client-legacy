import 'package:synword/userData/interface/serverRequestsInterface.dart';
import 'package:synword/userData/interface/userDataInterface.dart';

class CurrentUser {
  static final CurrentUser _currentUser = CurrentUser._internal();
  factory CurrentUser(){
    return _currentUser;
  }
  CurrentUser._internal();

  ServerRequestsInterface serverRequest;
  UserDataInterface userData;
}