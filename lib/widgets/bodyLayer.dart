import 'package:flutter/material.dart';
import 'package:synword/widgets/layerTitle.dart';
import 'package:synword/types.dart';

class BodyLayer extends StatelessWidget {
  final Widget _widget;
  final LayerTitle _title;
  final bool _isTitleVisible;
  final bool _isGestureDetectorEnable;
  final OnPanUpdateCallback _onPanUpdateCallback;
  final OnPanEndCallback _onPanEndCallback;
  final OnPanDownCallback _onPanDownCallback;

  BodyLayer(
    this._widget,
    this._title,
    this._isTitleVisible,
    this._isGestureDetectorEnable,
    this._onPanUpdateCallback,
    this._onPanEndCallback,
    this._onPanDownCallback
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: GestureDetector(
        child: Column(
          children: [
            Visibility(
              child: _title,
              visible: _isTitleVisible,
            ),
            Expanded(
              child: Container(
                child: _widget,
              ),
            )
          ],
        ),
        onPanDown: _onPanDownCallback,
        onPanUpdate: (details) {
          if (_isGestureDetectorEnable) {
            _onPanUpdateCallback(Offset(details.delta.dx, details.delta.dy));
          }
        },
        onPanEnd: (details) {
          if (_isGestureDetectorEnable) {
            _onPanEndCallback(details.velocity.pixelsPerSecond);
          }
        },
      )
    );
  }
}
