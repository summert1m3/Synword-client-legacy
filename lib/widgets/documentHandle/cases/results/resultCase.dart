import 'package:flutter/material.dart';
import 'package:synword/widgets/documentHandle/cases/results/docUniqueCheckResultPage.dart';
import 'package:synword/widgets/documentHandle/cases/results/docUniqueUpResultPage.dart';
import 'package:synword/widgets/documentHandle/documentHandlerData.dart';
import 'docUpAndCheckResult.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class ResultCase extends StatelessWidget {
  late final Widget _result;

  ResultCase(){
    if (DocumentHandlerData.uniqueCheck == true && DocumentHandlerData.uniqueUp == true) {
      _result = ResultsCase();
    }
    if (DocumentHandlerData.uniqueCheck == false && DocumentHandlerData.uniqueUp == true) {
      _result = DocUniqueUpResultPage();
    }
    if (DocumentHandlerData.uniqueCheck == true && DocumentHandlerData.uniqueUp == false) {
      _result = DocUniqueCheckResultPage();
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: _result
      ),
    );
  }
}
