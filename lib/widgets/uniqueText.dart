import 'package:flutter/material.dart';
import 'package:synword/model/json/uniqueUpData.dart';

class UniqueText extends StatelessWidget {
  final UniqueUpData _uniqueUpData;
  final Offset _offset;

  UniqueText(
    this._uniqueUpData,
    this._offset
  );

  double _getSizedBoxHeight(BuildContext context) {
    double height = (MediaQuery.of(context).copyWith().size.height - 157) - _offset.dy;

    if (height < 0) {
      height = 0;
    }

    return height;
  }

  List<TextSpan> _getTextSpans() {
    List<TextSpan> textSpans = List<TextSpan>();

    if (_uniqueUpData != null) {
      int start = 0;
      String text = "";

      if (_uniqueUpData.replaced.length > 0) {
        if (_uniqueUpData.replaced[0].startIndex > 0) {
          text = _uniqueUpData.text.substring(start, _uniqueUpData.replaced[0].startIndex);
          textSpans.add(TextSpan(text: text, style: TextStyle(color: Colors.black)));
          start = _uniqueUpData.replaced[0].startIndex;
        }
      }

      for (int i = 0; i < _uniqueUpData.replaced.length; i++) {
        text = _uniqueUpData.text.substring(start, _uniqueUpData.replaced[i].endIndex + 1);
        textSpans.add(TextSpan(text: text, style: TextStyle(color: Colors.red)));
        start = _uniqueUpData.replaced[i].endIndex + 1;

        if (i + 1 < _uniqueUpData.replaced.length) {
          text = _uniqueUpData.text.substring(start, _uniqueUpData.replaced[i + 1].startIndex);
          textSpans.add(TextSpan(text: text, style: TextStyle(color: Colors.black)));
          start = _uniqueUpData.replaced[i + 1].startIndex;
        }
      }

      if (start != _uniqueUpData.text.length - 1) {
        text = _uniqueUpData.text.substring(start, _uniqueUpData.text.length);
        textSpans.add(TextSpan(text: text, style: TextStyle(color: Colors.black)));
      }
    }

    return textSpans;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Scrollbar(
            thickness: 5,
            radius: Radius.circular(10),
            child: SingleChildScrollView(
              child: SelectableText.rich(
                  TextSpan(
                      style: TextStyle(fontSize: 20),
                      children: _getTextSpans()
                  )
              ),
            ),
          ),
        ),
        width: MediaQuery.of(context).copyWith().size.width - 20,
        height: _getSizedBoxHeight(context),
    );
  }
}