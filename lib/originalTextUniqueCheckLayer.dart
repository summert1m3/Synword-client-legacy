import 'package:flutter/material.dart';
import 'package:synword/widgets/layers/uniqueCheckWidget.dart';
import 'package:synword/widgets/textUniqueCheck.dart';
import 'layersSetting.dart';
import 'movingLayer.dart';
import 'types.dart';

class OriginalTextUniqueCheckLayer extends MovingLayer {
  Offset _offset;
  double _progress;
  Color _titleColor;
  OnPanUpdateCallback _onPanUpdateCallback;
  OnPanEndCallback _onPanEndCallback;
  CloseButtonCallback _closeButtonCallback;
  bool _isTitleVisible;
  bool _isCloseButtonVisible;
  Widget _widget;

  OriginalTextUniqueCheckLayer.zero() {
    _offset = Offset.zero;
    _progress = 0;
    _titleColor = UniqueCheckTitleColor;
    _onPanUpdateCallback = null;
    _onPanEndCallback = null;
    _closeButtonCallback = null;
    _isTitleVisible = true;
    _isCloseButtonVisible = true;
    build();
  }

  OriginalTextUniqueCheckLayer.common(this._offset, this._progress) {
    _titleColor = UniqueCheckTitleColor;
    _isTitleVisible = true;
    _isCloseButtonVisible = true;
    _onPanUpdateCallback = null;
    _onPanEndCallback = null;
    _closeButtonCallback = null;
    build();
  }

  OriginalTextUniqueCheckLayer(this._offset, this._progress, this._titleColor, this._isTitleVisible, this._isCloseButtonVisible, this._onPanUpdateCallback, this._onPanEndCallback, this._closeButtonCallback) {
    build();
  }

  void build() {
    _widget = UniqueCheckWidget(
        TextUniqueCheck(_offset, _progress),
        _offset,
        _titleColor,
        _isTitleVisible,
        _isCloseButtonVisible,
        _onPanUpdateCallback,
        _onPanEndCallback,
        _closeButtonCallback
    );
  }

  void setProgress(double value) {
    _progress = value;
    build();
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
    return UniqueCheckTitleColor;
  }

  Offset getOffset() {
    return _offset;
  }

  Widget getWidget() {
    return _widget;
  }
}
