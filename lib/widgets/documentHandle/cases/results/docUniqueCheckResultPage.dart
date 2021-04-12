import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../uniqueCheckLinks.dart';
import '../../../waveBar.dart';
import '../../documentData.dart';
import 'package:easy_localization/easy_localization.dart';

class DocUniqueCheckResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 8.0.h,
        title: Text('uniqueCheckHeader', style: TextStyle(fontSize: 18.0.sp)).tr(),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: WaveBar(docData.uniqueCheckData.percent / 100),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: UniqueCheckLinks(
                docData.uniqueCheckData,
                screenSize.height - (screenSize.height / 1.8),
                textColor: Colors.black,
                scheme: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
