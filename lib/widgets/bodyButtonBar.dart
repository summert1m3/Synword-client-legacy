import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:synword/types.dart';

class BodyButtonBar extends StatelessWidget {
  final bool _isFirstFloatingActionButtonVisible;
  final bool _isSecondFloatingActionButtonVisible;
  final FloatingActionButtonCallback _firstButtonCallback;
  final FloatingActionButtonCallback _secondButtonCallback;

  BodyButtonBar(
    this._isFirstFloatingActionButtonVisible,
    this._isSecondFloatingActionButtonVisible,
    this._firstButtonCallback,
    this._secondButtonCallback
  );
  
  bool _getSizedBoxVisible() {
    bool isSizedBoxVisible;

    if (!_isFirstFloatingActionButtonVisible || !_isSecondFloatingActionButtonVisible) {
      isSizedBoxVisible = false;
    } else {
      isSizedBoxVisible = true;
    }

    return isSizedBoxVisible;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: MediaQuery.of(context).copyWith().size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            child: Column(
              children: [
                Container(
                  width: (screenSize.width+screenSize.height)/20,
                  child: FloatingActionButton(
                      child: SvgPicture.asset(
                        'icons/check_button.svg',
                        color: Colors.black,
                        semanticsLabel: 'Check button',
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      onPressed: _firstButtonCallback
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: (screenSize.height + screenSize.width) / 280),
                  child: Text('CHECK', style: TextStyle(fontSize: screenSize.height / 60, fontFamily: 'Audrey', fontWeight: FontWeight.bold, color: Colors.black)),
                )
              ],
            ),
            visible: _isFirstFloatingActionButtonVisible,
          ),
          Visibility(
            child: SizedBox(
              width: 30,
            ),
            visible: _getSizedBoxVisible(),
          ),
          Visibility(
            child: Column(
              children: [
                Container(
                  width: (screenSize.width+screenSize.height)/20,
                  child: FloatingActionButton(
                      child: SvgPicture.asset(
                        'icons/up_button.svg',
                        color: Colors.black,
                        semanticsLabel: 'Up button',
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      onPressed: _secondButtonCallback
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: (screenSize.height + screenSize.width) / 280),
                  child: Text('UP', style: TextStyle(fontSize: screenSize.height / 50, fontFamily: 'Audrey', fontWeight: FontWeight.bold, color: Colors.black)),
                )
              ],
            ),
            visible: _isSecondFloatingActionButtonVisible,
          )
        ],
      ),
    );
  }
}
