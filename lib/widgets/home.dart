import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synword/userData/model/userData.dart';
import 'package:synword/widgets/drawerMenu/drawerMenu.dart';
import 'package:synword/widgets/body.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:synword/widgets/documentHandle/uploadButtonWidget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class Home extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leadingWidth: (screenSize.height / 14) + (screenSize.width / 14),
        title: Consumer<UserData>(builder: (context, data, child) {
          return Text(
            'synword',
            style: TextStyle(
                fontFamily: 'Waxe',
                fontSize: 24.2.sp,
                letterSpacing: 1.5,
                color: data.isPremium ? HexColor('#CEA448') : Colors.white),
          );
        }),
        centerTitle: true,
        leading: IconButton(
          tooltip: 'Menu',
          icon: SvgPicture.asset(
            'icons/menu.svg',
            height: (screenSize.height / 61 + screenSize.width / 61),
            color: HexColor('#C70000'),
          ),
          onPressed: () => {_scaffoldKey.currentState?.openDrawer()},
        ),
        actions: [
          IconButton(
            tooltip: 'Insert file',
            icon: SvgPicture.asset(
              'icons/upload_button.svg',
              height: (screenSize.height / 27 + screenSize.width / 27),
              semanticsLabel: 'Upload button',
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return UploadFileUI();
                  });
            },
          ),
          SizedBox(
            width: 10,
            height: 10,
          ),
        ],
        backgroundColor: Colors.black,
      ),
      drawer: DrawerMenu(),
      body: Body(_scaffoldKey),
      backgroundColor: Colors.black,
    );
  }
}
