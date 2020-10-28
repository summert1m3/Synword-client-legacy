import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() {
    return _DrawerMenuState();
  }
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width / 2.8,
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black,
        ),
        child: Drawer(
          child: ListView(
            children: <Widget>[
              SizedBox(
                  height: 5
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: (screenSize.height + screenSize.width) / 40,
                ),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: 3,
              ),
              Text('COMMERCIAL',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Audrey', fontSize: (screenSize.height + screenSize.width) / 80,
                  ),
              ),
              SizedBox(
                height: (screenSize.height + screenSize.width) / 240,
              ),
              IconButton(
                iconSize: (screenSize.height / 17 + screenSize.width / 17),
                tooltip: 'Premium',
                icon: SvgPicture.asset(
                  'icons/premium.svg',
                  semanticsLabel: 'Premium',
                ),
                onPressed: () => {},
              ),
              IconButton(
                iconSize: (screenSize.height / 17 + screenSize.width / 17),
                tooltip: 'Buy symbols',
                icon: SvgPicture.asset(
                  'icons/buy_symbols.svg',
                  semanticsLabel: 'Buy symbols',
                ),
                onPressed: () => {},
              ),
              SizedBox(
                height: (screenSize.height + screenSize.width) / 160,
              ),
              Text(
                  'SOCIAL',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Audrey', fontSize: (screenSize.height + screenSize.width) / 80,
                  ),
              ),
              SizedBox(
                height: (screenSize.height + screenSize.width) / 240,
              ),
              IconButton(
                iconSize: (screenSize.height / 17 + screenSize.width / 17),
                tooltip: 'Instagram',
                icon: Image(
                  image: AssetImage('icons/instagram.png'),
                ),
                onPressed: () => {},
              ),
              IconButton(
                iconSize: (screenSize.height / 17 + screenSize.width / 17),
                tooltip: 'VK',
                icon: Image(
                  image: AssetImage('icons/vk.png'),
                ),
                onPressed: () => {},
              ),
              SizedBox(
                height: (screenSize.height + screenSize.width) / 160,
              ),
              Text('OTHER',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Audrey', fontSize: (screenSize.height + screenSize.width)/80,
                  ),
              ),
              SizedBox(
                height: (screenSize.height + screenSize.width) / 240,
              ),
              IconButton(
                iconSize: (screenSize.height / 17 + screenSize.width / 17),
                tooltip: 'Language',
                icon: SvgPicture.asset(
                  'icons/language.svg',
                  semanticsLabel: 'Language',
                ),
                onPressed: () => {},
              ),
              IconButton(
                iconSize: (screenSize.height / 17 + screenSize.width / 17),
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
