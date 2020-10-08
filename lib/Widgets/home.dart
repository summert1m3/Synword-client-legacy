import 'package:flutter/material.dart';
import 'package:synword/widgets/body.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'synword',
          style: TextStyle(fontFamily: 'Waxe', fontSize: 33, letterSpacing: 1.5),
        ),
        centerTitle: true,
        leading: IconButton(
          tooltip: 'Menu',
          icon: Icon(Icons.menu, color: Hexcolor('#840200')),
          onPressed: null,
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
      body: Body(),
      backgroundColor: Colors.black,
    );
  }
}
