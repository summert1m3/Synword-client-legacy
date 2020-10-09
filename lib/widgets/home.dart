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
        leadingWidth: 80,
        title: Text(
          'synword',
          style: TextStyle(fontFamily: 'Waxe', fontSize: 33, letterSpacing: 1.5),
        ),
        centerTitle: true,
        leading: IconButton(
          tooltip: 'Menu',
          icon: SvgPicture.asset(
            'icons/menu.svg',
            width: 18,
            height: 18,
          ),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        actions: [

          IconButton(
            tooltip: 'Insert file',
            icon: SvgPicture.asset(
              'icons/upload_button.svg',
              semanticsLabel: 'Upload button',
            ),
            onPressed: ()=>{},
          ),
          SizedBox(
            width: 10,
            height: 10,
          ),
        ],
        backgroundColor: Colors.black,
        //toolbarHeight: 50,
      ),
      drawer: DrawerMenu(),
      body: Body(),
      backgroundColor: Colors.black,
    );
  }
}