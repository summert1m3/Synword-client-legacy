import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../dialogs/userProfileDialog.dart';
import 'package:synword/widgets/googleAuth/googleAuthService.dart';
import 'package:synword/widgets/userData/userDataController.dart';

class PremiumPage extends MaterialPageRoute<void> {
  PremiumPage()
      : super(builder: (BuildContext context) {
          final screenSize = MediaQuery.of(context).size;
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                toolbarHeight: (screenSize.height / 10 + screenSize.width / 10),
                title: SvgPicture.asset(
                  'icons/premiumPage/crown.svg',
                  height: (screenSize.height / 11 + screenSize.width / 11),
                ),
                backgroundColor: Colors.black,
                centerTitle: true,
                actions: [
                  _accountButtonVisibility(context, () {
                      setState(() {});
                      },
                  )
                ],
              ),
              body: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white,
                ),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      color: Colors.white,
                      margin:
                          EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
                      child: ListTile(
                        onTap: () => {},
                        leading: Image(
                          image: AssetImage('icons/premiumPage/first.png'),
                          color: Colors.red,
                        ),
                        title: Text('Номер один'),
                        subtitle: Text('Всегда первый в очереди'),
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30.0),
                      child: ListTile(
                        onTap: () => {},
                        leading: Image(
                          image: AssetImage('icons/premiumPage/limit.png'),
                          color: Colors.red,
                        ),
                        title: Text('Ограничения'),
                        subtitle:
                            Text('Ограничение на ввод до 50.000 символов'),
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30.0),
                      child: ListTile(
                        onTap: () => {},
                        leading: Image(
                          image: AssetImage('icons/premiumPage/file.png'),
                          color: Colors.red,
                        ),
                        title: Text('Документы'),
                        subtitle: Text(
                            'Максимум символов - 80.000 Безлимит по запросам'),
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30.0),
                      child: ListTile(
                        onTap: () => {},
                        leading: Image(
                          image: AssetImage('icons/premiumPage/free.png'),
                          color: Colors.red,
                        ),
                        title: Text('Проверка уникальности'),
                        subtitle: Text('Бесплатно 20 запросов в день'),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RaisedButton(
                      color: HexColor('#E1B34F'),
                      onPressed: () {
                        _subscribeCallback( () {
                          setState(() {});
                        });
                      },
                      child: const Text('Подписаться за 200р/месяц'),
                    ),
                  ],
                ),
              ),
            );
          });
        });
}


//4 передачи функции updateAccountIconCallback
IconButton _accountButtonVisibility(BuildContext context, Function updateAccountIconCallback) {
  if (googleAuthService.googleUser != null) {
    return IconButton(
        icon: Icon(Icons.account_circle),
        iconSize: 40,
        onPressed: () => _showUserProfileDialog(context, updateAccountIconCallback));
  } else {
    return IconButton(
        icon: Icon(Icons.account_circle),
        onPressed: null,
    );
  }
}

void _showUserProfileDialog(BuildContext context, Function updateAccountIconCallback) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return UserProfileDialog(updateAccountIconCallback);
    },
  );
}

Future<void> _subscribeCallback(Function updateAccountIconCallback) async {
  if (googleAuthService.googleUser == null) {
    await googleAuthService.signIn();
    userDataController.setAuth();
    if (googleAuthService.googleUser != null) {
      //монетизация
    }
  } else {
    //монетизация
  }
  updateAccountIconCallback();
}
