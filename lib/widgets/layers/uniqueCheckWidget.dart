import 'package:flutter/material.dart';
import 'package:synword/widgets/bodyLayer.dart';
import 'package:synword/widgets/layerTitle.dart';
import 'package:synword/types.dart';

class UniqueCheckWidget extends StatelessWidget {
  final Widget _widget;
  final Offset _offset;
  final Color _titleColor;
  final OnPanUpdateCallback _gestureDetectorOnPanUpdateCallback;
  final OnPanEndCallback _gestureDetectorOnPanEndCallback;
  final CloseButtonCallback _closeButtonCallback;
  final bool _isTitleVisible;
  final bool _isCloseButtonVisible;

  UniqueCheckWidget(
    this._widget,
    this._offset,
    this._titleColor,
    this._isTitleVisible,
    this._isCloseButtonVisible,
    this._gestureDetectorOnPanUpdateCallback,
    this._gestureDetectorOnPanEndCallback,
    this._closeButtonCallback
  );

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _offset.dy,
      child: BodyLayer(
          SizedBox(
              child: _widget,
              width: MediaQuery.of(context).copyWith().size.width - 20,
              height: MediaQuery.of(context).copyWith().size.height
          ),
          LayerTitle(
              Text('Unique check', style: TextStyle(fontSize: 25, fontFamily: 'Audrey', fontWeight: FontWeight.bold, color: Colors.black)),
              _titleColor,
              Colors.black.withOpacity(0.3),
              _isTitleVisible,
              _isCloseButtonVisible,
              _closeButtonCallback
          ),
          true,
          true,
          _gestureDetectorOnPanUpdateCallback,
          _gestureDetectorOnPanEndCallback
      ),
    );
  }
}
