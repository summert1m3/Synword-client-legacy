import 'package:flutter/material.dart';
import 'package:synword/widgets/googleAuth/googleAuthService.dart';
import 'package:synword/widgets/userData/userDataController.dart';

class PriceListCard extends StatelessWidget {
  final Icon leadingIcon;
  final String title;
  final String subtitle;
  final String price;
  final Function updateAccountIconCallback;

  PriceListCard(
    this.leadingIcon,
    this.title,
    this.price,
    this.updateAccountIconCallback,
    {this.subtitle}
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
      child: ListTile(
        onTap: ()=>{},
        leading: leadingIcon,
        title: Text(title, style: TextStyle(fontFamily: 'Roboto',fontSize: 17),),
        subtitle: this.subtitle == null ? null : Text(subtitle, style: TextStyle(color: Colors.grey, fontFamily: 'Roboto')),
        dense: true,
        trailing: SizedBox(
          height: double.infinity,
          child: RaisedButton(
            splashColor: Colors.white,
            color: Colors.red,
            onPressed: ()=>subscribeCallback(updateAccountIconCallback),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.account_balance_wallet, color: Colors.white,),
                Text(price, style: TextStyle(color: Colors.white, fontFamily: 'Roboto')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> subscribeCallback(Function updateAccountIconCallback) async {
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

