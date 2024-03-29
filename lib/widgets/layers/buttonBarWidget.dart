import 'package:flutter/material.dart';
import 'package:synword/widgets/bodyButtonBar.dart';
import 'package:synword/types.dart';

class ButtonBarWidget extends StatelessWidget {
  final bool _isFirstFloatingActionButtonVisible;
  final bool _isSecondFloatingActionButtonVisible;
  final FloatingActionButtonCallback? _firstButtonCallback;
  final FloatingActionButtonCallback? _secondButtonCallback;

  ButtonBarWidget(
    this._isFirstFloatingActionButtonVisible,
    this._isSecondFloatingActionButtonVisible,
    this._firstButtonCallback,
    this._secondButtonCallback
  );

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: MediaQuery.of(context).copyWith().size.height - 175,
        child: BodyButtonBar(
            _isFirstFloatingActionButtonVisible,
            _isSecondFloatingActionButtonVisible,
            _firstButtonCallback,
            _secondButtonCallback
        )
    );
  }
}
