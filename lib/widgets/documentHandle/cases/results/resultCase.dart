import 'package:flutter/material.dart';
import 'package:synword/widgets/documentHandle/cases/results/docUniqueCheckResultPage.dart';
import 'package:synword/widgets/documentHandle/cases/results/docUniqueUpResultPage.dart';
import 'package:synword/widgets/documentHandle/cases/results/resultsPage.dart';
import 'package:synword/widgets/documentHandle/documentHandlerData.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class ResultCase extends StatelessWidget {

  Widget? _getResultWidget(DocumentHandlerData docData){
    if (docData.uniqueCheck == true && docData.uniqueUp == true) {
      return ResultsPage();
    }
    if (docData.uniqueCheck == false && docData.uniqueUp == true) {
      return DocUniqueUpResultPage();
    }
    if (docData.uniqueCheck == true && docData.uniqueUp == false) {
      return DocUniqueCheckResultPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    var docData = context.read<DocumentHandlerData>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 8.0.h,
        title: Text('resultHeader', style: TextStyle(fontSize: 18.0.sp)).tr(),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
        ),
        child: _getResultWidget(docData)
      ),
    );
  }
}
