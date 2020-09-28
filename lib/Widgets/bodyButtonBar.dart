import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef FloatingActionButtonCallback = void Function();

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
  
  bool getSizedBoxVisible() {
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
    return Container(
      width: MediaQuery.of(context).copyWith().size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
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
            visible: _isFirstFloatingActionButtonVisible,
          ),
          Visibility(
            child: SizedBox(
              width: 30,
            ),
            visible: getSizedBoxVisible(),
          ),
          Visibility(
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
            visible: _isSecondFloatingActionButtonVisible,
          )
        ],
      ),
    );
  }
}
