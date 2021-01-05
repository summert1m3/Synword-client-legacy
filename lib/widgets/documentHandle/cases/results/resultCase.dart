import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:synword/widgets/documentHandle/documentData.dart';
import 'docUniqueUpResult.dart';
import 'docUniqueCheckResult.dart';
import 'docUpAndCheckResult.dart';

class ResultCase extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ResultCaseState();
}

class _ResultCaseState extends State<ResultCase> {
  Widget result;

  @override
  void initState() {
    super.initState();
    if (docData.uniqueCheck == true && docData.uniqueUp == true) {
      result = ResultsCase();
    }
    if (docData.uniqueCheck == false && docData.uniqueUp == true) {
      result = UniqueUpResult();
    }
    if (docData.uniqueCheck == true && docData.uniqueUp == false) {
      result = UniqueCheckResult();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: HexColor('#262626'),
      content: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 1.8,
        child: result,
      ),
    );
    }
}