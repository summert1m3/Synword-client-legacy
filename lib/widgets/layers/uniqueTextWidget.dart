import 'package:flutter/material.dart';
import 'package:synword/widgets/bodyLayer.dart';
import 'package:synword/widgets/layerTitle.dart';
import 'package:synword/types.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

class UniqueTextWidget extends StatelessWidget {
  final Widget _widget;
  final String _uniqueText;
  final Offset _offset;
  final Color _titleColor;
  final OnPanUpdateCallback _gestureDetectorOnPanUpdateCallback;
  final OnPanEndCallback _gestureDetectorOnPanEndCallback;
  final CloseButtonCallback _closeButtonCallback;
  final bool _isTitleVisible;
  final bool _isCloseButtonVisible;

  UniqueTextWidget(
    this._widget,
    this._uniqueText,
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
          _widget,
          LayerTitle(
              Text('uniqueTextHeader', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black)).tr(),
              _titleColor,
              Colors.black.withOpacity(0.4),
              _isTitleVisible,
              _isCloseButtonVisible,
              _closeButtonCallback,
              additionalButton: Material(
                color: Colors.transparent,
                child: IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  splashRadius: 23,
                  icon: Icon(Icons.content_copy),
                  onPressed: () {
                    Clipboard.setData(new ClipboardData(text: _uniqueText ?? ''));
                  }
                ),
              )
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
