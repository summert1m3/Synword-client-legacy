import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:synword/widgets/drawerMenu/pages/functions/functions.dart';

class SubscribedPage extends StatelessWidget {
  static Function setState;
  static BuildContext context;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      SubscribedPage.setState = () => setState(() {});
      SubscribedPage.context = context;
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: (screenSize.height / 10 + screenSize.width / 10),
          title: SvgPicture.asset(
            'icons/premiumPage/crown.svg',
            height: (screenSize.height / 11 + screenSize.width / 11),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle),
              iconSize: 40,
              onPressed: () => showUserProfileDialog(context),
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
          ),
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, size: 20.0.h, color: Colors.lightGreen,),
                  SizedBox(
                    height: 5.0.h,
                  ),
                  Text('Thanks for subscribtion', style: TextStyle(fontSize: 17.0.sp),),
                ],
              ),
          ),
        ),
      );
    });
  }
}
