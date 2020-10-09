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
          canvasColor: Colors.black87,
        ),
        child: Drawer(
          child: Column(
            children: <Widget>[
              SizedBox(height: 35),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              IconButton(
                iconSize: 100,
                tooltip: 'Premium',
                icon: SvgPicture.asset(
                  'icons/premium.svg',
                  semanticsLabel: 'Upload button',
                ),
                onPressed: () => {},
              ),
              InkWell(
                onTap: () => {},
                child: IconContainer(
                  iconName: 'Unlock',
                  icon: Icon(Icons.info, size: 31, color: Hexcolor('#a10000')),
                ),
              ),
              //SizedBox(height: 25),
              Material(
                //color: Colors.blue,
                child: InkWell(
                  //onTap: () => print("Container pressed"),
                  // handle your onTap here
                  child: Container(
                      height: 100,
                      width: 100,
                      //margin: EdgeInsets.all(50.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Hexcolor('#a10000'), width: 2),
                          shape: BoxShape.circle,
                      ),
                    child: InkWell(
                      onTap: ()=>{},
                    ),
                  ),
                ),
              ),

              //SizedBox(height: 25),
              IconContainer(
                iconName: 'Language',
                icon:
                    Icon(Icons.language, size: 31, color: Hexcolor('#a10000')),
              ),
              //SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
