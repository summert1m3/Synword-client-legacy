import 'package:synword/userData/controller/unauthUserServerRequestsController.dart';
import 'package:synword/userData/interface/serverRequestsInterface.dart';

import 'model/userData.dart';

class CurrentUser {
  static ServerRequestsInterface serverRequest = UnauthUserServerRequestsController();
  static UserData userData = UserData();
}