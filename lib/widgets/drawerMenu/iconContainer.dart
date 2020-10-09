import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


class IconContainer extends StatelessWidget {
  final String iconName;
  final Icon icon;

  IconContainer({this.iconName, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(14),
        height: 75,
        width: 75,
        margin: EdgeInsets.all(35.0),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Hexcolor('#a10000'), width: 2)),
        child: Column(
          children: <Widget>[
            icon,
            Text(iconName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 9)),
          ],
        ));
  }
}