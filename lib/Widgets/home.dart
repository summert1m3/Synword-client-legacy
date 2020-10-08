import 'package:flutter/material.dart';
import 'package:synword/widgets/drawerMenu/drawerMenu.dart';
import 'package:synword/widgets/body.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'synword',
          style: TextStyle(fontFamily: 'Waxe', fontSize: 33, letterSpacing: 1.5),
        ),
        centerTitle: true,
        leading: IconButton(
          tooltip: 'Menu',
          icon: Icon(Icons.menu, color: Hexcolor('#c70000'), size: 30),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        actions: [
          IconButton(
            tooltip: 'Insert file',
            icon: SvgPicture.asset(
              'icons/upload_button.svg',
              semanticsLabel: 'Upload button',
            ),
            onPressed: null,
          )
        ],
        backgroundColor: Colors.black,
        toolbarHeight: 40,
      ),
      drawer: DrawerMenu(),
      body: Body(),
      backgroundColor: Colors.black,
    );
  }
}