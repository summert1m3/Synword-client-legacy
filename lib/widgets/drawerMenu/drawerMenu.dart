import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:synword/widgets/drawerMenu/iconContainer.dart';

class DrawerMenu extends StatefulWidget {
  @override
  DrawerMenuState createState() {
    return DrawerMenuState();
  }
}

class DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black,
        ),
        child: Drawer(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 5),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                width: 8,
                height: 8,
              ),
              Text('COMMERCIAL',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Audrey', fontSize: 16)),
              SizedBox(
                width: 10,
                height: 10,
              ),
              IconButton(
                iconSize: 60,
                tooltip: 'Premium',
                icon: SvgPicture.asset(
                  'icons/premium.svg',
                  semanticsLabel: 'Premium',
                ),
                onPressed: () => {},
              ),
              //SizedBox(height: 25),
              IconButton(
                iconSize: 60,
                tooltip: 'Buy symbols',
                icon: SvgPicture.asset(
                  'icons/buy_symbols.svg',
                  semanticsLabel: 'Buy symbols',
                ),
                onPressed: () => {},
              ),
              SizedBox(
                width: 15,
                height: 15,
              ),
              Text(
                  'SOCIAL',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Audrey', fontSize: 16
                  )
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              IconButton(
                iconSize: 55,
                tooltip: 'Instagram',
                icon: Image(
                  image: AssetImage('icons/instagram.png'),
                ),
                onPressed: () => {},
              ),
              IconButton(
                iconSize: 55,
                tooltip: 'VK',
                icon: Image(
                  image: AssetImage('icons/vk.png'),
                ),
                onPressed: () => {},
              ),
              SizedBox(
                width: 15,
                height: 15,
              ),
              Text('OTHER',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Audrey', fontSize: 16
                  )
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              IconButton(
                iconSize: 60,
                tooltip: 'Language',
                icon: SvgPicture.asset(
                  'icons/language.svg',
                  semanticsLabel: 'Language',
                ),
                onPressed: () => {},
              ),
              IconButton(
                iconSize: 60,
                tooltip: 'Feedback',
                icon: SvgPicture.asset(
                  'icons/feedback.svg',
                  semanticsLabel: 'Feedback',
                ),
                onPressed: () => {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
