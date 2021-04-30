import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synword/widgets/documentHandle/cases/startCase.dart';
import 'package:synword/widgets/documentHandle/documentHandlerData.dart';

class UploadFileUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UploadFileUIState();
}

class _UploadFileUIState extends State<UploadFileUI> {
  Widget _widget = StartCase();

  @override
  Widget build(BuildContext context) {
    var updateMainState = (Widget widget) {
      setState(() {
        this._widget = widget;
      });
    };
    return Provider(
      create: (_) => DocumentHandlerData(updateMainState),
      child: _widget,
    );
  }
}
