import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:synword/model/json/uniqueUpData.dart';
import 'package:sizer/sizer.dart';
import 'package:synword/userData/userTextData.dart';
import 'package:validators/validators.dart';

class ChoiceSynonymsDialogItem extends StatelessWidget {
  final String _word;
  final Function(String) _onTap;

  ChoiceSynonymsDialogItem(this._word, this._onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) => _onTap(_word),
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
        child: Text(_word, style: TextStyle(color: Colors.white, fontSize: 14.0.sp, fontFamily: 'Roboto')),
      ),
    );
  }
}

class ChoiceSynonymsDialog extends StatelessWidget {
  final List<String> _synonyms;
  final Function(String) _onTap;

  ChoiceSynonymsDialog(this._synonyms, this._onTap);

  List<Widget> _buildItems() {
    List<Widget> items = <Widget>[];

    for (int i = 0; i < _synonyms.length; i++) {
      items.add(ChoiceSynonymsDialogItem(_synonyms[i], _onTap));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 5.0.w,
        maxHeight: 25.0.h
      ),
      child: RawScrollbar(
        isAlwaysShown: true,
        thumbColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: _buildItems(),
          ),
        ),
      ),
    );
  }
}

class UniqueText extends StatefulWidget {
  final UniqueUpData? _uniqueUpData;
  final Offset _offset;

  UniqueText({required UniqueUpData? uniqueUpData, required Offset offset})
    : _uniqueUpData = uniqueUpData,
      _offset = offset;

  @override
  State<StatefulWidget> createState() {
    return _UniqueTextState(_uniqueUpData, _offset);
  }
}

class _UniqueTextState extends State<UniqueText> {
  UniqueUpData? _uniqueUpData;
  Offset _offset;

  _UniqueTextState(
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
    List<TextSpan> textSpans = <TextSpan>[];

    if (_uniqueUpData != null) {
      int start = 0;
      String text = "";

      if (_uniqueUpData!.replaced.length > 0) {
        if (_uniqueUpData!.replaced[0].word.startIndex > 0) {
          text = _uniqueUpData!.text.substring(start, _uniqueUpData!.replaced[0].word.startIndex);
          textSpans.add(TextSpan(text: text, style: TextStyle(color: Colors.black)));
          start = _uniqueUpData!.replaced[0].word.startIndex;
        }
      }

      for (int i = 0; i < _uniqueUpData!.replaced.length; i++) {
        text = _uniqueUpData!.text.substring(start, _uniqueUpData!.replaced[i].word.endIndex + 1);

        textSpans.add(TextSpan(
            text: text,
            style: TextStyle(color: Colors.red),
            recognizer: TapGestureRecognizer()..onTap = () async {
              await showDialog<void>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: HexColor('#2B2B2B'),
                      content: ChoiceSynonymsDialog(
                          _uniqueUpData!.replaced[i].synonyms,
                          (String word) {
                            setState(() {
                              String oldWord = _uniqueUpData!.text.substring(_uniqueUpData!.replaced[i].word.startIndex, _uniqueUpData!.replaced[i].word.endIndex + 1);
                              int difference = word.length - oldWord.length;

                              if (isUppercase(oldWord[0])) {
                                word = word.replaceRange(0, 1, word[0].toUpperCase());
                              }

                              _uniqueUpData!.text = _uniqueUpData!.text.replaceRange(_uniqueUpData!.replaced[i].word.startIndex, _uniqueUpData!.replaced[i].word.endIndex + 1, word);

                              _uniqueUpData!.replaced[i].word.endIndex += difference;

                              for (int j = i + 1; j < _uniqueUpData!.replaced.length; j++) {
                                _uniqueUpData!.replaced[j].word.startIndex += difference;
                                _uniqueUpData!.replaced[j].word.endIndex += difference;
                              }

                              UserTextData.uniqueText = _uniqueUpData!.text;

                              Navigator.of(context).pop();
                            });
                          }
                      ),
                    );
                  }
              );
            })
        );

        start = _uniqueUpData!.replaced[i].word.endIndex + 1;

        if (i + 1 < _uniqueUpData!.replaced.length) {
          text = _uniqueUpData!.text.substring(start, _uniqueUpData!.replaced[i + 1].word.startIndex);
          textSpans.add(TextSpan(text: text, style: TextStyle(color: Colors.black)));
          start = _uniqueUpData!.replaced[i + 1].word.startIndex;
        }
      }

      if (start != _uniqueUpData!.text.length - 1) {
        text = _uniqueUpData!.text.substring(start, _uniqueUpData!.text.length);
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
                      style: TextStyle(fontSize: 20, fontFamily: 'Roboto'),
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