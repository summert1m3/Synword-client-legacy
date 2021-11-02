import 'package:flutter/material.dart';
import 'package:synword/widgets/bodyLayer.dart';
import 'package:synword/widgets/layerTitle.dart';
import 'package:synword/types.dart';
import 'package:easy_localization/easy_localization.dart';

class UniqueCheckWidget extends StatelessWidget {
  final Widget _widget;
  final Offset _offset;
  final Color _titleColor;
  final OnPanUpdateCallback? _gestureDetectorOnPanUpdateCallback;
  final OnPanEndCallback? _gestureDetectorOnPanEndCallback;
  final CloseButtonCallback? _closeButtonCallback;
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
    return AnimatedPositioned(
      duration: Duration(microseconds: 0),
      top: _offset.dy,
      child: BodyLayer(
          _widget,
          LayerTitle(
              Text('uniqueCheckHeader', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black)).tr(),
              _titleColor,
              Colors.black.withOpacity(0.4),
              _isTitleVisible,
              _isCloseButtonVisible,
              _closeButtonCallback
          ),
          true,
          true,
          _gestureDetectorOnPanUpdateCallback,
          _gestureDetectorOnPanEndCallback,
          (details) {
            FocusScope.of(context).requestFocus(FocusNode());
          }
      ),
    );
  }
}
