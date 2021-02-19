import 'package:flutter/material.dart';
import 'package:synword/types.dart';
import 'package:easy_localization/easy_localization.dart';

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
                    heroTag: "btn1",
                      child: Image(
                        image: AssetImage('icons/check_button.png'),
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      onPressed: _firstButtonCallback
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3)
                  ),
                  padding: EdgeInsets.only(top: (screenSize.height + screenSize.width) / 280),
                  child: Text('uniqueCheckButton', style: TextStyle(fontSize: screenSize.height / 60, fontWeight: FontWeight.bold, color: Colors.black)).tr(),
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
                    heroTag: "btn2",
                      child: Image(
                        image: AssetImage('icons/up_button.png'),
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      onPressed: _secondButtonCallback
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3)
                  ),
                  padding: EdgeInsets.only(top: (screenSize.height + screenSize.width) / 280),
                  child: Text('uniqueUpButton', style: TextStyle(fontSize: screenSize.height / 60, fontWeight: FontWeight.bold, color: Colors.black)).tr(),
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
