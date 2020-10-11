import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:synword/Widgets/drawerMenu/iconContainer.dart';

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
          child: Column(
            children: <Widget>[
              SizedBox(height: 25),
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
                width: 15,
                height: 15,
              ),
              Text(
                'COMMERCIAL',
                //textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontFamily: 'Audrey', fontSize: 16)
              ),
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
                width: 20,
                height: 20,
              ),
              Text(
                  'SOCIAL',
                  //textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontFamily: 'Audrey', fontSize: 16)
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              IconButton(
                iconSize: 55,
                tooltip: 'VK',
                icon: Image(
                  image: AssetImage('icons/vk.png'),
                ),
                onPressed: () => {},
              ),
              IconButton(
                iconSize: 55,
                tooltip: 'VK',
                icon: Image(
                  image: AssetImage('icons/instagram.png'),
                ),
                onPressed: () => {},
              ),
              SizedBox(
                width: 20,
                height: 20,
              ),
              Text(
                  'OTHER',
                  //textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontFamily: 'Audrey', fontSize: 16)
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
