import 'package:flutter/material.dart';
import 'package:synword/widgets/layerTitle.dart';

typedef GestureDetectorCallback = void Function(Offset offset);

class BodyLayer extends StatelessWidget {
  final Widget _widget;
  final LayerTitle _title;
  final bool _isTitleVisible;
  final bool _isGestureDetectorEnable;
  final GestureDetectorCallback _gestureDetectorCallback;

  BodyLayer(
      this._widget,
      this._title,
      this._isTitleVisible,
      this._isGestureDetectorEnable,
      this._gestureDetectorCallback
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: GestureDetector(
        child: Column(
          children: [
            Visibility(
              child: _title,
              visible: _isTitleVisible,
            ),
            Container(
              child: _widget,
            )
          ],
        ),
        onPanUpdate: (details) {
          if (_isGestureDetectorEnable) {
            _gestureDetectorCallback(Offset(details.delta.dx, details.delta.dy));
          }
        },
      )
    );
  }
}
