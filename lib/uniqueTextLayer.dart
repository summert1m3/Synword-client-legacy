import 'package:flutter/material.dart';
import 'package:synword/widgets/layers/uniqueTextWidget.dart';
import 'movingLayer.dart';
import 'layersSetting.dart';
import 'types.dart';

class UniqueTextLayer extends MovingLayer {
  Offset _offset;
  Color _titleColor;
  OnPanUpdateCallback _onPanUpdateCallback;
  OnPanEndCallback _onPanEndCallback;
  CloseButtonCallback _closeButtonCallback;
  bool _isTitleVisible;
  bool _isCloseButtonVisible;
  Widget _widget;

  UniqueTextLayer.zero() {
    _offset = Offset.zero;
    _titleColor = UniqueTextTitleColor;
    _isTitleVisible = true;
    _isCloseButtonVisible = true;
    _onPanUpdateCallback = null;
    _onPanEndCallback = null;
    _closeButtonCallback = null;
    build();
  }

  UniqueTextLayer.common(this._offset) {
    _titleColor = UniqueTextTitleColor;
    _isTitleVisible = true;
    _isCloseButtonVisible = true;
    _onPanUpdateCallback = null;
    _onPanEndCallback = null;
    _closeButtonCallback = null;
    build();
  }

  UniqueTextLayer(this._offset, this._titleColor, this._isTitleVisible, this._isCloseButtonVisible, this._onPanUpdateCallback, this._onPanEndCallback, this._closeButtonCallback) {
    build();
  }

  void build() {
    _widget = UniqueTextWidget(
        _offset,
        _titleColor,
        _isTitleVisible,
        _isCloseButtonVisible,
        _onPanUpdateCallback,
        _onPanEndCallback,
        _closeButtonCallback
    );
  }

  void setTitleColor(Color value) {
    _titleColor = value;
    build();
  }

  void setTitleVisible(bool value) {
    _isTitleVisible = value;
    build();
  }

  void setCloseButtonVisible(bool value) {
    _isCloseButtonVisible = value;
    build();
  }

  void setOnPanUpdateCallback(OnPanUpdateCallback value) {
    _onPanUpdateCallback = value;
    build();
  }

  void setOnPanEndCallback(OnPanEndCallback value) {
    _onPanEndCallback = value;
    build();
  }

  void setCloseButtonCallback(CloseButtonCallback value) {
    _closeButtonCallback = value;
    build();
  }

  void setOffset(Offset value) {
    _offset = value;
    build();
  }

  Color getDefaultColor() {
    return UniqueTextTitleColor;
  }

  Offset getOffset() {
    return _offset;
  }

  Widget getWidget() {
    return _widget;
  }
}
